import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import '../themes/app_colors.dart';

Widget customButton({
  required String text,
  required Function() tap,
 
  Color? color,
  bool? status,
}) {
  return GestureDetector(
    onTap: tap,
    child: status == false
        ? Container(
            height: 45,
            //margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color:AppColors.primaryColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: Text(
                text,
                style: GoogleFonts.quicksand(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),
          )
        : Center(child: SpinKitThreeBounce(color: AppColors.primaryColor)),
  );
}
