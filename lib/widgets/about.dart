import 'package:flutter/material.dart';
import 'package:house_rent/models/house.dart';

class About extends StatelessWidget {
  House house;
  About({Key? key, required this.house}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About',
            style: Theme.of(context).textTheme.headline1!.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 10),
          Text(
            house.descriptions,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 14,
                ),
          )
        ],
      ),
    );
  }
}
