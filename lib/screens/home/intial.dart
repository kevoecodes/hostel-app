import 'package:flutter/material.dart';
import 'package:house_rent/screens/home/home.dart';
import 'package:house_rent/utils/functions.dart';
import 'package:house_rent/utils/size_config.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({Key? key}) : super(key: key);

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _handleNavigate();
  }

  _handleNavigate() async {
    bool _is_logined = await checkLoginStatus(context);
    if (_is_logined) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Home()));
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return const Center(
        child: Center(
      child: CircularProgressIndicator(
        color: Colors.black87,
        strokeWidth: 3,
      ),
    ));
  }
}
