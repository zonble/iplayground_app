import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SNSIcon extends StatelessWidget {
  final String link;
  final String imageName;

  SNSIcon({Key key, this.link, this.imageName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Image.asset(this.imageName),
      ),
      onTap: () async {
        await launch(this.link);
      },
    );
  }
}