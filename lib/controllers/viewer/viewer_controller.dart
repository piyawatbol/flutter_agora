import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_token_service/agora_token_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_agora_app/controllers/scroll/scroll_controller.dart';
import 'package:flutter_agora_app/models/chat/chat_model.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../configs/appId.dart';
import '../../configs/ipcon.dart';
import '../../models/users/userData.dart';

class ViewerController extends GetxController {
  bool enableCamera = true;
  int? remoteUserid;
  late RtcEngine engine;
  late IO.Socket socket;
  TextEditingController messageController = TextEditingController();
  late ScrollController scrollController;

  List<ChatModel> messages = [];
  ChatController chatController = Get.put(ChatController());

  @override
  void onInit() {
    initSocket();
    super.onInit();
  }

  Future<void> initAgora(String channelName) async {
    engine = createAgoraRtcEngine();
    await engine.initialize(const RtcEngineContext(
      appId: appId,
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
    ));
    engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          debugPrint("local user ${connection.localUid} joined");
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          debugPrint("remote user $remoteUid joined");
          remoteUserid = remoteUid;
          update();
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          debugPrint("remote user $remoteUid left channel");
          remoteUserid = null;
          update();
        },
      ),
    );

    await engine.setClientRole(role: ClientRoleType.clientRoleAudience);
    await engine.enableVideo();
    await engine.startPreview();

    final uid = '${UserData.user!.uid.toString()}';
    final role = RtcRole.subscriber;

    final expirationInSeconds = 3600;
    final currentTimestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    final expireTimestamp = currentTimestamp + expirationInSeconds;

    final token = RtcTokenBuilder.build(
      appId: appId,
      appCertificate: appCertificate,
      channelName: channelName,
      uid: uid,
      role: role,
      expireTimestamp: expireTimestamp,
    );

    await engine.joinChannel(
      token: token,
      channelId: channelName,
      uid: int.parse(UserData.user!.uid.toString()),
      options: const ChannelMediaOptions(),
    );
  }

  Future<void> OnDispose() async {
    await engine.leaveChannel();
    await engine.release();
  }

  initSocket() {
    socket = IO.io('$ipcon', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    });

    socket.connect();

    socket.onConnect((_) {
      print('Connected');
    });

    socket.on('message_from_server', (data) {
      messages.add(ChatModel.fromJson(data));

      chatController.scrollToBottom();
      update();
    });

    socket.onDisconnect((_) => print('Disconnected'));
  }

  void sendMessage() {
    Map<String, dynamic> message = {
      "user_name": "${UserData.user!.firstName} ${UserData.user!.lastName}",
      "user_img": "${UserData.user!.userImg}",
      "message": messageController.text,
    };

    if (message.isNotEmpty) {
      socket.emit('message_from_flutter', message);
      messageController.clear();
    }
  }

  @override
  void onClose() {
    socket.disconnect();
    super.onClose();
  }
}
