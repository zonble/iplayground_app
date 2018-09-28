import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iplayground/schedule_loader.dart';
import 'package:html2md/html2md.dart' as html2md;
import 'package:flutter_markdown/flutter_markdown.dart';

class ScheduleItemPage extends StatelessWidget {
  final ScheduleItem data;

  ScheduleItemPage({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var text = this.data.description;
    if (text.contains('<p>') || text.contains('<h4>')) {
      text = html2md.convert(text);
    }

    final listview = SliverList(
      delegate: SliverChildListDelegate([
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            this.data.title,
            style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              top: 4.0, bottom: 4.0, left: 8.0, right: 8.0),
          child: Text(this.data.presenter),
        ),
        Padding(
          padding: const EdgeInsets.only(
              top: 4.0, bottom: 4.0, left: 8.0, right: 8.0),
          child: Text(
              '第 ${this.data.day} 天  ${this.data.startTime} - ${this.data.endTime}'),
        ),
        Padding(
          padding: const EdgeInsets.only(
              top: 4.0, bottom: 4.0, left: 8.0, right: 8.0),
          child: Text(this.data.roomName),
        ),
        Divider(),
        Padding(
            padding: const EdgeInsets.only(
                left: 8.0, right: 8.0, top: 18.0, bottom: 20.0),
            child: MarkdownBody(data: text))
      ]),
    );

    return Scaffold(
      appBar: CupertinoNavigationBar(),
      body: Scrollbar(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 640.0),
            child: CustomScrollView(
              slivers: <Widget>[listview],
            ),
          ),
        ),
      ),
    );
  }
}
