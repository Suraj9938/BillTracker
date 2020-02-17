import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveButton extends StatelessWidget {
  final Function onPress;

  AdaptiveButton({this.onPress});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            child: Text(
              "Choose a date",
              style: Theme.of(context)
                  .textTheme
                  .title
                  .copyWith(fontFamily: "font1"),
            ),
            onPressed: onPress,
          )
        : FlatButton(
            padding: EdgeInsets.all(0),
            child: Text(
              "Choose a date",
              style: Theme.of(context)
                  .textTheme
                  .title
                  .copyWith(fontFamily: "font1"),
            ),
            onPressed: onPress,
          );
  }
}
