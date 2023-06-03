import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:house_rent/screens/auth/request_otp.dart';
import 'package:house_rent/screens/home/home.dart';
import 'package:house_rent/screens/profile/edit_proflie.dart';
import 'package:house_rent/screens/profile/widgets/profile_menu.dart';
import 'package:house_rent/screens/profile/widgets/profile_pic.dart';
import 'package:house_rent/utils/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  Function getUserData;
  Profile({Key? key, required this.getUserData}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var userData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getUserInfo();
  }

  void _getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString('user');
    var user = json.decode(userJson!);
    setState(() {
      userData = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F6),
      appBar: AppBar(
          backgroundColor: const Color(0xFFF5F6F6),
          elevation: 0,
          title: const Text('Profile')),
      body: SafeArea(
        child: Padding(
          padding:
              EdgeInsets.symmetric(vertical: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
              child: Center(
            child: Column(
              children: [
                ProfilePic(),
                SizedBox(height: 20),
                Text(
                  userData != null ? userData['full_name'] : '',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(userData != null ? userData['email'] : ''),
                SizedBox(height: 20),
                ProfileMenu(
                  text: 'Edit Account',
                  icon: "assets/icons/user_icon.svg",
                  press: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditProfile(
                                  on_finish: () {
                                    _getUserInfo();
                                    widget.getUserData();
                                  },
                                  userData: userData,
                                )));
                  },
                ),
                ProfileMenu(
                  text: 'Logout',
                  icon: "assets/icons/logout.svg",
                  press: () async {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.warning,
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                        width: 2,
                      ),
                      width: 350,
                      buttonsBorderRadius: const BorderRadius.all(
                        Radius.circular(2),
                      ),
                      dismissOnTouchOutside: true,
                      dismissOnBackKeyPress: false,
                      onDismissCallback: (type) {},
                      headerAnimationLoop: false,
                      animType: AnimType.bottomSlide,
                      title: 'Alert!',
                      desc: 'Are you sure you want to logout?',
                      showCloseIcon: true,
                      btnCancelOnPress: () {},
                      btnOkOnPress: () async {
                        SharedPreferences preferences =
                            await SharedPreferences.getInstance();
                        preferences.clear();

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RequestOTP()));
                      },
                    ).show();
                  },
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }
}
