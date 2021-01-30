import 'dart:async';
import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/http_exception.dart';
import '../models/user.dart';

class Auth with ChangeNotifier {
  String apiKey = "AIzaSyD43UTBnYNLYJslPFsWrhsQ9RAZbbTqdZU";
  String _token;
  DateTime _expiryDate;
  String _userId;
  Timer _authTimer;
  String _authUserId;

  bool get isAuth {
    return token != null;
  }

  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  String get userId {
    return _userId;
  }

  String get authUserId {
    fun();
    print("Hello ${_authUserId}");
    return _authUserId;
  }

  Future<void> fun() async {
    print("Hiiiiii   ${_authUserId}");
    final dbRef = FirebaseDatabase.instance.reference().child("users");

    await dbRef
        .orderByChild("userid")
        .equalTo(_userId)
        .once()
        .then((DataSnapshot dataSnapshot) {
      var newKey = dataSnapshot.value;
      print(newKey);
      // var _list = newKey.keys.toList();
      // print(_list);
      // var _lis = _list[0].values.toList();
      // print(_lis);
      // String userAuthid = _lis[1];
      // print(userAuthid);
      newKey.forEach((k, v) {
        _authUserId = k;
        //notifyListeners();
        print("Chutiyaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
        
      });
      print(_authUserId);
    });
  }

  Future<void> _authenticate(
      String email, String password, String name, String urlSegment) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=$apiKey';
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            responseData['expiresIn'],
          ),
        ),
      );
      //print(responseData);
      if (name != "") {
        User user = new User(name: name, email: email, userId: _userId);
       _authUserId = await user.addUsers(token);
        //print(_authUserId);
      }
      fun();
      print("Bye   ${_authUserId}");
      _autoLogout();
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode(
        {
          'token': _token,
          'userId': _userId,
          'expiryDate': _expiryDate.toIso8601String(),
        },
      );
      prefs.setString('userData', userData);
    } catch (error) {
      throw error;
    }
  }

  Future<void> signup(String email, String password, String name) async {
    return _authenticate(email, password, name, 'signUp');
  }

  Future<void> login(String email, String password) async {
    print("success");
    String name = "";
    return _authenticate(email, password, name, 'signInWithPassword');
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;
    final expiryDate = DateTime.parse(extractedUserData['expiryDate']);

    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }
    _token = extractedUserData['token'];
    _userId = extractedUserData['userId'];
    _expiryDate = expiryDate;
    notifyListeners();
    _autoLogout();
    return true;
  }

  Future<void> logout() async {
    _token = null;
    _userId = null;
    _expiryDate = null;
    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    // prefs.remove('userData');
    prefs.clear();
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer.cancel();
    }
    final timeToExpiry = _expiryDate.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  }
}
