import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter_agora_app/controllers/viewer/viewer_controller.dart';
import 'package:flutter_agora_app/widgets/chat/chat_box.dart';
import 'package:flutter_agora_app/widgets/text/auto_text.dart';
import 'package:get/get.dart';

class ViewerScreen extends StatefulWidget {
  final int uid;
  final String channel;
  const ViewerScreen({required this.uid, required this.channel});

  @override
  _ViewerScreenState createState() => _ViewerScreenState();
}

class _ViewerScreenState extends State<ViewerScreen> {
  ViewerController viewerController = Get.put(ViewerController());

  @override
  void initState() {
    super.initState();
    viewerController.initAgora(widget.channel);
  }

  @override
  void dispose() {
    super.dispose();
    viewerController.OnDispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: Container(
          width: size.width,
          height: size.height,
          child: GetBuilder<ViewerController>(
            init: ViewerController(),
            builder: (controller) {
              return Stack(
                children: [
                  if (controller.remoteUserid != null) ...{
                    AutoText("${controller.remoteUserid}"),
                    AgoraVideoView(
                      controller: VideoViewController.remote(
                        rtcEngine: controller.engine,
                        canvas: VideoCanvas(uid: controller.remoteUserid),
                        connection: RtcConnection(channelId: widget.channel),
                      ),
                    )
                  } else ...{
                    Center(
                      child: AutoText(
                        'No live stream available',
                        textAlign: TextAlign.center,
                      ),
                    )
                  },
                  ChatBox(
                    messages: controller.messages,
                  ),
                  buildTextfeild(controller),
                  buildAppBar()
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget buildTextfeild(ViewerController controller) {
    return Positioned(
      bottom: 25,
      right: 0,
      left: 0,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: TextField(
          controller: controller.messageController,
          // cursorHeight: 15,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 20),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: Colors.grey.shade400,
                width: 2,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: Colors.grey.shade500,
                width: 2,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: Colors.grey.shade400,
                width: 2,
              ),
            ),
            hintText: 'Enten Comment',
            hintStyle: TextStyle(fontSize: 14),
            suffixIcon: IconButton(
              onPressed: () {
                controller.sendMessage();
              },
              icon: Icon(Icons.send),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildAppBar() {
    return SafeArea(
        child: GestureDetector(
      onTap: () {
        Get.back();
      },
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 30,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  children: [
                    AutoText("Live"),
                    SizedBox(width: 8),
                    CircleAvatar(
                      radius: 5,
                      backgroundColor: Colors.red,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
