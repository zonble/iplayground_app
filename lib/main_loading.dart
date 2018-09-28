import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

/// Presents a loading state.
class MainLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Text('載入中'),
            CupertinoActivityIndicator(),
          ],
        ),
      ),
    );
  }
}
