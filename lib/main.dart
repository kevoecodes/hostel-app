import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:house_rent/screens/auth/request_otp.dart';
import 'package:house_rent/screens/home/home.dart';

import 'package:house_rent/utils/size_config.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          backgroundColor: const Color(0xFFF5F6F6),
          primaryColor: const Color(0xFF811B83),
          colorScheme: ColorScheme.fromSwatch().copyWith(
            secondary: const Color(0xFFFA5019),
          ),
          textTheme: TextTheme(
            headline1: const TextStyle(
              color: Color(0xFF100E34),
            ),
            bodyText1: TextStyle(
              color: const Color(0xFF100E34).withOpacity(0.5),
            ),
          ),
          appBarTheme: AppBarTheme(
            color: Colors.white,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black),
            systemOverlayStyle: SystemUiOverlayStyle.dark,
            toolbarTextStyle: TextTheme(
              headline6: TextStyle(color: Color(0XFF8B8B8B), fontSize: 18),
            ).bodyText2,
            titleTextStyle: TextTheme(
              headline6: TextStyle(color: Color(0XFF8B8B8B), fontSize: 18),
            ).headline6,
          )),
      home: const Home(),
    );
  }
}
