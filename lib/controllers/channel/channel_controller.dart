import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_agora_app/models/users/userData.dart';
import 'package:flutter_agora_app/screens/broadcaster/live_screen.dart';
import 'package:flutter_agora_app/widgets/log_custom/log_custom.dart';
import 'package:flutter_agora_app/widgets/toast/toast_custom.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:image_picker/image_picker.dart';
import '../../models/channel/channel_model.dart';
import '../../services/apis/live/live_api.dart';

class ChannelController extends GetxController {
  TextEditingController channelName = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  XFile? pickedFile;
  bool statusLoading = false;
  List<ChannelModel> channelList = [];
  ChannelModel? channel;

  @override
  void onInit() {
    getChannel();
    super.onInit();
  }

  pickImage() async {
    pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    update();
  }

  addChannel() async {
    if (pickedFile == null) {
      ToastCustom("กรุณาเลือกรูป", Colors.red);
    } else if (channelName.text == "") {
      ToastCustom("กรุณากรอกชื่อ", Colors.red);
    } else {
      statusLoading = true;
      update();
      var image = await MultipartFile.fromFile(pickedFile!.path);
      final formData = FormData.fromMap(
        {'image': image, "channel_name": "${channelName.text}"},
      );
      final response = await LiveApi.addLive(formData);
      LogShow.showLog(response);
      if (response["message"] == "Success") {
        channel = ChannelModel.fromJson(response['data']);
        LogShow.showLog(channel);
        statusLoading = false;
        update();
        Get.off(
          () => LiveScreen(
            uid: int.parse(UserData.user!.uid.toString()),
            channel: channelName.text,
          ),
        );
      } else {
        statusLoading = false;
        update();
      }
    }
  }

  Future deleteChannel() async {
    Map<String, dynamic> body = {"id": "${channel!.sId}"};
    LogShow.showLog('delete');
    final response = await LiveApi.deleteLive(body);
    if (response['message'] == "Success") {
      LogShow.showLog(response);
      Get.back();
    }
  }

  Future<void> getChannel() async {
    final response = await LiveApi.getLive();
    if (response['message'] == "Success") {
      channelList.clear();
      channelList.addAll(response['data']['data']
          .map<ChannelModel>((values) => ChannelModel.fromJson(values)));
      update();
    }
  }
}
