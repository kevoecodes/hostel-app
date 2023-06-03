import 'package:flutter/material.dart';
import 'package:house_rent/screens/auth/widgets/register_user_form.dart';
import 'package:house_rent/utils/size_config.dart';

class RegisterUser extends StatefulWidget {
  const RegisterUser({Key? key}) : super(key: key);

  @override
  State<RegisterUser> createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          return Future.value(false);
        },
        child: Scaffold(
            body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: getProportionateScreenHeight(30),
                horizontal: getProportionateScreenWidth(20)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: SizeConfig.screenHeight * 0.07),
                  Text(
                    'Create an account',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: getProportionateScreenWidth(28),
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.01),
                  const Text(
                    'Welcome to this app, seems you are new here, please create an account to proceed',
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.05),
                  RegisterUserForm()
                ],
              ),
            ),
          ),
        )));
  }
}
