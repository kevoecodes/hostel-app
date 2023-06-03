import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:house_rent/models/house.dart';
import 'package:house_rent/screens/details/details.dart';
import 'package:house_rent/widgets/circle_icon_button.dart';

class RecommendedHouse extends StatefulWidget {
  final List<House> house_list;
  const RecommendedHouse({Key? key, required this.house_list})
      : super(key: key);

  @override
  State<RecommendedHouse> createState() => _RecommendedHouseState();
}

class _RecommendedHouseState extends State<RecommendedHouse> {
  final recommendedList = House.generateRecommended();

  _handleNavigateToDetails(BuildContext context, House house) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Details(house: house),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: SizedBox(
        height: 340,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => GestureDetector(
            onTap: () =>
                _handleNavigateToDetails(context, widget.house_list[index]),
            child: Container(
              height: 300,
              width: 230,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(
                            widget.house_list[index].imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 15,
                    top: 15,
                    child: CircleIconButton(
                      iconUrl: 'assets/icons/mark.svg',
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      color: Colors.white54,
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.house_list[index].name,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                widget.house_list[index].address,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      fontSize: 12,
                                    ),
                              ),
                            ],
                          ),
                          CircleIconButton(
                            iconUrl: 'assets/icons/mark.svg',
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          separatorBuilder: (_, index) => const SizedBox(width: 20),
          itemCount: widget.house_list.length,
        ),
      ),
    );
  }
}
