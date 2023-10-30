import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../themes/app_colors.dart';
import '../../ustils/assets_string.dart';
import '../../ustils/responsiveness.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft:
                Radius.circular(Responsive.isMobile(context) ? 10 : 30.0),
            topLeft: Radius.circular(Responsive.isMobile(context) ? 10 : 30.0),
          ),
          color: AppColors.whiteColor,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Image.asset(ImageAssets.logo, width: 50.0),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "PDocs",
                  style: GoogleFonts.quicksand(
                      fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 2,
                ),
                Text(
                  "Mboacare Admin",
                  style: GoogleFonts.quicksand(
                    fontSize: 12,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                // Padding(
                //   padding:
                //       EdgeInsets.all(Responsive.isMobile(context) ? 15 : 20.0),
                //   child: const WeightHeightBloodCard(),
                // ),
                SizedBox(
                  height: Responsive.isMobile(context) ? 20 : 40,
                ),
                //Scheduled()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
