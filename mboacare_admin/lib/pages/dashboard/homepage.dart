import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mboacare_admin/model/blog_model.dart';
import 'package:mboacare_admin/model/hospital_model.dart';
import 'package:mboacare_admin/pages/dashboard/blog.dart';
import 'package:mboacare_admin/pages/dashboard/hospital.dart';
import 'package:mboacare_admin/services/appServices.dart';
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
              FutureBuilder<List<HospitalModel>>(
                  future: ApiServices().hospitals(),
                  builder: ((context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SpinKitCircle(
                              color: AppColors.cardbg,
                            ),
                            Text(
                              'Loading Hospitals....',
                              style: TextStyle(
                                color: AppColors.grey,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    if (snapshot.data!.isEmpty) {
                      return Center(
                        child: Text(
                          'No hospital Available!',
                          style: GoogleFonts.quicksand(
                            fontSize: 14,
                          ),
                        ),
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.none) {
                      return Text(
                        'No Internet Connection!',
                        style: GoogleFonts.quicksand(
                          fontSize: 14,
                        ),
                      );
                    }
                    final data = snapshot.data;
                    return GridView.builder(
                      itemCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: Responsive.isMobile(context) ? 1 : 2,
                          crossAxisSpacing:
                              !Responsive.isMobile(context) ? 15 : 10,
                          mainAxisSpacing: 12.0,
                          childAspectRatio:
                              Responsive.isMobile(context) ? 16 / 9 : 3 / 1),
                      itemBuilder: (context, index) {
                        final hospital = data![index];
                        return SizedBox(
                            height: 30.0,
                            child: Card(
                              color: Colors.white,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20)),
                                child: ListTile(
                                  leading: CachedNetworkImage(
                                    imageUrl: hospital.hospitalImage.toString(),
                                    placeholder: (context, url) =>
                                        CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),

                                  //Image(image: CachedNetworkImageProvider(blog.blogImage.toString())),
                                  // Image(
                                  //   image:
                                  //       NetworkImage(blog.blogImage.toString()),
                                  //   width: 100.0,
                                  //   height: 200.0,
                                  //   fit: BoxFit.fill,
                                  // ),

                                  title: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        hospital.name.toString(),
                                        style: GoogleFonts.quicksand(
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        hospital.placeAddress.toString(),
                                        style: GoogleFonts.quicksand(
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                  trailing: hospital.isApprove == true
                                      ? Text(
                                          "Approve",
                                          style: GoogleFonts.quicksand(
                                              color: Colors.green),
                                        )
                                      : Text("Pending",
                                          style: GoogleFonts.quicksand(
                                              color: AppColors.redColor)),
                                ),
                              ),
                            ));
                      },
                    );
                  })),
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
              FutureBuilder<List<BlogModel>>(
                  future: ApiServices().blogs(),
                  builder: ((context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SpinKitCircle(
                              color: AppColors.cardbg,
                            ),
                            Text(
                              'Loading My Blog....',
                              style: TextStyle(
                                color: AppColors.grey,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    if (snapshot.data!.isEmpty) {
                      return Center(
                        child: Text(
                          'No Blog Available!',
                          style: GoogleFonts.quicksand(
                            fontSize: 14,
                          ),
                        ),
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.none) {
                      return Text(
                        'No Internet Connection!',
                        style: GoogleFonts.quicksand(
                          fontSize: 14,
                        ),
                      );
                    }
                    final data = snapshot.data;
                    return GridView.builder(
                      itemCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: Responsive.isMobile(context) ? 1 : 2,
                          crossAxisSpacing:
                              !Responsive.isMobile(context) ? 15 : 10,
                          mainAxisSpacing: 12.0,
                          childAspectRatio:
                              Responsive.isMobile(context) ? 16 / 9 : 3 / 1),
                      itemBuilder: (context, index) {
                        final blog = data![index];
                        return SizedBox(
                            height: 30.0,
                            child: Card(
                              color: Colors.white,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20)),
                                child: ListTile(
                                  leading: CachedNetworkImage(
                                    imageUrl: blog.blogImage.toString(),
                                    placeholder: (context, url) =>
                                        CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),

                                  //Image(image: CachedNetworkImageProvider(blog.blogImage.toString())),
                                  // Image(
                                  //   image:
                                  //       NetworkImage(blog.blogImage.toString()),
                                  //   width: 100.0,
                                  //   height: 200.0,
                                  //   fit: BoxFit.fill,
                                  // ),

                                  title: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        blog.blogTitle.toString(),
                                        style: GoogleFonts.quicksand(
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        blog.blogCat.toString(),
                                        style: GoogleFonts.quicksand(
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                  trailing: blog.isApprove == true
                                      ? Text(
                                          "Approve",
                                          style: GoogleFonts.quicksand(
                                              color: Colors.green),
                                        )
                                      : Text("Pending",
                                          style: GoogleFonts.quicksand(
                                              color: AppColors.redColor)),
                                ),
                              ),
                            ));
                      },
                    );
                  })),
            ],
          ),
        ),
      ),
    );
  }
}
