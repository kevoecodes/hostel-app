import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:house_rent/screens/auth/verify_otp.dart';
import 'package:house_rent/utils/api.dart';
import 'package:house_rent/utils/size_config.dart';
import 'package:house_rent/utils/snackbar.dart';
import 'package:house_rent/widgets/custom_buttons.dart';
import 'package:house_rent/widgets/custom_surfix_icon.dart';
import 'package:house_rent/widgets/form_error.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RequestOTPForm extends StatefulWidget {
  const RequestOTPForm({Key? key}) : super(key: key);

  @override
  State<RequestOTPForm> createState() => _RequestOTPFormState();
}

class _RequestOTPFormState extends State<RequestOTPForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController userNumberController = TextEditingController();

  String? _selectedCountryCode = '+255';
  List<String> _countryCodes = ['+255'];

  var _isLoading = false;
  bool _not_found = false;

  String? phone;
  bool? remember = false;
  final List<String?> errors = [];
  String? appSignature;

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // registerAppSignature();
  }

  @override
  Widget build(BuildContext context) {
    var countryDropDown = Container(
      decoration: new BoxDecoration(
        border: Border(
          right: BorderSide(width: 0.5, color: Colors.grey),
        ),
      ),
      height: 45.0,
      margin: const EdgeInsets.all(3.0),
      //width: 300.0,
      child: DropdownButtonHideUnderline(
        child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButton(
            value: _selectedCountryCode,
            items: _countryCodes.map((String value) {
              return new DropdownMenuItem<String>(
                  value: value,
                  child: new Text(
                    value,
                    style: TextStyle(fontSize: 12.0),
                  ));
            }).toList(),
            onChanged: (value) {
              removeError(error: 'Invalid Number');
              setState(() {
                _not_found = false;
              });
              setState(() {
                _selectedCountryCode = value as String?;
              });
            },
            // style: Theme.of(context).textTheme.title,
          ),
        ),
      ),
    );

    return Container(
      width: double.infinity,
      margin: new EdgeInsets.only(top: 10.0, bottom: 10.0, right: 3.0),
      // color: Colors.white,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              enabled: !_isLoading,
              controller: userNumberController,
              keyboardType: TextInputType.phone,
              onSaved: (newValue) => phone = newValue,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  removeError(error: 'Invalid number');
                  setState(() {
                    _not_found = false;
                  });
                }
                return;
              },
              validator: (value) {
                print(value);
                if (value!.isEmpty ||
                    value.length > 10 ||
                    value.length < 9 ||
                    _not_found) {
                  addError(error: 'Invalid number');
                  return "";
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: 'Phone Number',
                hintText: 'Enter valid number',
                // If  you are using latest version of flutter then lable text and hint text shown like this
                // if you r using flutter less then 1.20.* then maybe this is not working properly
                floatingLabelBehavior: FloatingLabelBehavior.always,
                suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Call.svg"),
                contentPadding: const EdgeInsets.all(12.0),
                border: new OutlineInputBorder(
                    borderSide: new BorderSide(
                        color: const Color(0xFFE0E0E0), width: 0.1)),
                fillColor: Colors.white,
                prefixIcon: countryDropDown,
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(30)),
            FormError(errors: errors),
            SizedBox(height: getProportionateScreenHeight(10)),
            LoadButton(
              isLoading: _isLoading,
              text: 'Submit',
              press: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  // if all are valid then go to success screen
                  // KeyboardUtil.hideKeyboard(context);
                  _request_otp();
                  //Navigator.pushNamed(context, LoginSuccessScreen.routeName);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  _request_otp() async {
    setState(() {
      _isLoading = true;
    });
    String cellphone = _formatted_number();
    var data = {'cellphone': cellphone};
    var res = await CallApi()
        .postRequest(data, 'api/auth/request-otp', evaluate: false);

    if (res == null) {
      setState(() {
        _isLoading = false;
        // _not_found = true;
      });
      showSnack(context, 'No network!');
    } else {
      if (res.statusCode == 200) {
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        localStorage.setString("cellphone", cellphone);

        setState(() {
          _isLoading = false;
        });

        _handleNavigateToOTPVerification();
      } else {
        showSnack(context, 'Something went wrong!');
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  _handleNavigateToOTPVerification() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const VerifyOTP(),
      ),
    );
  }

  String _formatted_number() {
    var number = userNumberController.text;
    var code = _selectedCountryCode
        .toString()
        .substring(1, _selectedCountryCode.toString().length);
    if (number.length == 10) {
      number = number.substring(1, number.length);
    }
    var cellphone = code + number;
    return cellphone.toString();
  }
}
