import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:house_rent/models/house.dart';
import 'package:house_rent/utils/api.dart';
import 'package:house_rent/utils/functions.dart';
import 'package:house_rent/widgets/recommended_house.dart';
import 'package:house_rent/widgets/custom_app_bar.dart';
import 'package:house_rent/widgets/search_input.dart';
import 'package:house_rent/widgets/welcome_text.dart';
import 'package:house_rent/widgets/categories.dart';
import 'package:house_rent/widgets/best_offer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();

  static void getUserInfo(BuildContext context) {
    print('EDITING ININTIAL');
    _HomeState? state = context.findAncestorStateOfType<_HomeState>();
    if (state != null) {
      print('STATE IS NOT NULL');
      state.getUserInfo();
    }
    print('STATE IS NULL');
  }
}

class _HomeState extends State<Home> {
  List<House>? house_list;
  List<House>? best_deal_houses;
  var userData;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLoginStatus(context);
    getUserInfo();
    getHouseList();
  }

  void getUserInfo() async {
    print('Getting user');
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    print('Leveeve');
    var userJson = localStorage.getString('user');
    var user = json.decode(userJson!);
    setState(() {
      userData = user;
    });
  }

  getHouseList() async {
    List<House>? _house_list = await getTopRecommended();
    List<House>? _best_deal_house_list = await getBestDealHouseList();

    setState(() {
      house_list = _house_list;
      best_deal_houses = _best_deal_house_list;
    });
  }

  Future<List<House>?> getTopRecommended() async {
    var res = await CallApi()
        .authenticatedGetRequest('api/v1/hostels-list/', context: context);
    print('Response ********************');
    print(res);
    if (res != null) {
      var body = json.decode(res.body);
      print(body);
      List houses = body['results'];
      List<House> _houses_list = [];
      for (var i in houses) {
        _houses_list.add(House(
            i['name'],
            i['location'],
            i['cover_image'],
            i['description'],
            i['price'],
            i['sq_feet'],
            i['bed_description'],
            i['bathroom_description']));
      }

      return _houses_list;
    }
    return null;
  }

  Future<List<House>?> getBestDealHouseList() async {
    var res = await CallApi().authenticatedGetRequest(
        'api/v1/hostels-list/?order_by=1',
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
            i['name'],
            i['location'],
            i['cover_image'],
            i['description'],
            i['price'],
            i['sq_feet'],
            i['bed_description'],
            i['bathroom_description']));
      }

      return _houses_list;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: CustomAppBar(
        getUserData: getUserInfo,
      ),
      body: RefreshIndicator(
        color: Colors.black87,
        backgroundColor: Colors.white70,
        strokeWidth: 3.0,
        onRefresh: () async {
          await getHouseList();
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WelcomeText(userData: userData),
              const SearchInput(),
              house_list == null
                  ? Center(
                      child: InkWell(
                        onTap: () {
                          getHouseList();
                        },
                        child: const CircularProgressIndicator(
                          color: Colors.black87,
                          strokeWidth: 3,
                        ),
                      ),
                    )
                  : house_list!.length > 0
                      ? Column(
                          children: [
                            const Categories(),
                            RecommendedHouse(
                              house_list: house_list!,
                            ),
                            BestOffer(
                              house_list: best_deal_houses!,
                            ),
                          ],
                        )
                      : Text('No data')
            ],
          ),
        ),
      ),
      // bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
