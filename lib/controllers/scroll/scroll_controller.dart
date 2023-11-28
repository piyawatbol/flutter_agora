import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_agora_app/models/chat/chat_model.dart';

class ChatController extends GetxController {
  var messages = <ChatModel>[].obs;
  late ScrollController scrollController;

  @override
  void onInit() {
    scrollController = ScrollController();
    super.onInit();
  }

  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
    update();
  }

  double checkHeight(context, int lenght) {
    var size = MediaQuery.of(context).size;
    if (lenght == 1) {
      return size.height * 0.11;
    } else if (lenght == 2) {
      return size.height * 0.2;
    } else if (lenght == 3) {
      return size.height * 0.29;
    } else if (lenght > 3) {
      return size.height * 0.38;
    }

    return 0;
  }
}
