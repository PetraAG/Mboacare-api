


// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mboacare_admin/pages/dashboard/dashboard.dart';
import 'package:mboacare_admin/services/apis.dart';
import 'package:mboacare_admin/ustils/router.dart';
import 'package:mboacare_admin/ustils/snack_error.dart';
import 'package:mboacare_admin/ustils/snack_succ.dart';

class ApproveHospitalProvider extends ChangeNotifier{
  String _reqMessage = "";
  bool _isLoading = false;

  String get reqMessage => _reqMessage;
  bool get isLoading => _isLoading;

  Future<void> approveHospital(
      {required BuildContext context,
      required String id,
      required bool status}) async {
    _isLoading = true;
    notifyListeners();

    String url = Apis.approveHospital;
    print(url);
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Charset': 'utf-8'
    };

    final body = {"id": id, "status": status};

    print(body);
    http.Response req = await http.post(Uri.parse(url),
        body: json.encode(body), headers: headers);
    try {
      if (req.statusCode == 200 || req.statusCode == 201) {
        _isLoading = false;
        final res = json.decode(req.body);
        snackMessage(message: res['message'].toString(), context: context);
        notifyListeners();
        PageNavigator(ctx: context).nextPage(page: const Dashboard());
        //Navigator.pop(context);
      }
    } catch (e) {
      _isLoading = false;
      final res = json.decode(req.body);
      snackErrorMessage(message: res['message'].toString(), context: context);
      notifyListeners();
    }
  }

  void clear() {
    _reqMessage = '';
    notifyListeners();
  }
}