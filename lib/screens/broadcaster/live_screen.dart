import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_token_service/agora_token_service.dart';
import 'package:agora_uikit/agora_uikit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_agora_app/configs/appId.dart';

class LiveScreen extends StatefulWidget {
  final int uid;
  final String channel;
  const LiveScreen({required this.uid, required this.channel});

  @override
  State<LiveScreen> createState() => _LiveScreenState();
}

class _LiveScreenState extends State<LiveScreen> {
  bool enableCamera = true;
  int? remoteUid;
  bool _localUserJoined = false;
  int visitors = 0;
  late RtcEngine _engine;

  @override
  void initState() {
    super.initState();
    initAgora();
  }

  Future<void> initAgora() async {
    await [Permission.microphone, Permission.camera].request();

    //create the engine
    _engine = createAgoraRtcEngine();
    await _engine.initialize(const RtcEngineContext(
      appId: appId,
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
    ));

    _engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          debugPrint("local user ${connection.localUid} joined");
          setState(() {
            _localUserJoined = true;
          });
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          debugPrint("remote user $remoteUid joined");
          setState(() {
            remoteUid = remoteUid;
            visitors = visitors + 1;
          });
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          debugPrint("remote user $remoteUid left channel");
        },
        onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
          debugPrint(
              '[onTokenPrivilegeWillExpire] connection: ${connection.toJson()}, token: $token');
        },
      ),
    );

    await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await _engine.enableVideo();
    await _engine.startPreview();

    final uid = '${widget.uid}';
    final role = RtcRole.publisher;

    final expirationInSeconds = 3600;
    final currentTimestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    final expireTimestamp = currentTimestamp + expirationInSeconds;

    final token = RtcTokenBuilder.build(
      appId: appId,
      appCertificate: appCertificate,
      channelName: widget.channel,
      uid: uid,
      role: role,
      expireTimestamp: expireTimestamp,
    );

    await _engine.joinChannel(
      token: token,
      channelId: widget.channel,
      uid: widget.uid,
      options: const ChannelMediaOptions(),
    );
  }

  final AgoraClient client = AgoraClient(
    agoraConnectionData: AgoraConnectionData(
      appId: "$appId",
      channelName: "test",
    ),
  );

  @override
  void dispose() {
    super.dispose();
    _dispose();
  }

  Future<void> _dispose() async {
    await _engine.leaveChannel();
    await _engine.release();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agora Video Call'),
      ),
      body: Stack(
        children: [
          // Center(
          //   child: _remoteVideo(),
          // ),
          Container(
            child: Center(
              child: _localUserJoined
                  ? AgoraVideoView(
                      controller: VideoViewController(
                        rtcEngine: _engine,
                        canvas: VideoCanvas(uid: 0),
                      ),
                    )
                  : const CircularProgressIndicator(),
            ),
          ),
          AgoraVideoButtons(
            client: client,
            // disableVideoButtonChild: ElevatedButton(
            //   onPressed: () {
            //     // ควบคุมการเปิด/ปิดกล้องของผู้ถ่ายภาพ
            //     if (enableCamera == true) {
            //       _engine.enableLocalVideo(false);
            //       _engine.muteLocalVideoStream(true);
            //       setState(() {
            //         enableCamera = false;
            //       });
            //     } else {
            //       _engine.enableLocalVideo(true);
            //       _engine.muteLocalVideoStream(false);
            //       setState(() {
            //         enableCamera = true;
            //       });
            //     }
            //   },
            // ),
          ),
          // Positioned(
          //   right: 10,
          //   top: 10,
          //   child: Text(
          //     "${visitors}",
          //   ),
          // ),
        ],
      ),
    );
  }

  // Widget _remoteVideo() {
  //   if (_remoteUid != null) {
  //     return AgoraVideoView(
  //       controller: VideoViewController.remote(
  //         rtcEngine: _engine,
  //         canvas: VideoCanvas(uid: _remoteUid),
  //         connection: const RtcConnection(channelId: channel),
  //       ),
  //     );
  //   } else {
  //     return const Text(
  //       'Please wait for remote user to join',
  //       textAlign: TextAlign.center,
  //     );
  //   }
  // }
}
