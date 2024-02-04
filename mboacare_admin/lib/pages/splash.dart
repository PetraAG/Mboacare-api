import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:mboacare_admin/pages/dashboard/dashboard.dart';
import 'package:mboacare_admin/pages/login.dart';
import 'package:mboacare_admin/provider/database/databaseProvider.dart';
import 'package:mboacare_admin/themes/app_colors.dart';
import 'package:mboacare_admin/ustils/assets_string.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    navigate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: AppColors.whiteColor),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(ImageAssets.logo),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Welcome Mboacare Admin',
              style: GoogleFonts.quicksand(
                decoration: TextDecoration.none,
                color: AppColors.greyText,
                fontSize: 20,
              ),
            )
          ],
        ),
      ),
    );
  }

  void navigate() {
    Future.delayed(const Duration(seconds: 3), () {
      DatabaseProvider().getEmail().then((value) {
        if (value == '') {
          Get.to(
            () => const Login(),
            duration: const Duration(milliseconds: 1200),
            curve: Curves.linearToEaseOut,
            transition: Transition.fadeIn,
          );
        } else {
          Get.to(
            () => const Dashboard(),
            duration: const Duration(milliseconds: 800),
            curve: Curves.linearToEaseOut,
            transition: Transition.rightToLeft,
          );
        }
      });
    });
  }
}
