import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_token_service/agora_token_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../configs/appId.dart';
import '../../models/users/userData.dart';

class ViewerController extends GetxController {
  bool enableCamera = true;
  int? remoteUserid;
  late RtcEngine engine;
  TextEditingController text = TextEditingController();

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
}
