import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iplayground/schedule_loader.dart';

class ScheduleCell extends StatelessWidget {
  final ScheduleItem data;
  final int flex;

  ScheduleCell({Key key, this.data, this.flex = 2}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: this.flex,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              data.title,
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(data.presenter, textAlign: TextAlign.center),
          )
        ],
      ),
    );
  }
}

class ScheduleRow extends StatelessWidget {
  final ScheduleContainer data;
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
            Text(this.data.startTime),
            Text(this.data.endTime),
          ],
        ),
      ),
    );
    widgets.add(dateColumn);

    if (this.data.all != null) {
      widgets.add(ScheduleCell(
        data: this.data.all,
        flex: 4,
      ));
    } else {
      widgets.add(ScheduleCell(
        data: this.data.a,
        flex: 2,
      ));
      widgets.add(ScheduleCell(
        data: this.data.b,
        flex: 2,
      ));
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
  final List<dynamic> schedule;

  SchedulePage({Key key, this.title, this.schedule}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var slivers = <Widget>[];

    slivers.add(CupertinoSliverNavigationBar(
      largeTitle: Text(this.title),
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
