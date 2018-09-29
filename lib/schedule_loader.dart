import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';

/// Represents a session.
class Session {
  /// In day 1 or day 2.
  int day;

  /// When does the session start.
  String startTime;

  /// When does the session ID.
  String endTime;

  /// The ID of the proposal matching to the session.
  String proposalId;

  /// The ID of the session.
  int id;

  /// Title of the session.
  String title;

  /// Presenter of the session.
  String presenter;

  /// Which room where the session takes place.
  String roomName;

  /// Track A or B.
  String trackName;

  /// Description of the session.
  String description;

  /// Creates a new [Session] by passing [map].
  Session.fromMap(Map<String, dynamic> map) {
    this
      ..day = map['conference_day'] ?? 0
      ..startTime = map['start_time'] ?? ''
      ..endTime = map['end_time'] ?? ''
      ..id = map['session_id'] ?? 0
      ..proposalId = map['proposal_id'] ?? ''
      ..title = map['title']
      ..presenter = map['presenter']
      ..roomName = map['room_name']
      ..trackName = map['track_name']
      ..description = map['desc'];
  }
}

/// A container class which contains the sessions that take place in the same time.
class ScheduleContainer {
  /// The start time.
  String startTime;

  /// The end time.
  String endTime;

  /// The session in track A.
  Session a;

  /// The session in track B.
  Session b;

  /// The session for all audience.
  Session all;
}

class Speaker {
  String name;
  String biography;

  Speaker.fromMap(Map<String, dynamic> map) {
    this
      ..name = map['name'] ?? ''
      ..biography = map['bio'];
  }
}

class Program {
  String title;
  String abstract;
  List reviewTags;
  int id;
  String track;
  String videoUrl;
  String slideUrl;
  Map<dynamic, dynamic> customFields;
  List<Speaker> speakers;

  Program.fromMap(Map<String, dynamic> map) {
    this
      ..title = map['title'] ?? ''
      ..abstract = map['abstract'] ?? ''
      ..reviewTags = map['review_tags'] ?? []
      ..id = map['id']
      ..track = map['track'] ?? ''
      ..videoUrl = map['video_url'] ?? ''
      ..slideUrl = map['slides_url'] ?? ''
      ..customFields = map['custom_fields'] ?? {};
    final List speakerList = map['speakers'];
    this.speakers = speakerList.map((map) => Speaker.fromMap(map)).toList();
  }
}

const String _sessionJsonUrl =
    'https://raw.githubusercontent.com/zonble/iplayground_app/master/data/sessions.json';
const String _programJsonUrl =
    'https://raw.githubusercontent.com/zonble/iplayground_app/master/data/program.json';

/// Loads the schedule.
class ScheduleLoader {
  /// The singleton instance.
  static ScheduleLoader shared = ScheduleLoader();

  /// The sessions in day 1.
  List<ScheduleContainer> day1;

  /// The sessions in day 2.
  List<ScheduleContainer> day2;

  /// The programs.
  Map<String, Program> programs;

  StreamController _controller = StreamController.broadcast();
  StreamController _errorController = StreamController.broadcast();

  /// Broadcasts that the loader is updated.
  Stream get onUpdate => _controller.stream;

  /// Broadcasts that the loader encounters errors.
  Stream get onError => _errorController.stream;

  load() async {
    try {
      final sessionResponse = await get(_sessionJsonUrl);
      if (sessionResponse.statusCode != 200) {
        throw Exception('Failed to load');
      }
      Map scheduleMap = json.decode(sessionResponse.body);
      final days = ScheduleLoader._parseSessions(scheduleMap);
      this.day1 = days[0];
      this.day2 = days[1];

      final programResponse = await get(_programJsonUrl);
      if (programResponse.statusCode != 200) {
        throw Exception('Failed to load');
      }
      Map programMap = json.decode(programResponse.body);
      this.programs = ScheduleLoader._parseProgram(programMap);

      _controller.add(this);
    } catch (error) {
      print(error);
      _errorController.add(error);
    }
  }

  Program getProgramById(String proposalId) {
    Program program = this.programs[proposalId];
    return program;
  }

  static List<List<ScheduleContainer>> _parseSessions(
      Map<String, dynamic> map) {
    final List sessions = map['sessions'];
    if (sessions is List == false) {
      throw Exception('Unable to find sessions');
    }
    List<Session> allItems =
        sessions.map((map) => Session.fromMap(map)).toList();

    group(List<Session> items) {
      List<ScheduleContainer> containerList = [];
      for (final Session item in items) {
        String startTime = item.startTime;
        var containers =
            containerList.where((item) => item.startTime == startTime).toList();
        var container;
        if (containers.length > 0) {
          container = containers.first;
        } else {
          container = ScheduleContainer();
          container
            ..startTime = startTime
            ..endTime = item.endTime;
          containerList.add(container);
        }
        switch (item.trackName) {
          case 'A':
            container.a = item;
            break;
          case 'B':
            container.b = item;
            break;
          case '共同軌':
            container.all = item;
            break;
        }
      }
      containerList.sort((a, b) => a.startTime.compareTo(b.startTime));
      return containerList;
    }

    List<Session> allItemsInDay1 =
        allItems.where((item) => item.day == 1).toList();
    List<Session> allItemsInDay2 =
        allItems.where((item) => item.day == 2).toList();

    List<ScheduleContainer> day1 = group(allItemsInDay1);
    List<ScheduleContainer> day2 = group(allItemsInDay2);
    return [day1, day2];
  }

  static Map<String, Program> _parseProgram(Map<String, dynamic> map) {
    final List programList = map['program'];
    final List converted =
        programList.map((map) => Program.fromMap(map)).toList();
    Map<String, Program> result = {};
    for (Program program in converted) {
      result["prop_${program.id}"] = program;
    }
    return result;
  }
}
