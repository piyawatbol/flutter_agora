import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Status {
  static setStatus(Brightness? status) {
    if (Platform.isIOS) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarBrightness: status,
      ));
    } else if (Platform.isAndroid) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness:
            status == Brightness.dark ? Brightness.light : Brightness.dark,
      ));
    }
  }
}
