import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_agora_app/controllers/live/live_controller.dart';
import 'package:flutter_agora_app/widgets/button/button_custom.dart';
import 'package:flutter_agora_app/widgets/loading/loading.dart';
import 'package:flutter_agora_app/widgets/textfeild/textfeild_custom.dart';
import 'package:get/get.dart';

class AddLiveScreen extends StatelessWidget {
  const AddLiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          width: size.width,
          height: size.height,
          child: GetBuilder<LiveController>(
            init: LiveController(),
            builder: (controller) {
              return Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        buildPickImg(controller, size),
                        TextFieldCustom(
                          controller: controller.channelName,
                          title: "ChannelName",
                          padding: EdgeInsets.only(top: 20, bottom: 5),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        SizedBox(height: size.height * 0.3),
                        ButtonCustom(
                          "Start Live",
                          onTap: () {
                            controller.addChannel();
                          },
                          width: size.width,
                          height: 50,
                          borderRadius: 5,
                        ),
                      ],
                    ),
                  ),
                  LoadingPage(statusLoading: controller.statusLoading)
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget buildPickImg(LiveController controller, Size size) {
    return GestureDetector(
                        onTap: () {
                          controller.pickImage();
                        },
                        child: Container(
                          width: size.width,
                          height: size.height * 0.3,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: Colors.black.withOpacity(0.5))),
                          child: controller.pickedFile != null
                              ? Image.file(
                                  File(controller.pickedFile!.path),
                                  fit: BoxFit.cover,
                                )
                              : Icon(
                                  Icons.photo,
                                  color: Colors.grey.shade400,
                                  size: 40,
                                ),
                        ),
                      );
  }
}
