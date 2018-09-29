import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

/// Presents an error state.
class MainError extends StatelessWidget {
  final VoidCallback onTap;

  MainError({Key key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '載入失敗',
                locale: Locale('zh', 'TW'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FlatButton(
                child: Text(
                  '重試',
                  locale: Locale('zh', 'TW'),
                  style: TextStyle(
                    fontSize: 17.0,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                onPressed: onTap,
              ),
            )
          ],
        ),
      ),
    );
  }
}
