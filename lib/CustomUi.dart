import 'package:flutter/material.dart';

void showInSnackBar(String value, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(value),
      duration: const Duration(milliseconds: 3000),
    ),
  );
}

double phoneHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double phoneWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}
