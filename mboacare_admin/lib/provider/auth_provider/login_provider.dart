// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mboacare_admin/pages/dashboard/dashboard.dart';
import 'package:mboacare_admin/provider/database/databaseProvider.dart';
import 'package:mboacare_admin/services/apis.dart';
import 'package:mboacare_admin/ustils/assets_string.dart';
import 'package:mboacare_admin/ustils/router.dart';
import 'package:mboacare_admin/ustils/snack_error.dart';
import 'package:mboacare_admin/ustils/snack_succ.dart';
import 'package:mboacare_admin/ustils/validations.dart';
import 'package:http/http.dart' as http;

class LoginProvider extends ChangeNotifier {
  // GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  // final googleSignIn = GoogleSignIn();

  String userEmail = '';
  String userName = '';
  String userPhone = '';
  String profileImage = "";
  String uid = '';

  String _reqMessage = "";
  bool _isLoading = false;
  String email = "";
  String role = "";
  String password = "";
  bool isPasswordVisible = false;
  bool rememberMe = false;
  bool isValidSignIn = false;

  String get reqMessage => _reqMessage;
  bool get isLoading => _isLoading;

  setEmail(String value) {
    email = value;
    FocusManager.instance.primaryFocus?.unfocus();
    notifyListeners();
  }

  setRole(String value) {
    role = value;
    notifyListeners();
  }

  void setPassword(String value) {
    password = value;
    FocusManager.instance.primaryFocus?.unfocus();
    notifyListeners();
  }

  void validSignIn() {
    final isPasswordFilled = password.trim().isNotEmpty && password.length >= 4;
    final isValidEmail = isValidEmails(email.trim());
    final role = isValidSignIn = isValidEmail && isPasswordFilled;
    notifyListeners();
  }

  // void clearInput() {
  //   emailController.clear();
  //   passwordController.clear();
  // }

  void login(
      {required String emailUser,
      required String passwordA,
      required BuildContext context}) async {
    _isLoading = true;
    notifyListeners();

    String url = Apis.login;
    print(url);
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Charset': 'utf-8'
    };
    final body = {"email": emailUser, "password": passwordA};
    print(body);
    http.Response req = await http.post(Uri.parse(url),
        body: json.encode(body), headers: headers);
    try {
      if (req.statusCode == 200 || req.statusCode == 201) {
        final res = json.decode(req.body);

        if (res['data']['emailVerified'] == false) {
          _isLoading = false;
          snackErrorMessage(
              message: "Email is not verified! Check email to verify Account!",
              context: context);
          notifyListeners();
        } else {
          _isLoading = false;
          // notifyListeners();

          userEmail = res['data']['email'];
          //userName = user.displayName ?? 'MboaUser';

          uid = res['data']['uid'];
          DatabaseProvider().saveEmail(userEmail);
          // DatabaseProvider().saveName(userName);
          DatabaseProvider().saveUserID(uid);
          // clearInput();
          snackMessage(message: "Login Successful!", context: context);
          notifyListeners();
          PageNavigator(ctx: context).nextPage(page: const Dashboard());
        }
      }
    } catch (e) {
      if (e is FirebaseAuthException) {
        if (e.code == "user-not-found") {
          _isLoading = false;
          //_reqMessage = e.code;
          snackErrorMessage(message: e.code, context: context);
        } else {
          _isLoading = false;
          _reqMessage = e.message!;
          snackErrorMessage(message: e.message!, context: context);
          notifyListeners();
        }
      }
    }
  }

  // void signInWithGoogle({required BuildContext context}) async {
  //   try {
  //     final GoogleSignInAccount? googleSignInAccount =
  //         await googleSignIn.signIn();
  //     final GoogleSignInAuthentication googleSignInAuthentication =
  //         await googleSignInAccount!.authentication;

  //     final AuthCredential credential = GoogleAuthProvider.credential(
  //       accessToken: googleSignInAuthentication.accessToken,
  //       idToken: googleSignInAuthentication.idToken,
  //     );

  //     final UserCredential userCredential =
  //         await auth.signInWithCredential(credential);
  //     final User user = userCredential.user!;
  //     print(user);
  //     // Handle successful sign-in
  //     if (user.emailVerified == false) {
  //       _isLoading = false;
  //       snackErrorMessage(
  //           message: "Email is not verified! Check email to verify Account!",
  //           context: context);
  //       print(_reqMessage);
  //       notifyListeners();
  //     } else {
  //       _isLoading = false;
  //       snackMessage(message: "Login Successful!", context: context);
  //       print(user);
  //       userEmail = user.email!;
  //       userName = user.displayName!;
  //       profileImage = user.photoURL ?? Image.asset(ImageAssets.logo) as String;
  //       userPhone = user.phoneNumber.toString();
  //       uid = user.uid;
  //       DatabaseProvider().saveEmail(userEmail);
  //       DatabaseProvider().saveName(userName);
  //       DatabaseProvider().saveUserID(uid);

  //       PageNavigator(ctx: context).nextPage(page: const Dashboard());

  //       notifyListeners();
  //     }
  //   } catch (e) {
  //     notifyListeners();
  //     print(e.toString());
  //     if (e is FirebaseAuthException) {
  //       if (e.code == "user-not-found") {
  //         _isLoading = false;
  //         snackErrorMessage(message: e.code, context: context);
  //         _reqMessage = e.code;
  //       } else {
  //         _isLoading = false;
  //         snackErrorMessage(message: e.message!, context: context);
  //         notifyListeners();
  //       }
  //     }
  //   }
  // }

  void signOut({required BuildContext context}) async {
    _isLoading = true;
    snackMessage(message: "Logout Successful!", context: context);
    notifyListeners();
    PageNavigator(ctx: context).nextPage(page: const Dashboard());

    try {
      // await auth.signOut();
      // await googleSignIn.signOut();
      DatabaseProvider().logout(context);
      _isLoading = false;
      notifyListeners();
    } catch (error) {
      // Handle signout errors
      // if (error is FirebaseAuthException) {
      //   if (error.code == "user-not-found") {
      //     _loading = false;
      //     snackErrorMessage(message: error.code, context: context);
      //     _reqMessage = error.code;
      //   } else {
      //     _loading = false;
      //     snackErrorMessage(message: error.message!, context: context);
      //     notifyListeners();
      //   }
      // }
      print(error);
    }
  }

  void clear() {
    _reqMessage = '';
    notifyListeners();
  }
}
