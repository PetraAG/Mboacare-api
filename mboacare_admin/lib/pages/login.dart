import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mboacare_admin/themes/app_colors.dart';
import 'package:mboacare_admin/widgets/input_widget.dart';

import '../ustils/app_constant.dart';
import '../ustils/assets_string.dart';
import '../widgets/custom_botton.dart';
import 'dashboard/dashboard.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _rememberMe = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Center(
        child: SizedBox(
          height: AppConstant.height(context) * 0.7,
          width: AppConstant.width(context) * 0.4,
          child: Card(
            elevation: 3.0,
            child: Container(
              color: AppColors.whiteColor,
              child: Form(
                key: loginFormKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //SizedBox(height: AppConstant.height(context) * 0.01),
                        Image.asset(ImageAssets.logo, width: 50.0),
                        // SizedBox(height: AppConstant.height(context) * 0.02),
                        Text(
                          'Welcome Mboacare Admin',
                          style: GoogleFonts.quicksand(
                            fontSize: 20,
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: AppConstant.height(context) * 0.08),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: inputWidget(
                            controller: email,
                            hintText: 'email',
                            labelText: 'email',
                            borderRadius: 15.0,
                            maxLines: 1,
                            validator: (v) => v!.isEmpty
                                ? 'Please username field can not be empty!'
                                : null,
                          ),
                        ),
                        SizedBox(height: AppConstant.height(context) * 0.04),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: inputWidget(
                            controller: passwordController,
                            hintText: 'password',
                            labelText: 'password',
                            borderRadius: 15.0,
                            maxLines: 1,
                            validator: (v) => v!.isEmpty
                                ? 'Please password field can not be empty!'
                                : null,
                          ),
                        ),
                        SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Checkbox(
                                      value: _rememberMe,
                                      onChanged: (value) {
                                        setState(() {
                                          _rememberMe = value!;
                                        });
                                      },
                                      activeColor: Colors.green,
                                    ),
                                    Text(
                                      "Remember Me",
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.quicksand(
                                        fontSize: 14,
                                        color: AppColors.primaryColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ]),
                        ),
                        SizedBox(height: AppConstant.height(context) * 0.05),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: customButton(
                              text: 'Login',
                              tap: () {
                                if (!loginFormKey.currentState!.validate()) {
                                  /// do something here
                                } else {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Dashboard()),
                                  );
                                  // Get.to(() => const Dashboard());
                                }
                              }),
                        ),
                        SizedBox(height: AppConstant.height(context) * 0.04),
                        ElevatedButton.icon(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            primary: AppColors.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            // minimumSize: Size(340, 45),
                          ),
                          icon: Image.asset(
                            ImageAssets.google,
                            height: 32,
                            width: 32,
                          ),
                          label: Text(
                            "Sign in with Google",
                            style: GoogleFonts.quicksand(
                              color: AppColors.primaryColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
