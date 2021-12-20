import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:plant_app/Models/Cart.dart';
import 'package:plant_app/http_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  Cart instance;
  bool _islogOut;
  String _token;
  String _userId;
  DateTime _expiryDate;
  Timer _authTimer;
  bool get isAuth {
    if(_token != null){
      return true;
    }
    return false;
  }

  String get userId {
    return _userId;
  }

  String get token {
    if (_token != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _expiryDate != null) {
      return _token;
    } else
    return null;
  }

  Future<void> _authenticate(String email, String password, String UrlSegment) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$UrlSegment?key=AIzaSyAgpiCxlr5NBRNkH5VBTzw8MHHvcaLkPrc';
   try{ final response = await http.post(Uri.parse(url), body:json.encode( {
      'email': email,
      'password': password,
      'returnSecureToken': true
    }));
    final responseData = json.decode(response.body);
    if (responseData['error'] != null) {
      throw HttpException(responseData['error']['message']);
    }
    _token = responseData['idToken'];
    _userId = responseData['localId'];
    _expiryDate = DateTime.now()
        .add(Duration(seconds: int.parse(responseData['expiresIn'])));
        print(responseData);
     _autoLogout();
    notifyListeners();
    
    final pref=await SharedPreferences.getInstance();
    final userData=json.encode({
      'token':_token,
      'userId':_userId,
      'expiryDate':_expiryDate.toIso8601String()
    });
    pref.setString('userData',userData);
   } catch (error) {
     throw error;
   }
  }
  
  Future <bool> tryLogin() async{
final prefs= await SharedPreferences.getInstance();
if(!prefs.containsKey('userData')){
  return false;
}
final extractedData=json.decode(prefs.getString('userData')) as Map<String,dynamic>;
final extractedExpiryDate=DateTime.parse(extractedData['expiryDate']);
if(extractedExpiryDate.isBefore(DateTime.now())){
  return false;
}
_token=extractedData['token'];
_userId=extractedData['userId'];
_expiryDate=extractedExpiryDate;
notifyListeners();
_autoLogout();
return true;
  }


  Future <void> signUp(String email,String password)
  {
    return _authenticate(email, password,'signUp');
  }

  Future <void> Login(String email,String password){
    return _authenticate(email, password,'signInWithPassword');
  }

  Future <void> Logout()  async{
    _token = null;
    _userId = null;
    _expiryDate = null;
    
    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }
 
    notifyListeners();
    final pref=await SharedPreferences.getInstance();
    pref.clear();
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer.cancel();
    }
    final timeToExpiry=_expiryDate.difference(DateTime.now()).inSeconds;
  Timer(Duration(seconds: timeToExpiry), Logout);
  }
 
}
