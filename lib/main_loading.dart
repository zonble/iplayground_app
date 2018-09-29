import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

/// Presents a loading state.
class MainLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('載入中…',
              locale: Locale('zh', 'TW'),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: CupertinoActivityIndicator(),
            ),
          ],
        ),
      ),
    );
  }
}
