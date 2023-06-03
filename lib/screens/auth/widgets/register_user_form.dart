import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:house_rent/screens/home/home.dart';
import 'package:house_rent/utils/api.dart';
import 'package:house_rent/utils/size_config.dart';
import 'package:house_rent/utils/snackbar.dart';
import 'package:house_rent/widgets/custom_buttons.dart';
import 'package:house_rent/widgets/custom_surfix_icon.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterUserForm extends StatefulWidget {
  bool is_edit;
  String? initialEmail, initialUserName;
  Function? on_finish;

  RegisterUserForm(
      {Key? key,
      this.is_edit = false,
      this.on_finish,
      this.initialEmail,
      this.initialUserName})
      : super(key: key);

  @override
  State<RegisterUserForm> createState() => _RegisterUserFormState();
}

class _RegisterUserFormState extends State<RegisterUserForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool agree = false;
  String? full_name;
  String? email;
  String? user_id;
  String? cellphone;

  String getInitialName() {
    if (widget.initialUserName != null) {
      return widget.initialUserName!;
    }
    return '';
  }

  String getInitialEmail() {
    if (widget.initialEmail != null) {
      return widget.initialEmail!;
    }
    return '';
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserID();
    _assignInitials();
  }

  _assignInitials() {
    print('Inside');
    print('#' * 20);
    print(widget.initialEmail);
    print(widget.initialUserName);
    if (widget.initialEmail != null && widget.initialUserName != null) {
      // userNameController.text = widget.initialUserName!;
    }
  }

  getUserID() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = localStorage.getString('user');
    if (user != null) {
      setState(() {
        user_id = json.decode(user)['id'].toString();
        cellphone = json.decode(user)['cellphone'].toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        margin: new EdgeInsets.only(top: 10.0, bottom: 10.0, right: 3.0),
        // color: Colors.white,
        child: Form(
            key: _formKey,
            child: Column(children: [
              TextFormField(
                enabled: !_isLoading,
                initialValue: getInitialName(),
                keyboardType: TextInputType.name,
                onSaved: (newValue) => setState(() {
                  full_name = newValue;
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
                  labelText: 'Full Name',
                  hintText: 'eg. John Doe',
                  // If  you are using latest version of flutter then lable text and hint text shown like this
                  // if you r using flutter less then 1.20.* then maybe this is not working properly
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  suffixIcon:
                      CustomSurffixIcon(svgIcon: "assets/icons/Call.svg"),
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
                enabled: !_isLoading,
                initialValue: getInitialEmail(),
                keyboardType: TextInputType.emailAddress,
                onSaved: (newValue) => email = newValue,
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
                  labelText: 'Email Address',
                  hintText: 'eg. example@example.com',
                  // If  you are using latest version of flutter then lable text and hint text shown like this
                  // if you r using flutter less then 1.20.* then maybe this is not working properly
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  suffixIcon:
                      CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
                  contentPadding: const EdgeInsets.all(12.0),
                  border: new OutlineInputBorder(
                      borderSide: new BorderSide(
                          color: const Color(0xFFE0E0E0), width: 0.1)),
                  fillColor: Colors.white,
                  // prefixIcon: countryDropDown,
                ),
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.03),
              Row(
                children: [
                  Material(
                    child: Checkbox(
                      activeColor: Theme.of(context).primaryColor,
                      value: agree,
                      onChanged: (value) {
                        setState(() {
                          agree = value ?? false;
                        });
                      },
                    ),
                  ),
                  const Text('I have read and accept '),
                  GestureDetector(
                    onTap: () {},
                    child: const Text(
                      'Terms and Conditions',
                      style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline),
                    ),
                  )
                ],
              ),
              LoadButton(
                isLoading: _isLoading,
                text: 'Submit',
                press: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // if all are valid then go to success screen
                    // KeyboardUtil.hideKeyboard(context);
                    // _login();
                    print(full_name);
                    print(email);
                    _register_user();
                    //Navigator.pushNamed(context, LoginSuccessScreen.routeName);
                  }
                },
              ),
            ])));
  }

  _register_user() async {
    setState(() {
      _isLoading = true;
    });
    var data = {'full_name': full_name, 'email': email, 'cellphone': cellphone};
    var res = await CallApi().authenticatedPutRequest(
        'api/v1/user/' + user_id.toString(),
        body: data,
        evaluate: false);

    if (res == null) {
      setState(() {
        _isLoading = false;
        // _not_found = true;
      });
      showSnack(context, 'No network!');
    } else {
      if (res.statusCode == 200) {
        print('Response***************************');
        print(res.body);
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        localStorage.setString("user", res.body);

        setState(() {
          _isLoading = false;
        });
        if (widget.is_edit) {
          showSnack(context, 'User Details edited successfully');
          widget.on_finish!();
          Home.getUserInfo(context);
          _handleNavigateProfile();
        } else {
          _handleNavigateHome();
        }
      } else {
        showSnack(context, 'Something went wrong!');
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  _handleNavigateHome() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const Home(),
      ),
    );
  }

  _handleNavigateProfile() {
    Navigator.pop(context);
  }
}
