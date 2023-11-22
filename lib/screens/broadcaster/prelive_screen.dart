import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'package:flutter_agora_app/widgets/text/auto_text.dart';
import 'package:get/get.dart';

import '../../controllers/live/live_controller.dart';
import '../../widgets/dialog/showDialog.dart';

class PreLiveScreen extends StatefulWidget {
  final String channel_name;
  const PreLiveScreen({required this.channel_name});

  @override
  State<PreLiveScreen> createState() => _PreLiveScreenState();
}

class _PreLiveScreenState extends State<PreLiveScreen> {
  LiveController liveController = Get.put(LiveController());

  @override
  void initState() {
    liveController.startCamera(1);
    super.initState();
  }

  @override
  void dispose() {
    // liveController.cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    try {
      return Scaffold(
          body: GetBuilder<LiveController>(
        init: LiveController(),
        builder: (controller) {
          return Container(
            width: size.width,
            height: size.height,
            child: SafeArea(
              child: Stack(
                children: [
                  CameraPreview(controller.cameraController),
                  Positioned(
                    bottom: 35,
                    right: 0,
                    left: 0,
                    child: GestureDetector(
                      onTap: () {
                        controller.startLive();
                      },
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.grey.shade300,
                        child: CircleAvatar(
                          radius: 34,
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      right: 20,
                      top: 20,
                      child: GestureDetector(
                        onTap: () {
                          showPopup(context);
                        },
                        child: Icon(
                          Icons.close,
                          size: 40,
                          color: Colors.white,
                        ),
                      )),
                  if (controller.start) ...{
                    Stack(
                      children: [
                        Container(
                          height: size.height,
                          color: Colors.black.withOpacity(0.6),
                        ),
                        Align(
                          child: AutoText(
                            controller.count == 0
                                ? "start"
                                : "${controller.count}",
                            fontSize: 100,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    )
                  }
                ],
              ),
            ),
          );
        },
      ));
    } catch (e) {
      return Scaffold(
        body: Container(
          width: size.width,
          height: size.height,
        ),
      );
    }
  }
}
