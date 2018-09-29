import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CoOrganizerCard extends StatelessWidget {
  final String link;
  final String imageName;

  CoOrganizerCard({Key key, this.link, this.imageName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async => await launch(this.link),
      child: Container(
        width: 180.0,
        height: 108.0,
        child: DecoratedBox(
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.contain, image: AssetImage(this.imageName))),
        ),
      ),
    );
  }
}
