import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mboacare_admin/model/blog_model.dart';
import 'package:mboacare_admin/provider/blog_provider/approveblog_provider.dart';
import 'package:mboacare_admin/services/appServices.dart';
import 'package:mboacare_admin/ustils/app_constant.dart';
import 'package:mboacare_admin/ustils/responsiveness.dart';
import 'package:mboacare_admin/widgets/custom_botton.dart';
import 'package:provider/provider.dart';

import '../../themes/app_colors.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({Key? key, required this.scaffoldKey}) : super(key: key);
  final GlobalKey<ScaffoldState> scaffoldKey;
  @override
  _BlogPageState createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  Widget build(BuildContext context) {
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
              onPressed: () {},
              child: Text(
                'Add Blog',
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
          "Mboacare Blogs",
          style: GoogleFonts.quicksand(
            fontSize: 20,
            color: AppColors.whiteColor,
          ),
        ),
      ),
      body: FutureBuilder<List<BlogModel>>(
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
                                        'Blog Details For ${blog.blogTitle}',
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
                                        "Blog Name: ${blog.blogTitle}",
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
                                        "Blog Category: ${blog.blogCat}",
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
                                        "Blog Web Link:  ${blog.blogWebLink}",
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
                                        "Blog Author: ${blog.blogAuthor}",
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
                                        "Blog Image:",
                                        style: const TextStyle(
                                            // color: AppColors.kTextColor,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    CachedNetworkImage(
                                      imageUrl: blog.blogImage.toString(),
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
                                      child: Consumer<ApproveBlogProvider>(
                                          builder: (context, blogData, child) {
                                        WidgetsBinding.instance
                                            .addPostFrameCallback((_) {
                                          if (blogData.reqMessage != '') {
                                            blogData.clear();
                                          }
                                        });
                                        return SizedBox(
                                          width:
                                              AppConstant.width(context) * 0.35,
                                          child: customButton(
                                              text: 'Approve Blog',
                                              status: blogData.isLoading,
                                              tap: () {
                                                blogData.approveBlog(
                                                    id: blog.id.toString(),
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
                            imageUrl: blog.blogImage.toString(),
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                          title: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
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
    );
  }
}
