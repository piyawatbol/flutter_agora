import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

ToastCustom(String? text, Color? color) {
  Fluttertoast.showToast(
    msg: "$text",
    // toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 1,
    backgroundColor: color,
    textColor: Colors.white,
    fontSize: 14,
  );
}
