import 'package:flutter/material.dart';

// ignore: must_be_immutable
class WelcomeText extends StatefulWidget {
  final userData;
  WelcomeText({Key? key, required this.userData}) : super(key: key);

  @override
  State<WelcomeText> createState() => _WelcomeTextState();
}

class _WelcomeTextState extends State<WelcomeText> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hello ${widget.userData != null ? widget.userData['full_name'] : ''}',
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 10),
          Text(
            'Find an affordable hostel now!',
            style: Theme.of(context).textTheme.headline1!.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }
}
