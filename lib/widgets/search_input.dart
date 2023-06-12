import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:house_rent/screens/bookmarks/booked.dart';
import 'package:house_rent/screens/search/search.dart';

class SearchInput extends StatefulWidget {
  var userData;
  SearchInput({Key? key, required this.userData}) : super(key: key);

  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SearchPage(
                    userData: widget.userData,
                  )),
        );
        unFocus();
      }
    });
  }

  unFocus() {
    _focusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: TextField(
        focusNode: _focusNode,
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
    );
  }
}
