import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/profile/profile_controller.dart';
import '../../widgets/button/button_custom.dart';
import '../../widgets/colors/color.dart';
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
        drawer: SafeArea(
          bottom: false,
          child: DrawerHome(),
        ),
        appBar: AppBar(
          title: const Text('Agora Video Call'),
          backgroundColor: primaryColor,
        ),
        body: Container(
          width: size.width,
          height: size.height,
          child: Column(
            children: [
              Container(
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
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(left: 20, right: 5, bottom: 15),
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
                                onTap: () {},
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
                                "Live now",
                                color: Colors.white,
                              ),
                              SizedBox(width: 10),
                              CircleAvatar(
                                radius: 5,
                                backgroundColor: Colors.red,
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),

              // AutoText("channal"),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 30),
              //   child: TextField(
              //     controller: channal,
              //     decoration: InputDecoration(
              //       contentPadding: EdgeInsets.only(left: 14),
              //       border: OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(10.0),
              //       ),
              //     ),
              //   ),
              // ),
              // ElevatedButton(
              //   onPressed: () {
              //     Navigator.push(context,
              //         MaterialPageRoute(builder: (BuildContext context) {
              //       return LiveScreen(
              //         uid: UserData.user!.uid!,
              //         channel: channal.text,
              //       );
              //     }));
              //   },
              //   child: Text('live'),
              // ),
              // ElevatedButton(
              //   onPressed: () {
              //     Navigator.push(context,
              //         MaterialPageRoute(builder: (BuildContext context) {
              //       return ViewerScreen(
              //         uid: UserData.user!.uid!,
              //         channel: channal.text,
              //       );
              //     }));
              //   },
              //   child: Text('view live'),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
