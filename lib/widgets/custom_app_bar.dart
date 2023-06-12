import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:house_rent/screens/bookmarks/booked.dart';
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
            InkWell(
              onTap: _handleNavigateToProfile,
              child: const CircleAvatar(
                backgroundImage: AssetImage('assets/images/astronout.png'),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const BookedList()));
              },
              child: Container(
                height: 25,
                width: 25,
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                  color: Colors.black54,
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset('assets/icons/mark.svg'),
              ),
            ),
            // IconButton(
            //   onPressed: () {},
            //   icon: SvgPicture.asset('assets/icons/mark.svg'),
            // ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
