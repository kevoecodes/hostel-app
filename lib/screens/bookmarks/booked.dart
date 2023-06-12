import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:house_rent/models/booked_hostel.dart';
import 'package:house_rent/models/house.dart';
import 'package:house_rent/utils/api.dart';
import 'package:house_rent/utils/size_config.dart';
import 'package:house_rent/widgets/hostel_list.dart';

class BookedList extends StatefulWidget {
  const BookedList({Key? key}) : super(key: key);

  @override
  State<BookedList> createState() => _BookedListState();
}

class _BookedListState extends State<BookedList> {
  List<BookedHostel>? booked_hostels;

  getHostelBookedList() async {
    var res = await CallApi().authenticatedGetRequest(
        'api/v1/booked-hostels-list/',
        context: context);
    print('Response ********************');
    if (res != null) {
      var body = json.decode(res.body);
      print(body);
      List<BookedHostel> _booked_hostels = [];
      for (var i in body['results']) {
        _booked_hostels.add(BookedHostel(
            i['id'].toString(),
            i['status'],
            House(
                i['hostel']['id'].toString(),
                i['hostel']['name'],
                i['hostel']['location'],
                i['hostel']['cover_image'],
                i['hostel']['description'],
                i['hostel']['price'],
                i['hostel']['sq_feet'],
                i['hostel']['bed_description'],
                i['hostel']['bathroom_description'])));
      }

      setState(() {
        booked_hostels = _booked_hostels;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getHostelBookedList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booked Hostels'),
      ),
      body: RefreshIndicator(
          onRefresh: () async {
            await getHostelBookedList();
            // await getHouseList();
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Column(
                children: [
                  booked_hostels == null
                      ? Center(
                          child: InkWell(
                            onTap: () {
                              getHostelBookedList();
                            },
                            child: const CircularProgressIndicator(
                              color: Colors.black87,
                              strokeWidth: 3,
                            ),
                          ),
                        )
                      : booked_hostels!.length > 0
                          ? HostelBookedList(
                              booked_hostels: booked_hostels!,
                            )
                          : Center(
                              child: Column(
                                children: [
                                  Image.asset(
                                    "assets/images/no_data.gif",
                                    height: SizeConfig.screenHeight * 0.4, //40%
                                    width: SizeConfig.screenWidth,
                                  ),
                                  const Text('No data')
                                ],
                              ),
                            )
                ],
              ),
            ),
          )),
    );
  }
}
