import 'package:flutter/material.dart';

import '../../ustils/responsiveness.dart';
import '../../widgets/menu.dart';
import '../inerpages/hospital_page.dart';
import 'homepage.dart';
import 'profile.dart';

class Hospital extends StatefulWidget {
  const Hospital({Key? key}) : super(key: key);

  @override
  _HospitalState createState() => _HospitalState();
}

class _HospitalState extends State<Hospital> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: SafeArea(
          child: Row(
            children: [
              // if (Responsive.isDesktop(context))
              //   Expanded(
              //     flex: 3,
              //     child: SizedBox(
              //         height: MediaQuery.of(context).size.height,
              //         child: Menu(scaffoldKey: _scaffoldKey)),
              //   ),
              Expanded(
                  flex: 8, child: HospitalDetails(scaffoldKey: _scaffoldKey)),
              if (!Responsive.isMobile(context))
                const Expanded(
                  flex: 4,
                  child: Profile(),
                ),
            ],
          ),
        ));
  }
}
