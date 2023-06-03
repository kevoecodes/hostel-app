import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:house_rent/screens/auth/widgets/verify_otp_form.dart';
import 'package:house_rent/utils/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VerifyOTP extends StatefulWidget {
  const VerifyOTP({Key? key}) : super(key: key);

  @override
  State<VerifyOTP> createState() => _VerifyOTPState();
}

class _VerifyOTPState extends State<VerifyOTP> {
  final bool on_back = false;
  String? cellphone;

  getCellPhone() async {
    var localStorage = await SharedPreferences.getInstance();
    var _no = localStorage.getString('cellphone');

    setState(() {
      cellphone = _no;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCellPhone();
  }

  @override
  Widget build(BuildContext context) {
    setOnback() {
      // setState(() {
      //   _resend_visibility = true;
      // });
    }
    return WillPopScope(
        onWillPop: () async {
          return Future.value(on_back);
        },
        child: Scaffold(
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
                title: const Text('Verify OTP')),
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
                          'OTP Verification',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: getProportionateScreenWidth(28),
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'We sent your code to ' + cellphone.toString(),
                          textAlign: TextAlign.center,
                        ),
                        buildTimer(setOnback, context),
                        SizedBox(height: SizeConfig.screenHeight * 0.05),
                        const VerifyOTPForm()
                      ],
                    ),
                  ),
                ),
              ),
            )));
  }

  Row buildTimer(setOnBack, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Your code will expire in'),
        TweenAnimationBuilder(
          tween: Tween(begin: 60.0, end: 0.0),
          duration: Duration(minutes: 2),
          onEnd: () => setOnBack(),
          builder: (_, dynamic value, child) {
            return Text(" 00:${value.toInt()}",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ));
          },
        ),
      ],
    );
  }
}
