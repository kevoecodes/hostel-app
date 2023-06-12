import 'package:flutter/material.dart';
import 'package:house_rent/models/house.dart';
import 'package:house_rent/screens/details/success_booked.dart';
import 'package:house_rent/utils/api.dart';
import 'package:house_rent/utils/snackbar.dart';
import 'package:house_rent/widgets/about.dart';
import 'package:house_rent/widgets/content_intro.dart';
import 'package:house_rent/widgets/details_app_bar.dart';
import 'package:house_rent/widgets/house_info.dart';

class Details extends StatelessWidget {
  final House house;
  var userData;
  Details({Key? key, required this.house, required this.userData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DetailsAppBar(house: house),
            const SizedBox(height: 20),
            ContentIntro(house: house),
            const SizedBox(height: 20),
            HouseInfo(house: house),
            const SizedBox(height: 10),
            About(house: house),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                onPressed: () {
                  _book_now(context);
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  primary: Theme.of(context).primaryColor,
                ),
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: const Text(
                    'Book Now',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _book_now(BuildContext context) {
    var data = {'user': userData['id'].toString(), 'hostel': house.id};
    var res = CallApi().authenticatedPostRequest(data, 'api/v1/hostel-booked');
    if (res != null) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const SuccessfullBooked(),
        ),
      );
    } else {
      showSnack(context, 'Failed to book this hostel');
    }
  }
}
