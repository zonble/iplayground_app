import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';

class ScheduleItem {
  int day;
  String startTime;
  String endTime;
  String proposalID;
  int sessionID;
  String title;
  String presenter;
  String roomName;
  String trackName;
  String description;

  ScheduleItem.fromMap(Map<String, dynamic> map) {
    this
      ..day = map['conference_day'] ?? 0
      ..startTime = map['start_time'] ?? ''
      ..endTime = map['end_time'] ?? ''
      ..sessionID = map['session_id'] ?? 0
      ..proposalID = map['proposal_id'] ?? ''
      ..title = map['title']
      ..presenter = map['presenter']
      ..roomName = map['room_name']
      ..trackName = map['track_name']
      ..description = map['desc'];
  }
}

class ScheduleContainer {
  String startTime;
  String endTime;
  ScheduleItem a;
  ScheduleItem b;
  ScheduleItem all;
}

const String _jsonUrl =
    'https://raw.githubusercontent.com/zonble/iplayground_app/master/data/sessions.json';

class ScheduleLoader {
  static ScheduleLoader shared = ScheduleLoader();
  List<ScheduleContainer> day1;
  List<ScheduleContainer> day2;
  StreamController _controller = StreamController.broadcast();

  Stream get didUpdate => _controller.stream;

  load() async {
    final response = await get(_jsonUrl);
    if (response.statusCode != 200) {
      throw Exception('Failed to load');
    }
    Map schedule = json.decode(response.body);
    final days = ScheduleLoader._parse(schedule);
    this.day1 = days[0];
    this.day2 = days[1];
    _controller.add(this);
  }

  static List<List<ScheduleContainer>> _parse(Map<String, dynamic> map) {
    final List sessions = map['sessions'];
    if (sessions is List == false) {
      throw Exception('Unable to find sessions');
    }
    List<ScheduleItem> allItems =
        sessions.map((map) => ScheduleItem.fromMap(map)).toList();

    group(List<ScheduleItem> items) {
      List<ScheduleContainer> containerList = [];
      for (final ScheduleItem item in items) {
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

    List<ScheduleItem> allItemsInDay1 =
        allItems.where((item) => item.day == 1).toList();
    List<ScheduleItem> allItemsInDay2 =
        allItems.where((item) => item.day == 2).toList();

    List<ScheduleContainer> day1 = group(allItemsInDay1);
    List<ScheduleContainer> day2 = group(allItemsInDay2);
    return [day1, day2];
  }
}
