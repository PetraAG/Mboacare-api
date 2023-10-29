import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mboacare_admin/themes/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

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
      body: Center(
        child: Text("All Mboacare Hospitals Here!"),
      ),
    );
  }
}
