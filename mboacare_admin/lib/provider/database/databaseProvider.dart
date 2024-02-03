import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';



class DatabaseProvider extends ChangeNotifier {
  Future<SharedPreferences> _pref = SharedPreferences.getInstance();


  String _name = '';
  String _phone = '';
  String _userEmail = '';
  String _uid = '';


  String get name => _name;
  String get phone => _phone;
  String get userEmail => _userEmail;
  String get uid => _uid;

  //saveName
  void saveName(String name) async {
    SharedPreferences value = await _pref;
    value.setString('name', name);
  }

  //savePhone
  void savePhone(String phone) async {
    SharedPreferences value = await _pref;
    value.setString('phone', phone);
  }

  //saveEmail
  void saveEmail(String userEmail) async {
    SharedPreferences value = await _pref;
    value.setString('userEmail', userEmail);
  }

  //saveUserID
  void saveUserID(String uid) async {
    SharedPreferences value = await _pref;
    value.setString('uid', uid);
  }

  //Getting name
  Future<String> getName() async {
    SharedPreferences value = await _pref;
    if (value.containsKey('name')) {
      String data = value.getString('name') as String;
      _name = data;
      notifyListeners();
      return _name;
    } else {
      _name = '';
      notifyListeners();
      return '';
    }
  }

  //Getting phone
  Future<String> getPhone() async {
    SharedPreferences value = await _pref;
    if (value.containsKey('phone')) {
      String data = value.getString('phone') as String;
      _phone = data;
      notifyListeners();
      return _phone;
    } else {
      _phone = '';
      notifyListeners();
      return '';
    }
  }

  //Getting email
  Future<String> getEmail() async {
    SharedPreferences value = await _pref;
    if (value.containsKey('userEmail')) {
      String data = value.getString('userEmail') as String;
      _userEmail = data;
      notifyListeners();
      return _userEmail;
    } else {
      _userEmail = '';
      notifyListeners();
      return '';
    }
  }

//Getting userID
  Future<String> getUserID() async {
    SharedPreferences value = await _pref;
    if (value.containsKey('uid')) {
      String data = value.getString('uid') as String;
      _uid = data;
      notifyListeners();
      return _uid;
    } else {
      _uid = '';
      notifyListeners();
      return '';
    }
  }
  void logout(BuildContext context) async {
    final value = await _pref;
    value.clear();
  }
}
