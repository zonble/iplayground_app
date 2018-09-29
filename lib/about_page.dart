import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:iplayground/about_coorganizer_card.dart';
import 'package:iplayground/about_sns_icon.dart';

/// The page in the 'about' tab.
class AboutPage extends StatefulWidget {
  AboutPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _AboutPageState createState() => new _AboutPageState();
}

class AboutTitle extends StatelessWidget {
  final String text;

  AboutTitle({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: 30.0, left: 10.0, right: 10.0, bottom: 10.0),
      child: Center(
        child: Text(
          this.text,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}

class AboutLine extends StatelessWidget {
  final String text;

  AboutLine({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(this.text),
    );
  }
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    var slivers = <Widget>[];

    final lines = [
      AboutTitle(text: '10/20 - 10/21 @ 台大管理學院'),
      AboutLine(
        text: 'iPlayground 是在台北舉辦的 Apple 軟體開發相關的研討會，' +
            '名字來自於 Xcode 內建的開發工具 Playground，' +
            '我們希望開發者、設計師、QA、PM 都可以在這邊交換想法，' +
            '分享所學我們歡迎有興趣的朋友一同加入 iPlayground 並且認識更多同好。',
      ),
      Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SNSIcon(
              imageName: 'assets/svg_twitter.png',
              link: 'https://twitter.com/theiPlayground',
            ),
            SNSIcon(
              imageName: 'assets/svg_facebook.png',
              link: 'https://www.facebook.com/theiPlayground/',
            ),
            SNSIcon(
              imageName: 'assets/svg_share.png',
              link: 'https://mastodon.technology/@iplayground',
            ),
          ],
        ),
      ),
      AboutTitle(text: '活動緣起'),
      AboutLine(
        text: '自從蘋果發表 iPhone 以來，' +
            'iOS 開發就是業界重要的題⽬。' +
            '國外有無數的地區型開發者研討會，' +
            '甚⾄有跨國巡迴式的專⾨組織。' +
            '但是以往在台灣地區舉辦的開發者研討會中，' +
            'iOS 只是其中一個配⾓。',
      ),
      AboutLine(
          text: '2017.9，' +
              '台灣有一群⼯程師去東京參加 iOSDC（https://iosdc.jp/2017/），' +
              '看到⽇本當地開發社群的蓬勃活力，' +
              '兼具深度、廣度的諸多講題及趣味的舉辦⽅式，' +
              '其中有許多台灣社群可以學習之處。'),
      AboutLine(text: '我們意識到開發社群有強烈的需求，決定在台北辦⼀場 iOS 開發專⾨的研討會。'),
    ];

    final text = SliverList(
      delegate: SliverChildListDelegate([
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: lines)
      ]),
    );
    slivers.add(text);

    final coOrganizersTitle = SliverList(
      delegate: SliverChildListDelegate([
        Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [AboutTitle(text: 'Co-organizers')])
      ]),
    );
    slivers.add(coOrganizersTitle);

    final coOrganizersGrid = SliverGrid(
      delegate: SliverChildListDelegate([
        CoOrganizerCard(
          link: 'https://www.facebook.com/groups/cocoaheads.taipei/',
          imageName: 'assets/logo_cocoaheads.png',
        ),
        CoOrganizerCard(
          link: 'https://www.facebook.com/groups/ios.taipei/',
          imageName: 'assets/logo_ios_taipei.png',
        ),
        CoOrganizerCard(
          link: 'https://www.meetup.com/Swift-Taipei-User-Group/',
          imageName: 'assets/logo_swift_taipei.png',
        ),
        CoOrganizerCard(
          link: 'https://www.facebook.com/groups/1260405513988915/',
          imageName: 'assets/logo_app_girls.png',
        ),
      ]),
      gridDelegate:
          SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 200.0),
    );
    slivers.add(coOrganizersGrid);

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 240.0,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.asset(
                  'assets/banner.png',
                  fit: BoxFit.cover,
                ),
              ),
            )
          ];
        },
        body: Scrollbar(
          child: Container(
            color: Colors.white,
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 640.0),
                child: CustomScrollView(
                  slivers: slivers,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
