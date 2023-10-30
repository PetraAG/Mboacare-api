import 'package:flutter/material.dart';

import '../../ustils/responsiveness.dart';
import '../inerpages/notification_page.dart';
import 'profile.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
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
                flex: 8, child: NotificationPage(scaffoldKey: _scaffoldKey)),
            if (!Responsive.isMobile(context))
              const Expanded(
                flex: 4,
                child: Profile(),
              ),
          ],
        ),
      ),
    );
  }
}
