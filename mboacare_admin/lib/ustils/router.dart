import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PageNavigator {
  PageNavigator({required this.ctx});

  BuildContext? ctx;

  ///Navigation
  Future nextPage({required Widget page}) {
    return Navigator.push(
        ctx!, CupertinoPageRoute(builder: ((context) => page)));
  }

  void nextPageOnly({required Widget page}) {
    Navigator.pushAndRemoveUntil(
        ctx!, MaterialPageRoute(builder: (context) => page), (route) => true);
  }
}