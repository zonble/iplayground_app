import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class MainError extends StatelessWidget {
  VoidCallback onTap;

  MainError({Key key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('載入失敗'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FlatButton(
                child: Text('重試'),
                onPressed: onTap,
              ),
            )
          ],
        ),
      ),
    );
  }
}
