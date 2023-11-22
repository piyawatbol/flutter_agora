import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_agora_app/controllers/live/live_controller.dart';
import 'package:get/get.dart';

Future<void> showPopup(BuildContext context) async {
  LiveController channelController = Get.put(LiveController());
  if (Platform.isIOS) {
    return showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('Cancel Live'),
          content: Text('Do you want to cancel Live?'),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text('OK'),
              onPressed: () {
                channelController.deleteChannel();
              },
            ),
            CupertinoDialogAction(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  } else {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Cancel Live'),
          content: Text('Do you want to cancel Live?'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {},
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
