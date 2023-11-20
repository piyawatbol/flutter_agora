import 'package:flutter/material.dart';
import 'package:flutter_agora_app/configs/ipcon.dart';
import 'package:flutter_agora_app/controllers/channel/channel_controller.dart';
import 'package:flutter_agora_app/controllers/profile/profile_controller.dart';
import 'package:flutter_agora_app/models/channel/channel_model.dart';
import 'package:flutter_agora_app/models/users/userData.dart';
import 'package:flutter_agora_app/routes/routes.dart';
import 'package:flutter_agora_app/screens/broadcaster/live_screen.dart';
import 'package:flutter_agora_app/widgets/text/auto_text.dart';
import 'package:get/get.dart';

import '../../widgets/drawer/drawer_home.dart';

class BroadcaterScreen extends StatelessWidget {
  BroadcaterScreen({super.key});

  final ProfileController profileController = Get.put(ProfileController());
  final ChannelController channelController = Get.put(ChannelController());

  @override
  Widget build(BuildContext context) {
    // var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xfff9f9f9),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Color(0xfff9f9f9),
        elevation: 0,
        title: AutoText("Live"),
        actions: [
          IconButton(
              onPressed: () {
                Get.toNamed(AppRoutes.add_live);
              },
              icon: Icon(Icons.add))
        ],
      ),
      drawer: DrawerHome(),
      // body: GetBuilder<ChannelController>(
      //   init: ChannelController(),
      //   builder: (controller) {
      //     return RefreshIndicator(
      //       color: primaryColor,
      //       onRefresh: () {
      //         return controller.getchannel();
      //       },
      //       child: buildChannel(size, controller),
      //     );
      //   },
      // ),
    );
  }

  Widget buildChannel(Size size, ChannelController controller) {
    return Container(
      width: size.width,
      height: size.height,
      child: ListView.builder(
        itemCount: controller.channelList.length,
        itemBuilder: (BuildContext context, int index) {
          ChannelModel channel = controller.channelList[index];
          return GestureDetector(
            onTap: () {
              Get.to(() => LiveScreen(
                  uid: int.parse(UserData.user!.uid.toString()),
                  channel: "${channel.channelName}"));
            },
            child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                padding: EdgeInsets.all(10),
                height: size.height * 0.35,
                width: size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      offset: Offset(2, 2),
                      spreadRadius: 1,
                      blurRadius: 5,
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                "$ipcon/image/live_channel/${channel.imgLive}"),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    AutoText(
                      "${channel.channelName}",
                      fontSize: 16,
                    )
                  ],
                )),
          );
        },
      ),
    );
  }
}
