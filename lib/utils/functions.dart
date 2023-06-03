import 'package:flutter/material.dart';
import 'package:house_rent/screens/auth/request_otp.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

checkLoginStatus(BuildContext context) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  if (sharedPreferences.getString("token") == null) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const RequestOTP()));
  }
}

formattedMoney(money) {
  return NumberFormat.currency(
    locale: 'en_US',
    symbol: 'TZS ',
  ).format(money);
}
