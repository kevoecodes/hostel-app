import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:house_rent/models/house.dart';

class HouseInfo extends StatelessWidget {
  House house;
  HouseInfo({Key? key, required this.house}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            children: [
              _MenuInfo(
                imageUrl: 'assets/icons/bedroom.svg',
                content: house.bed_description,
              ),
              _MenuInfo(
                imageUrl: 'assets/icons/bathroom.svg',
                content: '${house.bathroom_description}\nSelf contained',
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Row(
          //   children: const [
          //     _MenuInfo(
          //       imageUrl: 'assets/icons/kitchen.svg',
          //       content: '2 Kitchen\n120 sqft',
          //     ),
          //     _MenuInfo(
          //       imageUrl: 'assets/icons/parking.svg',
          //       content: '5 Parking\n120 sqft',
          //     ),
          //   ],
          // )
        ],
      ),
    );
  }
}

class _MenuInfo extends StatelessWidget {
  final String imageUrl;
  final String content;

  const _MenuInfo({
    Key? key,
    required this.imageUrl,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          SvgPicture.asset(imageUrl),
          const SizedBox(width: 15),
          Text(
            content,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 12,
                ),
          ),
        ],
      ),
    );
  }
}
