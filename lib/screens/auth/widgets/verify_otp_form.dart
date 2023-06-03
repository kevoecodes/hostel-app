import 'dart:convert';

import 'package:android_sms_retriever/android_sms_retriever.dart';
import 'package:flutter/material.dart';
import 'package:house_rent/screens/auth/register_user.dart';
import 'package:house_rent/screens/auth/widgets/otp_custom_field.dart';
import 'package:house_rent/screens/home/home.dart';
import 'package:house_rent/utils/api.dart';
import 'package:house_rent/utils/size_config.dart';
import 'package:house_rent/utils/snackbar.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VerifyOTPForm extends StatefulWidget {
  const VerifyOTPForm({Key? key}) : super(key: key);

  @override
  State<VerifyOTPForm> createState() => _VerifyOTPFormState();
}

class _VerifyOTPFormState extends State<VerifyOTPForm> {
  FocusNode? pin2FocusNode;
  FocusNode? pin3FocusNode;
  FocusNode? pin4FocusNode;

  TextEditingController verifyCodeController1 = TextEditingController();
  TextEditingController verifyCodeController2 = TextEditingController();
  TextEditingController verifyCodeController3 = TextEditingController();
  TextEditingController verifyCodeController4 = TextEditingController();

  OtpFieldController otpController = OtpFieldController();
  var otp_error = false;

  // late OTPInteractor _otpInteractor;
  // late OTPTextEditController controller;

  @override
  void initState() {
    super.initState();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
    // listenCode();
  }

  @override
  void dispose() async {
    super.dispose();
    pin2FocusNode!.dispose();
    pin3FocusNode!.dispose();
    pin4FocusNode!.dispose();
    // await AndroidSmsRetriever.stopSmsListener();
    // await AndroidSmsRetriever.stopOneTimeConsentListener();
  }

  void nextField(String value, FocusNode? focusNode) {
    if (value.length == 1) {
      focusNode!.requestFocus();
    }
  }

  void listenCode() async {
    try {
      String? smsCode = await AndroidSmsRetriever.listenForOneTimeConsent(
          senderPhoneNumber: 'GNMCARGO');
      // print(smsCode);
      String otpcode = smsCode.toString().replaceAll(new RegExp(r'[^0-9]'), '');
      // print(otpcode);
      //prase code from the OTP sms
      otpcode.split("");
      List<String> pin = [];
      for (var i in otpcode.split("")) {
        pin.add(i.toString());
      }
      // _checkifNumberExist(otpcode.toString());
      otpController.set(pin);
      AndroidSmsRetriever.stopOneTimeConsentListener();
    } catch (e) {
      // print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          SizedBox(height: SizeConfig.screenHeight * 0.15),
          OTPCustomTextFieldState(
              controller: otpController,
              length: 4,
              width: MediaQuery.of(context).size.width,
              textFieldAlignment: MainAxisAlignment.spaceAround,
              otpFieldStyle: OtpFieldStyle(
                focusBorderColor: Colors.orange, //(here)
                // borderColor: Colors.red
              ),
              fieldWidth: 45,
              fieldStyle: FieldStyle.box,
              hasError: otp_error,
              outlineBorderRadius: 15,
              style: TextStyle(fontSize: 17),
              onChanged: (pin) {
                // print("Changed: " + pin);
                if (otp_error) {
                  setState(() {
                    otp_error = false;
                  });
                }
              },
              onCompleted: (pin) {
                // print("Completed: " + pin);
                _checkifNumberExist(pin);
              }),
          SizedBox(height: SizeConfig.screenHeight * 0.15),
        ],
      ),
    );
  }

  void _checkifNumberExist(pin) async {
    SharedPreferences localStorage_phonenumber =
        await SharedPreferences.getInstance();
    var userJson_phonenumber = localStorage_phonenumber.getString('cellphone')!;

    var data = {
      'cellphone': userJson_phonenumber,
      'code': pin,
    };
    var res = await CallApi().postRequest(data, 'api/auth/verify-otp',
        context: context, login: true);
    if (res != null) {
      if (res.statusCode == 200) {
        var body = json.decode(res.body);
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        localStorage.setString("token", body['token']);
        // localStorage.setString("refresh_token", body['refresh']);
        localStorage.setString("user", json.encode(body['user']));
        if (body['is_new']) {
          _handleNavigateRegisterUser();
        } else {
          _handleNavigateHome();
        }
      } else {
        setState(() {
          otp_error = true;
        });
        showSnack(context, 'Incvalid OTP');
      }
    }
  }

  _handleNavigateHome() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Home()));
  }

  _handleNavigateRegisterUser() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const RegisterUser()));
  }
}
