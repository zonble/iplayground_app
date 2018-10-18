import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:iplayground/about_sponsor_card.dart';
import 'package:iplayground/about_coorganizer_card.dart';
import 'package:iplayground/about_sns_icon.dart';
import 'package:iplayground/about_staff_card.dart';

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
          locale: Locale('zh', 'TW'),
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
      child: Text(
        this.text,
        locale: Locale('zh', 'TW'),
      ),
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

    final sponsorTitle = SliverList(
      delegate: SliverChildListDelegate([
        Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [AboutTitle(text: 'Sponsor')])
      ]),
    );
    slivers.add(sponsorTitle);

    final sponsorGrid = SliverGrid(
      delegate: SliverChildListDelegate([
        SponsorCard(
          imageName: 'assets/logo_esun.jpg',
          name: '玉山銀行',
          title: '黃金贊助',
          link: 'https://bit.ly/2zR7AWS',
        ),
        SponsorCard(
          imageName: 'assets/logo_dcard.png',
          name: 'Dcard',
          title: '黃金贊助',
          link: 'https://join.dcard.today',
        ),
        SponsorCard(
          imageName: 'assets/logo_piccollage.png',
          name: 'PicCollage',
          title: '白銀贊助',
          link: 'https://pic-collage.com',
        ),
        SponsorCard(
          imageName: 'assets/logo_ichef.jpeg',
          name: 'iCHEF',
          title: '白銀贊助',
          link: 'https://www.ichefpos.com/zh-tw/join-us/',
        ),
        SponsorCard(
          imageName: 'assets/logo_catchplay.jpg',
          name: 'CATCHPLAY',
          title: '青銅贊助',
          link: 'https://www.catchplay.com/',
        ),
        SponsorCard(
          imageName: 'assets/logo_keyxentic.png',
          name: 'KeyXentic',
          title: '青銅贊助',
          link: 'https://www.keyxentic.com',
        ),
        SponsorCard(
          imageName: 'assets/logo_5xruby.png',
          name: '五倍紅寶石',
          title: '設備贊助',
          link: 'https://5xruby.tw',
        ),
      ]),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200.0, childAspectRatio: 0.7),
    );
    slivers.add(sponsorGrid);

    final staffTitle = SliverList(
      delegate: SliverChildListDelegate([
        Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [AboutTitle(text: 'Staff')])
      ]),
    );
    slivers.add(staffTitle);

    final staffGrid = SliverGrid(
      delegate: SliverChildListDelegate([
        StaffCard(
          imageName: 'assets/staff_hokila.jpg',
          name: 'Hokila',
          title: 'iOS Evangelist / Trello Lover / Father',
          link: 'https://www.facebook.com/hokilaj',
        ),
        StaffCard(
          imageName: 'assets/staff_hanyu.png',
          name: 'Hanyu Chen',
          title: 'iOS Developer',
          link: 'https://www.facebook.com/hanyu.chen.518',
        ),
        StaffCard(
          imageName: 'assets/staff_johnlin.jpeg',
          name: 'John Lin',
          title: 'Swift Taipei Organizer',
          link: 'https://twitter.com/johnlinvc',
        ),
        StaffCard(
          imageName: 'assets/staff_13.jpeg',
          name: 'ethanhuang13',
          title: 'iOS Dev @ CATCHPLAY',
          link: 'https://twitter.com/ethanhuang13',
        ),
        StaffCard(
          imageName: 'assets/staff_haolee.jpeg',
          name: 'Hao Lee',
          title: 'Software Engineer at DYLAN-TEK CO., LTD.',
          link: 'https://twitter.com/twhaolee',
        ),
        StaffCard(
          imageName: 'assets/staff_welly.png',
          name: 'Welly',
          title: 'F2E at KKStream',
          link: 'https://github.com/WellyShen',
        ),
        StaffCard(
          imageName: 'assets/staff_joechen.jpg',
          name: 'Joe Chen',
          title: 'Software Engineer',
          link: '',
        ),
        StaffCard(
          imageName: 'assets/staff_hanpo.jpg',
          name: 'Hanpo',
          title: 'UI Design Engineer at KeyXentic',
          link: 'https://www.facebook.com/hanpo.tw',
        ),
        StaffCard(
          imageName: 'assets/staff_superbil.jpeg',
          name: 'Superbil',
          title: 'Software Freelance',
          link: 'https://twitter.com/superbil',
        ),
        StaffCard(
          imageName: 'assets/staff_dada.jpg',
          name: 'Dada',
          title: 'iOS Developer at KKBOX',
          link: 'https://twitter.com/nalydadad',
        ),
      ]),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200.0, childAspectRatio: 0.7),
    );
    slivers.add(staffGrid);

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
              floating: true,
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
