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

const String _jsonUrl =
    'https://raw.githubusercontent.com/zonble/iplayground_app/master/data/sessions.json';

/// Loads the schedule.
class ScheduleLoader {
  /// The singleton instance.
  static ScheduleLoader shared = ScheduleLoader();

  /// The sessions in day 1.
  List<ScheduleContainer> day1;

  /// The sessions in day 2.
  List<ScheduleContainer> day2;
  StreamController _controller = StreamController.broadcast();
  StreamController _errorController = StreamController.broadcast();

  Stream get onUpdate => _controller.stream;

  Stream get onError => _errorController.stream;

  load() async {
    try {
      final response = await get(_jsonUrl);
      if (response.statusCode != 200) {
        throw Exception('Failed to load');
      }
      Map schedule = json.decode(response.body);
      final days = ScheduleLoader._parse(schedule);
      this.day1 = days[0];
      this.day2 = days[1];
      _controller.add(this);
    } catch (error) {
      _errorController.add(error);
    }
  }

  static List<List<ScheduleContainer>> _parse(Map<String, dynamic> map) {
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
}
