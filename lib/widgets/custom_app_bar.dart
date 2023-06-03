import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:house_rent/screens/profile/profile.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  Function getUserData;
  CustomAppBar({Key? key, required this.getUserData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _handleNavigateToProfile() {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => Profile(getUserData: getUserData),
        ),
      );
    }

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset('assets/icons/menu.svg'),
            ),
            InkWell(
              onTap: _handleNavigateToProfile,
              child: const CircleAvatar(
                backgroundImage: AssetImage('assets/images/astronout.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
