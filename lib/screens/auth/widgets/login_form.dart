import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:house_rent/screens/auth/register_user.dart';
import 'package:house_rent/screens/home/home.dart';
import 'package:house_rent/utils/api.dart';
import 'package:house_rent/utils/size_config.dart';
import 'package:house_rent/utils/snackbar.dart';
import 'package:house_rent/widgets/custom_buttons.dart';
import 'package:house_rent/widgets/custom_surfix_icon.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String? email, password;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 10.0, bottom: 10.0, right: 3.0),
        // color: Colors.white,
        child: Form(
            key: _formKey,
            child: Column(children: [
              TextFormField(
                enabled: !_isLoading,
                keyboardType: TextInputType.emailAddress,
                onSaved: (newValue) => setState(() {
                  email = newValue;
                }),
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    // removeError(
                    //     error: 'AppLocalizations.of(context)!.sign_in_err_2');
                    // setState(() {
                    //   _not_found = false;
                    // });
                  }
                  return;
                },
                validator: (value) {
                  print(value);
                  // if (value!.isEmpty ||
                  //     value.length > 10 ||
                  //     value.length < 9 ||
                  //     _not_found) {
                  //   addError(
                  //       error: 'AppLocalizations.of(context)!.sign_in_err_2');
                  //   return "";
                  // }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Username',
                  hintText: 'eg. john',
                  // If  you are using latest version of flutter then lable text and hint text shown like this
                  // if you r using flutter less then 1.20.* then maybe this is not working properly
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  suffixIcon:
                      CustomSurffixIcon(svgIcon: "assets/icons/user_icon.svg"),
                  contentPadding: const EdgeInsets.all(12.0),
                  border: new OutlineInputBorder(
                      borderSide: new BorderSide(
                          color: const Color(0xFFE0E0E0), width: 0.1)),
                  fillColor: Colors.white,
                  // prefixIcon: countryDropDown,
                ),
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.03),
              TextFormField(
                obscureText: true,
                enabled: !_isLoading,
                keyboardType: TextInputType.emailAddress,
                onSaved: (newValue) => setState(() {
                  password = newValue;
                }),
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    // removeError(
                    //     error: 'AppLocalizations.of(context)!.sign_in_err_2');
                    // setState(() {
                    //   _not_found = false;
                    // });
                  }
                  return;
                },
                validator: (value) {
                  print(value);
                  // if (value!.isEmpty ||
                  //     value.length > 10 ||
                  //     value.length < 9 ||
                  //     _not_found) {
                  //   addError(
                  //       error: 'AppLocalizations.of(context)!.sign_in_err_2');
                  //   return "";
                  // }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: '*********',
                  // If  you are using latest version of flutter then lable text and hint text shown like this
                  // if you r using flutter less then 1.20.* then maybe this is not working properly
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  suffixIcon:
                      CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
                  contentPadding: const EdgeInsets.all(12.0),
                  border: new OutlineInputBorder(
                      borderSide: new BorderSide(
                          color: const Color(0xFFE0E0E0), width: 0.1)),
                  fillColor: Colors.white,
                  // prefixIcon: countryDropDown,
                ),
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.03),
              LoadButton(
                isLoading: _isLoading,
                text: 'Submit',
                press: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // if all are valid then go to success screen
                    // KeyboardUtil.hideKeyboard(context);
                    // _login();
                    // print(full_name);
                    print(email);
                    _login_user();
                    //Navigator.pushNamed(context, LoginSuccessScreen.routeName);
                  }
                },
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.03),
              Row(
                children: [
                  const Text('Do not have an account '),
                  GestureDetector(
                    onTap: () {
                      _handleNavigateRegister();
                    },
                    child: const Text(
                      'Register account',
                      style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline),
                    ),
                  )
                ],
              ),
            ])));
  }

  _login_user() async {
    setState(() {
      _isLoading = true;
    });

    var data = {
      'email': email,
      'password': password,
    };
    var res = await CallApi().postRequest(data, 'api/auth/login-user',
        context: context, login: true);
    if (res != null) {
      if (res.statusCode == 200) {
        var body = json.decode(res.body);
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        localStorage.setString("token", body['token']);
        // localStorage.setString("refresh_token", body['refresh']);
        localStorage.setString("user", json.encode(body['user']));

        _handleNavigateHome();
      } else {
        setState(() {
          _isLoading = false;
        });
        showSnack(context, 'Invalid Credentials');
      }
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  _handleNavigateHome() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Home()));
  }

  _handleNavigateRegister() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const RegisterUser()));
  }
}
