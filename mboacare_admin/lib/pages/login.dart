import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mboacare_admin/themes/app_colors.dart';
import 'package:mboacare_admin/widgets/input_widget.dart';
import 'package:provider/provider.dart';

import '../provider/auth_provider/login_provider.dart';
import '../ustils/app_constant.dart';
import '../ustils/assets_string.dart';
import '../widgets/custom_botton.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool rememberMe = false;
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
                            controller: emailController,
                            hintText: 'email',
                            labelText: 'email',
                            borderRadius: 15.0,
                            maxLines: 1,
                            onChange: (value) {
                              // setState(() {
                              // provider.setEmail(value);
                              // provider.validSignIn();
                              // });
                            }),
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
                            onChange: (value) {
                              // setState(() {
                              //   provider.setPassword(value);
                              //   provider.validSignIn();
                              // });
                            }),
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
                                    value: rememberMe,
                                    onChanged: (value) {
                                      setState(() {
                                        rememberMe = value!;
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
                        child: Consumer<LoginProvider>(
                            builder: (context, auth, child) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            if (auth.reqMessage != '') {
                              auth.clear();
                            }
                          });
                          return customButton(
                              text: 'Login',
                              status: auth.isLoading,
                              tap: () {
                                auth.login(
                                    emailUser: emailController.text.trim(),
                                    passwordA: passwordController.text.trim(),
                                    context: context);
                              });
                        }),
                      ),
                      SizedBox(height: AppConstant.height(context) * 0.04),
                      Consumer<LoginProvider>(builder: (context, auth, child) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          if (auth.reqMessage != '') {
                            auth.clear();
                          }
                        });
                        return ElevatedButton.icon(
                          onPressed: () {
                            // auth.signInWithGoogle(context: context);
                          },
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
                        );
                      }),
                    ],
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
