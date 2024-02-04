import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:mboacare_admin/model/hospital_model.dart';
import 'package:mboacare_admin/provider/hospital_provider/approvehospital_provider.dart';
import 'package:mboacare_admin/services/appServices.dart';
import 'package:mboacare_admin/themes/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mboacare_admin/ustils/app_constant.dart';
import 'package:mboacare_admin/ustils/responsiveness.dart';
import 'package:mboacare_admin/widgets/custom_botton.dart';
import 'package:provider/provider.dart';

class HospitalDetails extends StatefulWidget {
  const HospitalDetails({Key? key, required this.scaffoldKey})
      : super(key: key);
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  _HospitalDetailsState createState() => _HospitalDetailsState();
}

class _HospitalDetailsState extends State<HospitalDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton(
              style: ButtonStyle(
                elevation: MaterialStateProperty.all<double>(0.0),
                backgroundColor:
                    MaterialStateProperty.all<Color>(AppColors.whiteColor),
              ),
              onPressed: () {},
              child: Text(
                'Add Hospital',
                style: GoogleFonts.quicksand(
                  color: AppColors.primaryColor,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                ),
              )),
          const SizedBox(width: 20.0),
        ],
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back,
              color: AppColors.whiteColor,
            )),
        backgroundColor: AppColors.primaryColor,
        title: Text(
          "Mboacare Hospitals",
          style: GoogleFonts.quicksand(
            fontSize: 20,
            color: AppColors.whiteColor,
          ),
        ),
      ),
      body: FutureBuilder<List<HospitalModel>>(
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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              itemCount: data?.length,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: Responsive.isMobile(context) ? 1 : 3,
                  crossAxisSpacing: !Responsive.isMobile(context) ? 15 : 10,
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
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => Container(
                                margin: EdgeInsets.only(
                                  top: AppConstant.height(context) * 0.06,
                                  bottom: AppConstant.height(context) * 0.2,
                                  left: AppConstant.width(context) * 0.35,
                                  right: AppConstant.width(context) * 0.35,
                                ),

                                decoration: BoxDecoration(
                                    color: AppColors.whiteColor,
                                    borderRadius: BorderRadius.circular(15.0)),
                                padding: EdgeInsets.all(16), // Adjust padding
                                child: ListView(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Text(
                                        'Hospital Details For ${hospital.name}',
                                        style: GoogleFonts.montserrat(
                                            color: AppColors.primaryColor,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: Text(
                                        "Hospital Name: ${hospital.name}",
                                        style: const TextStyle(
                                            // color: AppColors.kTextColor,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Text(
                                        "Hospital Phone: ${hospital.phoneNumber}",
                                        style: const TextStyle(
                                            // color: AppColors.kTextColor,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Text(
                                        "Hospital Email: ${hospital.email}",
                                        style: const TextStyle(
                                            // color: AppColors.kTextColor,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Text(
                                        "Hospital Facility Type: ${hospital.facilitiesType}",
                                        style: const TextStyle(
                                            // color: AppColors.kTextColor,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Text(
                                        "Hospital Service Type: ${hospital.serviceType}",
                                        style: const TextStyle(
                                            // color: AppColors.kTextColor,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Text(
                                        "Hospital  Type: ${hospital.hospitalType}",
                                        style: const TextStyle(
                                            // color: AppColors.kTextColor,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Text(
                                        "Hospital Size: ${hospital.hospitalSize}",
                                        style: const TextStyle(
                                            // color: AppColors.kTextColor,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Text(
                                        "Hospital Location: ${hospital.placeAddress}",
                                        style: const TextStyle(
                                            // color: AppColors.kTextColor,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 2, 2, 2),
                                      child: Text(
                                        "Hospital Web Link:  ${hospital.website}",
                                        style: const TextStyle(
                                            // color: AppColors.kTextColor,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Text(
                                        "Hospital Owner: ${hospital.hospitalOwner}",
                                        style: const TextStyle(
                                            // color: AppColors.kTextColor,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Text(
                                        "Hospital Uploader: ${hospital.userEmail}",
                                        style: const TextStyle(
                                            // color: AppColors.kTextColor,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: Text(
                                        "Hospital Image:",
                                        style: const TextStyle(
                                            // color: AppColors.kTextColor,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    CachedNetworkImage(
                                      imageUrl:
                                          hospital.hospitalImage.toString(),
                                      placeholder: (context, url) =>
                                          CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    SizedBox(
                                      height: AppConstant.height(context) * 0.1,
                                    ),
                                    Center(
                                      child: Consumer<ApproveHospitalProvider>(
                                          builder:
                                              (context, hospitalData, child) {
                                        WidgetsBinding.instance
                                            .addPostFrameCallback((_) {
                                          if (hospitalData.reqMessage != '') {
                                            hospitalData.clear();
                                          }
                                        });
                                        return SizedBox(
                                          width:
                                              AppConstant.width(context) * 0.35,
                                          child: customButton(
                                              text: 'Approve Hospital',
                                              status: hospitalData.isLoading,
                                              tap: () {
                                                hospitalData.approveHospital(
                                                    id: hospital.id.toString(),
                                                    status: true,
                                                    context: context);
                                              }),
                                        );
                                      }),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
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
                            crossAxisAlignment: CrossAxisAlignment.start,
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
    );
  }
}
