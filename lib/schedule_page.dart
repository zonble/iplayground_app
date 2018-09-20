import 'package:flutter/material.dart';

class ScheduleItem extends StatelessWidget {
  final Map<dynamic, dynamic> data;

  ScheduleItem({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              data["topic"],
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(data["presenter"], textAlign: TextAlign.center),
          )
        ],
      ),
    );
  }
}

class ScheduleRow extends StatelessWidget {
  final Map<dynamic, dynamic> data;
  final bool hasDivider;

  ScheduleRow({Key key, this.data, this.hasDivider = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var widgets = <Widget>[];
    var dateColumn = Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Text(this.data["start"]),
            Text(this.data["end"]),
          ],
        ),
      ),
    );
    widgets.add(dateColumn);

    if (this.data["rest"] != null) {
      var rest = Expanded(
        flex: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[Text(this.data["rest"])],
        ),
      );
      widgets.add(rest);
    }
    if (this.data["talks"] != null) {
      final List talks = this.data["talks"];
      widgets.add(ScheduleItem(
        data: talks[0],
      ));

      if (talks.length == 1) {
        final empty = Expanded(
          flex: 2,
          child: Container(),
        );
        widgets.add(empty);
      } else if (talks.length == 2) {
        widgets.add(ScheduleItem(
          data: talks[1],
        ));
      }
    }

    var children = <Widget>[];
    if (hasDivider) {
      children.add(Divider(
        height: 10.0,
        color: Colors.black,
      ));
    }
    children.add(Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: widgets,
    ));

    return Container(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: children,
        ),
      ),
    );
  }
}

class SchedulePage extends StatelessWidget {
  final String title;
  final List<Map> schedule;

  SchedulePage({Key key, this.title, this.schedule}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var slivers = <Widget>[];

    slivers.add(SliverAppBar(
      title: Text(this.title),
    ));

    final list = SliverList(
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        var data = this.schedule[index];
        return ScheduleRow(
          data: data,
          hasDivider: (index > 0),
        );
      }, childCount: this.schedule.length),
    );
    slivers.add(list);
    final customScrollView = CustomScrollView(
      slivers: slivers,
    );
    return Scrollbar(child: customScrollView);
  }
}
