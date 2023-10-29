import 'package:flutter/material.dart';

class AppConstant{
  static height(BuildContext context) => MediaQuery.maybeOf(context)!.size.height;
  static width(BuildContext context) => MediaQuery.maybeOf(context)!.size.width;
}