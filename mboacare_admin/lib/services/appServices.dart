import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:mboacare_admin/model/blog_model.dart';
import 'package:mboacare_admin/model/hospital_model.dart';
import 'package:mboacare_admin/model/notification_model.dart';
import 'package:mboacare_admin/services/apis.dart';

class ApiServices {
  Future<List<BlogModel>> blogs() async {
    String url = Apis.blogs;

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Charset': 'utf-8',
    };

    final response = await http.get(Uri.parse(url), headers: headers);

    try {
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = json.decode(response.body);

        if (responseBody.containsKey('data')) {
          final List<dynamic> data = responseBody['data'];
          print(data);
          return data.map((item) => BlogModel.fromJson(item)).toList();
        } else {
          throw Exception('API response does not contain a "data" field.');
        }
      } else {
        throw Exception('Failed to load blog data');
      }
    } catch (e) {}
    return [];
  }

  Future<List<HospitalModel>> hospitals() async {
    String url = Apis.hospitals;

    print(url);

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Charset': 'utf-8',
    };

    final response = await http.get(Uri.parse(url), headers: headers);

    try {
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = json.decode(response.body);

        if (responseBody.containsKey('data')) {
          final List<dynamic> data = responseBody['data'];
          log(data.toString());
          return data.map((item) => HospitalModel.fromJson(item)).toList();
        } else {
          throw Exception('API response does not contain a "data" field.');
        }
      } else {
        throw Exception('Failed to load blog data');
      }
    } catch (e) {}
    return [];
  }

   Future<List<Notify>> fetchNotifications() async {
    String url = Apis.allNotification;

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Charset': 'utf-8',
    };

    final response = await http.get(Uri.parse(url), headers: headers);

    try {
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = json.decode(response.body);

        if (responseBody.containsKey('data')) {
          final List<dynamic> data = responseBody['data'];
          return data.map((item) => Notify.fromJson(item)).toList();
        } else {
          throw Exception('API response does not contain a "data" field.');
        }
      } else {
        throw Exception('Failed to load blog data');
      }
    } catch (e) {}
    return [];
  }
}
