import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mboacare_admin/model/notification_model.dart';
import 'package:mboacare_admin/provider/notification/addnotification_provider.dart';
import 'package:mboacare_admin/services/appServices.dart';
import 'package:mboacare_admin/ustils/app_constant.dart';
import 'package:mboacare_admin/ustils/responsiveness.dart';
import 'package:mboacare_admin/widgets/custom_botton.dart';
import 'package:mboacare_admin/widgets/input_widget.dart';
import 'package:provider/provider.dart';

import '../../themes/app_colors.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key, required this.scaffoldKey})
      : super(key: key);
  final GlobalKey<ScaffoldState> scaffoldKey;
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AddNotificationProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
          ElevatedButton(
              style: ButtonStyle(
                elevation: MaterialStateProperty.all<double>(0.0),
                backgroundColor:
                    MaterialStateProperty.all<Color>(AppColors.whiteColor),
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        clipBehavior: Clip.hardEdge,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10.0),
                        title: Text(
                          'Add Notification',
                          style: GoogleFonts.montserrat(
                              color: AppColors.textColor,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500),
                        ),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                child: Text(
                                  "Notification Title*",
                                  style: TextStyle(
                                      // color: AppColors.kTextColor,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              inputWidget(
                                  controller: provider.titleController,
                                  hintText: 'notification title',
                                  labelText: 'title',
                                  borderRadius: 15.0,
                                  maxLines: 1,
                                  onChange: (value) {}),
                              const SizedBox(
                                height: 10,
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                child: Text(
                                  "Notification Content*",
                                  style: TextStyle(
                                      // color: AppColors.kTextColor,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              inputWidget(
                                  controller: provider.contentController,
                                  hintText: 'notification content',
                                  labelText: 'content',
                                  borderRadius: 15.0,
                                  maxLines: 1,
                                  onChange: (value) {}),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          const SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: Consumer<AddNotificationProvider>(
                                builder: (context, add, child) {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                if (add.reqMessage != '') {
                                  add.clear();
                                }
                              });
                              return customButton(
                                text: 'Add Notification',
                                status: add.isLoading,
                                tap: () {
                                  add.addNotification(
                                      context: context,
                                      title:
                                          provider.titleController.text.trim(),
                                      content: provider.contentController.text
                                          .trim());
                                },
                              );
                            }),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      );
                    });
              },
              child: Text(
                'Add Notification',
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
          "Mboacare Notification",
          style: GoogleFonts.quicksand(
            fontSize: 20,
            color: AppColors.whiteColor,
          ),
        ),
      ),
      body: FutureBuilder<List<Notify>>(
          future: ApiServices().fetchNotifications(),
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
                      'Loading My Notifications....',
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
                  'No Notification Available!',
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
                final notify = data![index];
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
                                        'Notification Details For ${notify.title}',
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
                                        "Notification Tile: ${notify.title}",
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
                                        "Notification content: ${notify.content}",
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
                                        "Publish Date:  ${notify.pubDate}",
                                        style: const TextStyle(
                                            // color: AppColors.kTextColor,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      height: AppConstant.height(context) * 0.1,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          title: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                notify.title,
                                style: GoogleFonts.quicksand(
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                'Publish Date: ${notify.pubDate}',
                                style: GoogleFonts.quicksand(
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ));
              },
            );
          })),
    );
  }
}
