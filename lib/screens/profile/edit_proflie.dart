import 'package:flutter/material.dart';
import 'package:house_rent/utils/size_config.dart';

import '../auth/widgets/register_user_form.dart';

class EditProfile extends StatefulWidget {
  Function on_finish;
  final userData;
  EditProfile({Key? key, required this.on_finish, required this.userData})
      : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    print('+' * 10);
    print(widget.userData);
    print(widget.userData['full_name']);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFF5F6F6),
          elevation: 0,
        ),
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
                    'Edit account',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: getProportionateScreenWidth(28),
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.05),
                  RegisterUserForm(
                    is_edit: true,
                    on_finish: widget.on_finish,
                    initialEmail:
                        widget.userData != null ? widget.userData['email'] : '',
                    initialUserName: widget.userData != null
                        ? widget.userData['full_name']
                        : '',
                  )
                ],
              ),
            ),
          ),
        ));
    ;
  }
}
