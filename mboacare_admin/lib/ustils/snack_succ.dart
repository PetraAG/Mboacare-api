import 'package:flutter/material.dart';
import 'package:mboacare_admin/themes/app_colors.dart';




void snackMessage({required String message,required BuildContext context}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      message,
      style:  TextStyle(
        color: AppColors.whiteColor,
      ),
    ),
    backgroundColor: AppColors.primaryColor,
  ));
}
