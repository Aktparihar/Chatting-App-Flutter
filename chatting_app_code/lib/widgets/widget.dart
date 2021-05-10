import 'package:flutter/material.dart';

Widget AppBarMain(BuildContext context) {
  return AppBar(
    centerTitle: true,
    title: Image.asset(
      "assets/images/logo.png",
      height: 60,
    ),
  );
}

InputDecoration textInputFieldDecoration(String hintText) {
  return InputDecoration(
    hintText: hintText,
    hintStyle: TextStyle(
      color: Colors.white54,
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Colors.white54,
      ),
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Colors.white54,
      ),
    ),
  );
}

TextStyle textStyle() {
  return TextStyle(
    color: Colors.white,
    fontSize: 16,
  );
}

TextStyle mediumTextStyle() {
  return TextStyle(
    color: Colors.white,
    fontSize: 16,
  );
}
