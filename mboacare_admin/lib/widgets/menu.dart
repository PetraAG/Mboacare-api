import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mboacare_admin/pages/dashboard/blog.dart';
import 'package:mboacare_admin/pages/dashboard/dashboard.dart';
import 'package:mboacare_admin/pages/dashboard/hospital.dart';
import 'package:mboacare_admin/pages/dashboard/notification.dart';
import 'package:mboacare_admin/pages/dashboard/user.dart';
import 'package:mboacare_admin/themes/app_colors.dart';

import '../model/menu_model.dart';
import '../ustils/assets_string.dart';
import '../ustils/responsiveness.dart';

class Menu extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const Menu({super.key, required this.scaffoldKey});

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  List<MenuModel> menu = [
    MenuModel(widget: "assets/svg/home.svg", title: "Dashboard"),
    MenuModel(widget: ImageAssets.hospital, title: "Hospital"),
    MenuModel(widget: ImageAssets.blog, title: "Blog"),
    MenuModel(widget: ImageAssets.notification, title: "Notification"),
    MenuModel(widget: ImageAssets.profile, title: "Users"),
    MenuModel(widget: ImageAssets.logout, title: "Logout"),
  ];

  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          border: Border(
            right: BorderSide(
              color: AppColors.greyText,
              width: 1,
            ),
          ),
          color: AppColors.primaryColor),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
            child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(20.0)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(ImageAssets.logo, width: 50.0),
              ),
            ),
            SizedBox(
              height: Responsive.isMobile(context) ? 40 : 80,
            ),
            for (var i = 0; i < menu.length; i++)
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                  color:
                      selected == i ? AppColors.whiteColor : Colors.transparent,
                ),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selected = i;
                    });
                    widget.scaffoldKey.currentState!.closeDrawer();

                    // Navigate to the corresponding page
                    switch (i) {
                      case 0: // Dashboard
                        Get.to(() => const Dashboard());
                        break;
                      case 1: // Hospital
                        Get.to(() => const Hospital());

                        break;
                      // Add similar cases for other menu items
                      case 2: //blog
                        Get.to(() => const Blog());
                        break;
                      case 3: //Notification
                        Get.to(() => const Notifications());
                        break;
                      case 4: //Users
                        Get.to(() => const User());
                        break;
                    }
                  },
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 13, vertical: 7),
                        child: SvgPicture.asset(
                          menu[i].widget,
                          color: selected == i
                              ? AppColors.primaryColor
                              : AppColors.whiteColor,
                        ),
                      ),
                      Text(
                        menu[i].title,
                        style: GoogleFonts.quicksand(
                            fontSize: 16,
                            color: selected == i
                                ? AppColors.primaryColor
                                : AppColors.whiteColor,
                            fontWeight: selected == i
                                ? FontWeight.w500
                                : FontWeight.normal),
                      )
                    ],
                  ),
                ),
              ),
          ],
        )),
      ),
    );
  }
}
