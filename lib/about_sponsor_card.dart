import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SponsorCard extends StatelessWidget {
  final String imageName;
  final String name;
  final String title;
  final String link;

  SponsorCard({Key key, this.imageName, this.name, this.title, this.link}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: () async {
          if (this.link == '') {
            return;
          }
          await launch(this.link);
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
              width: 180.0,
              height: 108.0,
              child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.contain, 
                      image: AssetImage(this.imageName)
                      ),
                    ),
                  ),
                ),
              ),
              Text(
                this.name,
                style: TextStyle(fontSize: 17.0),
              ),
              Text(this.title,
                  textAlign: TextAlign.center, style: TextStyle(fontSize: 12.0))
            ],
          ),
        ),
      ),
    );
  }
}
