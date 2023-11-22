import 'package:flutter/material.dart';
import 'package:flutter_agora_app/configs/ipcon.dart';
import 'package:flutter_agora_app/controllers/live/live_controller.dart';
import 'package:flutter_agora_app/models/users/userData.dart';
import 'package:flutter_agora_app/screens/viewer/viewer_screen.dart';
import 'package:get/get.dart';
import '../../controllers/profile/profile_controller.dart';
import '../../models/channel/channel_model.dart';
import '../../widgets/button/button_custom.dart';
import '../../widgets/drawer/drawer_home.dart';
import '../../widgets/text/auto_text.dart';

class HomeViewerScreen extends StatelessWidget {
  HomeViewerScreen({super.key});
  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          drawer: SafeArea(
            bottom: false,
            child: DrawerHome(),
          ),
          appBar: AppBar(
            title: AutoText("Live"),
            backgroundColor: Colors.white,
          ),
          body: GetBuilder<LiveController>(
            init: LiveController(),
            builder: (controller) {
              return RefreshIndicator(
                onRefresh: () {
                  return controller.getChannel();
                },
                child: Container(
                  width: size.width,
                  height: size.height,
                  child: ListView(
                    children: [
                      buildChannel(size, controller),
                    ],
                  ),
                ),
              );
            },
          )),
    );
  }

  Widget buildChannel(Size size, LiveController controller) {
    return SizedBox(
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: controller.channelList.length,
        itemBuilder: (BuildContext context, int index) {
          ChannelModel channel = controller.channelList[index];
          return Container(
            margin: EdgeInsets.all(10),
            width: size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(0, 0),
                  spreadRadius: 5,
                  blurRadius: 5,
                )
              ],
            ),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.all(15),
                      height: size.height * 0.3,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  "$ipcon/image/live_channel/${channel.imgLive}"))),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20, right: 5, bottom: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AutoText(
                                "Live Start : 16.00 ",
                                fontSize: 16,
                              ),
                              AutoText(
                                "Live Close : 20.00 ",
                                fontSize: 16,
                              ),
                            ],
                          ),
                          ButtonCustom(
                            "เข้าร่วม",
                            onTap: () {
                              Get.to(
                                () => ViewerScreen(
                                  uid: int.parse(UserData.user!.uid.toString()),
                                  channel: channel.channelName!,
                                ),
                              );
                            },
                            width: size.width * 0.3,
                            height: 50,
                            borderRadius: 5,
                            padding: EdgeInsets.only(right: 10),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Positioned(
                  top: 50,
                  right: 0,
                  child: Container(
                    width: 120,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AutoText(
                            channel.liveStatus == true
                                ? "Live now"
                                : "Not live",
                            color: Colors.white,
                          ),
                          SizedBox(width: 10),
                          CircleAvatar(
                            radius: 5,
                            backgroundColor: channel.liveStatus == true
                                ? Colors.green
                                : Colors.red,
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
