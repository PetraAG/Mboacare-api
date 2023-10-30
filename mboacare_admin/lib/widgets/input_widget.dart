

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../themes/app_colors.dart';

Widget inputWidget({
  required TextEditingController controller,
  required String hintText,
  labelText,
  required double borderRadius,
  required int maxLines,
  dynamic validator,
}) {
  return SizedBox(
    //height: 45,
    child: TextFormField(
      validator: validator,
      maxLines: maxLines,
      controller: controller,
      cursorColor: AppColors.primaryColor,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        labelText: labelText,
        labelStyle: GoogleFonts.quicksand(
          color: AppColors.greyText,
          fontSize: 12.0,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: const BorderSide(color: Colors.red)),
        hintText: hintText,
        hintStyle: GoogleFonts.quicksand(
          color: AppColors.greyText,
          fontSize: 12.0,
        ),
      ),
    ),
  );
}
