import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iplayground/schedule_loader.dart';
import 'package:html2md/html2md.dart' as html2md;
import 'package:flutter_markdown/flutter_markdown.dart';

class SessionPage extends StatelessWidget {
  final Session session;
  final Program program;

  SessionPage({Key key, this.session, this.program}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var text = this.program.abstract;
    if (text.contains('<p>') || text.contains('<h4>')) {
      text = html2md.convert(text);
    }

    var tags = this.program.reviewTags.map((tag) {
      return Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Container(
          color: Theme.of(context).primaryColor,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              tag,
              style: TextStyle(color: Colors.white, fontSize: 15.0),
            ),
          ),
        ),
      );
    }).toList();

    List<Widget> widgets = [
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          this.session.title,
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(
            top: 4.0, bottom: 20.0, left: 10.0, right: 10.0),
        child: Text(
          this.session.presenter,
          style: TextStyle(fontSize: 20.0),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(
            top: 4.0, bottom: 4.0, left: 10.0, right: 10.0),
        child: Text(
            '第 ${this.session.day} 天  ${this.session.startTime} - ${this.session.endTime}'),
      ),
      Padding(
        padding: const EdgeInsets.only(
            top: 4.0, bottom: 4.0, left: 10.0, right: 10.0),
        child: Text('(${this.session.trackName}) - ${this.session.roomName}'),
      ),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: tags,
        ),
      ),
      Divider(
        color: Colors.black,
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          '大綱',
          style: TextStyle(fontSize: 20.0),
        ),
      ),
      Padding(
          padding: const EdgeInsets.only(
              left: 10.0, right: 10.0, top: 10.0, bottom: 20.0),
          child: MarkdownBody(data: text))
    ];
    widgets.add(Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        '講者',
        style: TextStyle(fontSize: 20.0),
      ),
    ));
    for (final speaker in this.program.speakers) {
      widgets.add(Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(speaker.name),
      ));

      var bio = speaker.biography;
      if (text.contains('<p>') || text.contains('<h4>')) {
        bio = html2md.convert(text);
      }

      widgets.add(Padding(
        padding: const EdgeInsets.only(
            top: 10.0, bottom: 30.0, left: 10.0, right: 10.0),
        child: MarkdownBody(
          data: bio,
        ),
      ));
    }

    final listView = SliverList(
      delegate: SliverChildListDelegate(widgets),
    );

    return Scaffold(
      appBar: CupertinoNavigationBar(
        border: null,
        backgroundColor: Colors.white,
        previousPageTitle: 'iPlaground',
      ),
      body: Scrollbar(
        child: Container(
          color: Colors.white,
          child: Center(
            child: Container(
              color: Colors.white,
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 640.0),
                child: CustomScrollView(
                  slivers: <Widget>[listView],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
