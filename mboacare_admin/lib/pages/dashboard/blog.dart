import 'package:flutter/material.dart';
import 'package:mboacare_admin/pages/dashboard/profile.dart';

import '../../ustils/responsiveness.dart';
import '../inerpages/blog_page.dart';

class Blog extends StatefulWidget {
  const Blog({Key? key}) : super(key: key);

  @override
  _BlogState createState() => _BlogState();
}

class _BlogState extends State<Blog> {
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
            Expanded(flex: 8, child: BlogPage(scaffoldKey: _scaffoldKey)),
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
