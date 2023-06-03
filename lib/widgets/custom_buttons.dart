import 'package:flutter/material.dart';
import 'package:house_rent/utils/size_config.dart';

class LoadButton extends StatelessWidget {
  const LoadButton({
    Key? key,
    required this.isLoading,
    required this.text,
    this.press,
  }) : super(key: key);
  final bool isLoading;
  final String text;
  final Function? press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: getProportionateScreenHeight(56),
      child: ElevatedButton(
        onPressed: isLoading ? () {} : press as void Function()?,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        child: isLoading
            ? const CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 3,
              )
            : Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
      ),
    );
  }
}
