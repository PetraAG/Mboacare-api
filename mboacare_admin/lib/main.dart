import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:mboacare_admin/pages/splash.dart';
import 'package:mboacare_admin/provider/auth_provider/login_provider.dart';
import 'package:mboacare_admin/provider/blog_provider/approveblog_provider.dart';
import 'package:mboacare_admin/provider/database/databaseProvider.dart';
import 'package:mboacare_admin/provider/hospital_provider/approvehospital_provider.dart';

import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => DatabaseProvider()),
        ChangeNotifierProvider(create: (_) => ApproveBlogProvider()),
ChangeNotifierProvider(create: (_) => ApproveHospitalProvider()),
        
      ],
      child: GetMaterialApp(
        initialRoute: '/',
        debugShowCheckedModeBanner: false,
        title: 'Mboacare Admin',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
