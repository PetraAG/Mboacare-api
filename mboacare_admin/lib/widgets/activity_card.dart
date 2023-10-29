import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mboacare_admin/themes/app_colors.dart';
import 'package:mboacare_admin/ustils/assets_string.dart';

import '../model/mboa_model.dart';
import '../ustils/responsiveness.dart';
import 'custome_card.dart';

class ActivityDetailsCard extends StatelessWidget {
  const ActivityDetailsCard({super.key});

  final List<MboaModel> mboaDetails = const [
    MboaModel(icon: ImageAssets.hospital, value: "40", title: "Hospital"),
    MboaModel(icon: ImageAssets.blog, value: "30", title: "Blog"),
    MboaModel(icon: ImageAssets.profile, value: "50", title: "Users"),
    MboaModel(
        icon: ImageAssets.notification, value: "100", title: "Notifications"),
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: mboaDetails.length,
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: Responsive.isMobile(context) ? 2 : 4,
          crossAxisSpacing: !Responsive.isMobile(context) ? 15 : 12,
          mainAxisSpacing: 12.0),
      itemBuilder: (context, i) {
        return CustomCard(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(mboaDetails[i].icon),
              Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 4),
                child: Text(
                  mboaDetails[i].value,
                  style: GoogleFonts.quicksand(
                      fontSize: 18,
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Text(
                mboaDetails[i].title,
                style: GoogleFonts.quicksand(
                    fontSize: 13,
                    color: Colors.grey,
                    fontWeight: FontWeight.normal),
              ),
            ],
          ),
        );
      },
    );
  }
}
