import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:house_rent/models/booked_hostel.dart';
import 'package:house_rent/utils/functions.dart';

class HostelBookedList extends StatefulWidget {
  List<BookedHostel> booked_hostels;
  HostelBookedList({Key? key, required this.booked_hostels}) : super(key: key);

  @override
  State<HostelBookedList> createState() => _HostelBookedListState();
}

class _HostelBookedListState extends State<HostelBookedList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...widget.booked_hostels
            .map(
              (offer) => GestureDetector(
                onTap: () {
                  // _handleNavigateToDetails(context, offer);
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Stack(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 150,
                            height: 80,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: CachedNetworkImageProvider(
                                    offer.house.imageUrl),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                offer.house.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              Text(
                                formattedMoney(offer.house.price),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      fontSize: 14,
                                    ),
                              ),
                              const SizedBox(height: 10),
                            ],
                          ),
                        ],
                      ),
                      // const Positioned(
                      //     right: 0,
                      //     child: CircleIconButton(
                      //       iconUrl: 'assets/icons/heart.svg',
                      //       color: Colors.grey,
                      //     ))
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            offer.getStatus(),
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      fontSize: 14,
                                    ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
            .toList(),
      ],
    );
  }
}
