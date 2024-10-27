import 'package:flutter/material.dart';

class AppStyles {
  // Text Styles
  static  TextStyle headerText = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w500,
    color: Colors.blue[800],
  );

  static const TextStyle bodyText = TextStyle(
    fontSize: 16,
    color: Colors.black87,
  );

  // Button Styles
  static final ButtonStyle primaryButton = ElevatedButton.styleFrom(
    backgroundColor: Colors.blue,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    textStyle: const TextStyle(fontSize: 18),
  );

  static  TextStyle todoTitle =  TextStyle(
    fontSize: 19,
    fontWeight: FontWeight.w400,
    color: Colors.blue[900],

  );

  static const TextStyle subTitle =  TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: Colors.black54,
  );

  static final ButtonStyle secondaryButton = ElevatedButton.styleFrom(
    backgroundColor: Colors.grey,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    textStyle: const TextStyle(fontSize: 16),
  );
}
