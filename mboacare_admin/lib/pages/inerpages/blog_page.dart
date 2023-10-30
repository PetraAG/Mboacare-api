import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

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
      body: Center(
        child: Text("All Mboacare Blogs Here!"),
      ),
    );
  }
}
