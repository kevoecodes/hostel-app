import 'package:flutter/material.dart';
import 'package:house_rent/screens/home/home.dart';
import 'package:house_rent/utils/size_config.dart';
import 'package:house_rent/widgets/custom_buttons.dart';

class SuccessfullBooked extends StatefulWidget {
  const SuccessfullBooked({Key? key}) : super(key: key);

  @override
  State<SuccessfullBooked> createState() => _SuccessfullBookedState();
}

class _SuccessfullBookedState extends State<SuccessfullBooked> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: SizeConfig.screenHeight * 0.09),
          Image.asset(
            "assets/images/success.gif",
            height: SizeConfig.screenHeight * 0.4, //40%
            width: SizeConfig.screenWidth,
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.08),
          Text(
            'Booked sucessfully',
            style: TextStyle(
              fontSize: getProportionateScreenWidth(30),
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.2),
          SizedBox(
            width: SizeConfig.screenWidth * 0.9,
            child: LoadButton(
              isLoading: false,
              text: 'See more',
              press: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Home()));
              },
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
