import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:house_rent/screens/auth/widgets/request_otp_form.dart';
import 'package:house_rent/utils/size_config.dart';

class RequestOTP extends StatefulWidget {
  const RequestOTP({Key? key}) : super(key: key);

  @override
  State<RequestOTP> createState() => _RequestOTPState();
}

class _RequestOTPState extends State<RequestOTP> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          backgroundColor: const Color(0xFFF5F6F6),
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          toolbarTextStyle: const TextTheme(
            headline6: TextStyle(color: Color(0XFF8B8B8B), fontSize: 18),
          ).bodyText2,
          titleTextStyle: const TextTheme(
            headline6: TextStyle(color: Color(0XFF8B8B8B), fontSize: 18),
          ).headline6,
          automaticallyImplyLeading: false,
          // title: const Text("Request OTP"),
        ),
        body: SafeArea(
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20)),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: SizeConfig.screenHeight * 0.09),
                    Text(
                      'Request OTP',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: getProportionateScreenWidth(28),
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.01),
                    const Text(
                      'Enter your valid phone number in the field below to receive four digits code for verification',
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.05),
                    const RequestOTPForm()
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
