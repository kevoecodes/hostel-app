import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:house_rent/models/house.dart';
import 'package:house_rent/utils/api.dart';
import 'package:house_rent/utils/size_config.dart';
import 'package:house_rent/widgets/best_offer.dart';

class SearchPage extends StatefulWidget {
  var userData;
  SearchPage({Key? key, required this.userData}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<House>? searched_hostels;
  onSubmut(String value) {
    searchAction(value);
  }

  searchAction(String value) async {
    var res = await CallApi().authenticatedGetRequest(
        'api/v1/hostels-list/?search=' + value.toString(),
        context: context);
    print('Response ********************');
    print(res);
    if (res != null) {
      var body = json.decode(res.body);
      print(body);
      List houses = body['results'];
      List<House> _houses_list = [];
      for (var i in houses) {
        _houses_list.add(House(
            i['id'].toString(),
            i['name'],
            i['location'],
            i['cover_image'],
            i['description'],
            i['price'],
            i['sq_feet'],
            i['bed_description'],
            i['bathroom_description']));
      }
      setState(() {
        searched_hostels = _houses_list;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MySearchField(onSubmit: onSubmut),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Column(
              children: [
                searched_hostels == null
                    ? Center(
                        child: InkWell(
                          onTap: () {
                            // getHostelBookedList();
                          },
                          child: const CircularProgressIndicator(
                            color: Colors.black87,
                            strokeWidth: 3,
                          ),
                        ),
                      )
                    : searched_hostels!.length > 0
                        ? BestOffer(
                            house_list: searched_hostels!,
                            userData: widget.userData,
                          )
                        : Center(
                            child: Column(
                              children: [
                                Image.asset(
                                  "assets/images/no_data.gif",
                                  height: SizeConfig.screenHeight * 0.4, //40%
                                  width: SizeConfig.screenWidth,
                                ),
                                const Text('No results found')
                              ],
                            ),
                          )
              ],
            ),
          ),
        ));
  }
}

class MySearchField extends StatelessWidget implements PreferredSizeWidget {
  Function onSubmit;
  MySearchField({Key? key, required this.onSubmit}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: TextField(
          autofocus: true,
          onSubmitted: (value) => onSubmit(value),
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(8),
            ),
            hintText: 'Search here...',
            prefixIcon: Container(
              padding: const EdgeInsets.all(15),
              child: SvgPicture.asset('assets/icons/search.svg'),
            ),
            contentPadding: const EdgeInsets.all(2),
          ),
        ),
      ),
    );
  }
}
