import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_uikit/agora_uikit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_agora_app/controllers/live/live_controller.dart';
import 'package:get/get.dart';

class LiveScreen extends StatefulWidget {
  final int uid;
  final String channel;
  const LiveScreen({required this.uid, required this.channel});

  @override
  State<LiveScreen> createState() => _LiveScreenState();
}

class _LiveScreenState extends State<LiveScreen> {
  LiveController liveController = Get.put(LiveController());
  @override
  void initState() {
    liveController.initAgora();
    super.initState();
  }

  @override
  void dispose() {
    liveController.OnDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<LiveController>(
      init: LiveController(),
      builder: (controller) {
        return Stack(
          children: [
            Container(
              child: Center(
                child: controller.localUserJoined
                    ? AgoraVideoView(
                        controller: VideoViewController(
                          rtcEngine: controller.engine,
                          canvas: VideoCanvas(uid: 0),
                        ),
                      )
                    : const CircularProgressIndicator(),
              ),
            ),
            AgoraVideoButtons(
              client: controller.client,
            ),
          ],
        );
      },
    ));
  }
}
