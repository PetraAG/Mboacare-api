import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mboacare_admin/pages/dashboard/blog.dart';
import 'package:mboacare_admin/pages/dashboard/hospital.dart';
import 'package:mboacare_admin/themes/app_colors.dart';
import 'package:mboacare_admin/ustils/assets_string.dart';
import 'package:mboacare_admin/ustils/responsiveness.dart';

import '../../widgets/activity_card.dart';
import '../../widgets/bar_chart.dart';
import '../../widgets/header_widget.dart';

class Homepage extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const Homepage({super.key, required this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    SizedBox _height(BuildContext context) => SizedBox(
          height: Responsive.isDesktop(context) ? 30 : 20,
        );
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Responsive.isMobile(context) ? 15 : 18),
          child: Column(
            children: [
              SizedBox(
                height: Responsive.isMobile(context) ? 5 : 18,
              ),
              Header(scaffoldKey: scaffoldKey),
              _height(context),
              const ActivityDetailsCard(),
              _height(context),
              //LineChartCard(),
              _height(context),
              //BarGraphCard(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Hospitals",
                    style: GoogleFonts.quicksand(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryColor),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all<double>(0.0),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          AppColors.primaryColor),
                    ),
                    onPressed: () {
                      Get.to(() => const Hospital());
                    },
                    child: Text(
                      'View More',
                      style: GoogleFonts.quicksand(
                        color: AppColors.whiteColor,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15.0),
              GridView.builder(
                itemCount: 2,
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: Responsive.isMobile(context) ? 1 : 2,
                    crossAxisSpacing: !Responsive.isMobile(context) ? 15 : 10,
                    mainAxisSpacing: 12.0,
                    childAspectRatio:
                        Responsive.isMobile(context) ? 16 / 9 : 3 / 1),
                itemBuilder: (context, i) {
                  return SizedBox(
                    height: 30.0,
                    child: Card(
                      color: Colors.white,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: ListTile(
                            leading: Image.asset(
                              ImageAssets.hosp1,
                              width: 100.0,
                              height: 200.0,
                              fit: BoxFit.fill,
                            ),
                            title: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'CBC',
                                  style: GoogleFonts.quicksand(
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  'Cameroon, Bamenda, Finance Junction 1334',
                                  style: GoogleFonts.quicksand(
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            trailing: Text(
                              "Pending",
                              style: GoogleFonts.quicksand(color: Colors.amber),
                            )),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Blogs",
                    style: GoogleFonts.quicksand(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryColor),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all<double>(0.0),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          AppColors.primaryColor),
                    ),
                    onPressed: () {
                      Get.to(() => const Blog());
                    },
                    child: Text(
                      'View More',
                      style: GoogleFonts.quicksand(
                        color: AppColors.whiteColor,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15.0),
              GridView.builder(
                itemCount: 2,
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: Responsive.isMobile(context) ? 1 : 2,
                    crossAxisSpacing: !Responsive.isMobile(context) ? 15 : 10,
                    mainAxisSpacing: 12.0,
                    childAspectRatio:
                        Responsive.isMobile(context) ? 16 / 9 : 3 / 1),
                itemBuilder: (context, i) {
                  return SizedBox(
                    height: 30.0,
                    child: Card(
                      color: Colors.white,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: ListTile(
                            leading: Image.asset(
                              ImageAssets.blog1,
                              width: 100.0,
                              height: 200.0,
                              fit: BoxFit.fill,
                            ),
                            title: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Cooking',
                                  style: GoogleFonts.quicksand(
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  'world Best Cooker in history',
                                  style: GoogleFonts.quicksand(
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            trailing: Text(
                              "Approve",
                              style: GoogleFonts.quicksand(color: Colors.green),
                            )),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
