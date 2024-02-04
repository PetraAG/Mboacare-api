import 'package:flutter/material.dart';

class Apis {
  /*----------------------------------Map Key--------------------------------------------------- */

  /*----------------------------------Base URL--------------------------------------------------- */
  static const String baseUrl =
      "https://us-central1-mboacare-api-v1.cloudfunctions.net/api";
  static const String logoUrl =
      'https://drive.google.com/drive/u/3/folders/159jj3T0pfMzCQsfMf-WtX9oMiefDf-gp';
  static const String linkIn = 'https://www.linkedin.com/company/mboalab/';

  /*----------------------------------Auth endpoints--------------------------------------------------- */

  static const String register = "$baseUrl/auth/register";
  static const String login = "$baseUrl/auth/sign-in";
  static const String updateProfile = "$baseUrl/auth/update-profile";
  static const String resetPassword = "$baseUrl/auth/reset-password";
  static const String changePassword = "$baseUrl/auth/change-password";
  static const String verificationLink = "$baseUrl/auth/send-link";

/*----------------------------------blog endpoints--------------------------------------------------- */
  static const String allBlog = "$baseUrl/blog/all-blogs";
  static const String addBlog = "$baseUrl/blog/add-blog";
  static const String myBlog = "$baseUrl/blog/my-blogs?q=";
  static const String updateBlog = "$baseUrl/blog/update-blog";
  static const String deleteBlog = "$baseUrl/blog/delete-blog/";
  static const String blogs = "$baseUrl/blog/blogs";
  static const String approveBlog = "$baseUrl/blog/approve-blog";

/*----------------------------------notification endpoints--------------------------------------------------- */
  static const String allNotification =
      "$baseUrl/notification/all-notifications";
  static const String singleNotification =
      "$baseUrl/notification/delete-notification/title";
  static const String deleteNotification =
      "$baseUrl/notification/delete-notification/title";

  // --------------------------Hospital endpoints--------------------------
  static const String allHospitals = '$baseUrl/hospital/all-hospital';
  static const String addHospital = '$baseUrl/hospital/add-hospital';
  static const String updateHospital = '$baseUrl/hospital/update-hospital';
  static const String searchHospitals = '$baseUrl/hospital/search?q=Wunmi';
  static const String deleteHospital = '$baseUrl/hospital/delete-hospital/';
  static const String myHospitals = '$baseUrl/hospital/my-hospitals?q=';
  static const String hospitals = "$baseUrl/hospital/hospitals";
  static const String approveHospital = "$baseUrl/hospital/approve-hospital";
}


