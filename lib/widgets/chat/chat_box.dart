import 'package:flutter/material.dart';
import 'package:flutter_agora_app/configs/ipcon.dart';
import 'package:flutter_agora_app/controllers/scroll/scroll_controller.dart';
import 'package:flutter_agora_app/models/chat/chat_model.dart';
import 'package:get/get.dart';
import '../../services/convert_time/convert_time.dart';
import '../text/auto_text.dart';

class ChatBox extends StatelessWidget {
  final List<ChatModel> messages;

  ChatBox({required this.messages});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Positioned(
        bottom: size.height * 0.09,
        child: GetBuilder<ChatController>(
          init: ChatController(),
          builder: (controller) {
            return Container(
                padding: EdgeInsets.all(10),
                height: controller.checkHeight(context, messages.length),
                width: size.width,
                child: ListView.builder(
                  controller: controller.scrollController,
                  padding: EdgeInsets.all(0),
                  itemCount: messages.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            blurRadius: 4,
                            spreadRadius: 0.5,
                            offset: Offset(1, 0),
                          )
                        ],
                      ),
                      child: ListTile(
                        leading: messages[index].userImg != ""
                            ? CircleAvatar(
                                radius: 22,
                                backgroundImage: NetworkImage(
                                    "${ipcon}/images/${messages[index].userImg}"),
                              )
                            : CircleAvatar(
                                radius: 22,
                              ),
                        title: AutoText("${messages[index].userName}",
                            fontSize: 14),
                        subtitle: AutoText(
                          "${messages[index].message}",
                          fontSize: 14,
                        ),
                        trailing: AutoText(
                          convertTime('${messages[index].time}'),
                          fontSize: 14,
                        ),
                      ),
                    );
                  },
                ));
          },
        ));
  }
}
