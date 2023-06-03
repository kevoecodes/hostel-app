import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:house_rent/screens/auth/request_otp.dart';
import 'package:house_rent/utils/snackbar.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CallApi {
  // static final String url = 'https://gnmcargo.com/cargo/';
  // static final String media_url = 'https://gnmcargo.com/streamer/v1/';
  static const String url = 'http://192.168.100.92:3500/';
  // static final String url = 'http://137.184.37.5:8000/cargo/';
  static const String media_url = 'http://192.168.100.92:5000/streamer/v1/';
  var token = '';

  // ignore: unused_element
  getJWTToken({context}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var _token = sharedPreferences.getString('refresh_token');
    if (_token != null) {
      var data = {"refresh": _token};
      var res = await http.post(
          Uri.parse(
            url + 'users/auth/token/refresh/',
          ),
          body: jsonEncode(data),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          });
      if (res.statusCode == 200) {
        var body = json.decode(res.body);
        sharedPreferences.setString("token", body['access']);
        token = 'JWT ' + body['access'];
      } else {
        await _navigateHome(context: context);
      }
    } else {
      _navigateHome(context: context);
    }
  }

  _navigateHome({context}) async {
    if (context != null) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.remove('user');
      await preferences.remove('token');
      await preferences.remove('cellphone');
      // await MyApp.localStorage(context)!.reload();
      // await MyApp.localStorage(context)!.remove('notifications');
      // await MyApp.localStorage(context)!.remove('announcements');
      await preferences.remove('notifications');
      await preferences.remove('registered_device');
      await preferences.remove('announcements');
      // await MyApp.updateNotifs(context); // Removing Notifications

      try {
        showSnack(context, 'No network');
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const RequestOTP()));
      } catch (e) {}
    }
  }

  _getNormalToken(context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var _token = sharedPreferences.getString('token');
    if (_token != null) {
      token = 'Token $_token';
    } else {
      await _navigateHome(context: context);
    }
  }

  getToken(context) async {
    await _getNormalToken(context);
  }

  evaluateResponseData(http.Response res, context, {login = false}) {
    if (res.statusCode == 200) {
      return res;
    } else if (res.statusCode == 500) {
      //--- Push to a page with 500 status, and code for troubleshoot
      // showSnack(context, AppLocalizations.of(context)!.unauthorized);
      return null;
    } else if (res.statusCode == 400) {
      //--- Push to a page with 500 status, and code for troubleshoot
      // scafold(context, 'Record Not Found');
      return null;
    } else if (res.statusCode == 401) {
      if (login) {
        showSnack(context, 'Invalid OTP');
      } else {
        _navigateHome(context: context);
      }
      return null;
    } else {
      // scafold(context, res.body);
      return null;
    }
  }

  authenticatedPostRequest(data, apiUrl, {context = null}) async {
    var fullUrl = url + apiUrl;
    await getToken(context);
    try {
      var res = await http.post(
          Uri.parse(
            fullUrl,
          ),
          body: jsonEncode(data),
          headers: _setHeaders());
      return evaluateResponseData(res, context);
    } catch (e) {
      showSnack(context, 'No Network!');
      return null;
    }
  }

  authenticatedGetRequest(apiUrl, {context = null}) async {
    await getToken(context);
    var fullUrl = url + apiUrl;
    try {
      var res = await http.get(Uri.parse(fullUrl), headers: _setHeaders());
      return evaluateResponseData(res, context);
    } catch (e) {
      debugPrint(e.toString());
      showSnack(context, 'No network!');
      return null;
    }
  }

  authenticatedPutRequest(apiUrl,
      {context = null, body: null, evaluate: true}) async {
    await getToken(context);
    var fullUrl = url + apiUrl;
    try {
      var res = await http.put(Uri.parse(fullUrl),
          body: jsonEncode(body), headers: _setHeaders());
      print(res.statusCode);
      return evaluateResponseData(res, context);
    } catch (e) {
      print(e);
      showSnack(context, 'No network!');
      return null;
    }
  }

  getRequest(apiUrl, {context = null}) async {
    var fullUrl = url + apiUrl;
    try {
      var res = await http.get(Uri.parse(fullUrl), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      });
      return evaluateResponseData(res, context);
    } catch (e) {
      showSnack(context, 'No network!');
      return null;
    }
  }

  postRequest(data, apiUrl,
      {context = null, login: false, evaluate: true}) async {
    var fullUrl = url + apiUrl;
    try {
      var res = await http.post(
          Uri.parse(
            fullUrl,
          ),
          body: jsonEncode(data),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          });
      if (evaluate) {
        return evaluateResponseData(res, context, login: login);
      }
      return res;
    } catch (e) {
      showSnack(context, 'No netowork!');
      return null;
    }
  }

  putRequest(apiUrl, {context = null}) async {
    var fullUrl = url + apiUrl;
    try {
      return await http.put(Uri.parse(fullUrl), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      });
    } catch (e) {
      showSnack(context, 'No network!');
      return null;
    }
  }

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': token
      };
}
