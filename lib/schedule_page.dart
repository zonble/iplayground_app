import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iplayground/schedule_session_page.dart';
import 'package:iplayground/schedule_loader.dart';

class ScheduleCell extends StatelessWidget {
  final Session data;
  final int flex;

  ScheduleCell({Key key, this.data, this.flex = 2}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var children = <Widget>[];
    bool hasLink = data.proposalId != '';

    final title = Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        data.title,
        style: TextStyle(
            fontSize: 20.0,
            color: hasLink ? Theme.of(context).primaryColor : Colors.black),
        textAlign: TextAlign.center,
      ),
    );
    children.add(title);

    if (data.presenter.length > 0) {
      final presenter = Padding(
        padding: const EdgeInsets.only(top: 2.0, bottom: 10.0),
        child: Text(data.presenter, textAlign: TextAlign.center),
      );
      children.add(presenter);
    }

    final column = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );

    Widget child;
    if (hasLink) {
      child = Material(
        color: Colors.transparent,
        child: InkWell(
          key: Key(data.proposalId),
          child: column,
          onTap: () {
            final program = ScheduleLoader.shared.getProgramById(this.data.proposalId);
            final route = CupertinoPageRoute(builder: (context) {
              SessionPage page = SessionPage(
                session: data,
                program: program,
              );
              return page;
            });
            Navigator.of(context).push(route);
          },
        ),
      );
    } else {
      child = column;
    }

    return Expanded(flex: this.flex, child: child);
  }
}

class ScheduleRow extends StatelessWidget {
  final ScheduleContainer data;
  final bool hasDivider;

  ScheduleRow({Key key, this.data, this.hasDivider = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var widgets = <Widget>[];
    var timeColumn = Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Text(
              this.data.startTime,
              style: TextStyle(color: Colors.grey),
            ),
            Text(
              this.data.endTime,
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
    widgets.add(timeColumn);

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
        color: Colors.grey,
      ));
    }
    children.add(Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    ));

    return Container(
      child: Column(
        children: children,
      ),
    );
  }
}

typedef double GetOffsetMethod();
typedef void SetOffsetMethod(double offset);

class SchedulePage extends StatefulWidget {
  final String title;
  final List<dynamic> schedule;
  final GetOffsetMethod getOffsetMethod;
  final SetOffsetMethod setOffsetMethod;

  SchedulePage(
      {Key key,
      this.title,
      this.schedule,
      this.getOffsetMethod,
      this.setOffsetMethod})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => SchedulePageState();
}

class SchedulePageState extends State<SchedulePage> {
  ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController =
        new ScrollController(initialScrollOffset: widget.getOffsetMethod());
  }

  @override
  Widget build(BuildContext context) {
    var slivers = <Widget>[];

    slivers.add(CupertinoSliverNavigationBar(
      heroTag: this.widget.title,
      largeTitle: Text(this.widget.title),
    ));

    final list = SliverList(
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        var data = this.widget.schedule[index];
        return ScheduleRow(
          data: data,
          hasDivider: (index > 0),
        );
      }, childCount: this.widget.schedule.length),
    );
    slivers.add(list);
    final customScrollView = CustomScrollView(
      controller: scrollController,
      slivers: slivers,
    );
    return NotificationListener(
      child: Scrollbar(child: customScrollView),
      onNotification: (notification) {
        if (notification is ScrollNotification) {
          widget.setOffsetMethod(notification.metrics.pixels);
        }
      },
    );
  }
}
