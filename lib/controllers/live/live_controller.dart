import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_token_service/agora_token_service.dart';
import 'package:agora_uikit/agora_uikit.dart';
import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_agora_app/controllers/scroll/scroll_controller.dart';
import 'package:flutter_agora_app/models/chat/chat_model.dart';
import 'package:flutter_agora_app/widgets/log_custom/log_custom.dart';
import 'package:flutter_agora_app/widgets/toast/toast_custom.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:image_picker/image_picker.dart';
import '../../configs/appId.dart';
import '../../configs/ipcon.dart';
import '../../models/channel/channel_model.dart';
import '../../models/users/userData.dart';
import '../../screens/broadcaster/live_screen.dart';
import '../../services/apis/live/live_api.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class LiveController extends GetxController {
  TextEditingController channelName = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  XFile? pickedFile;
  bool statusLoading = false;
  List<ChannelModel> channelList = [];
  ChannelModel? channel;
  bool enableCamera = true;
  int? remoteUid;
  bool localUserJoined = false;
  late RtcEngine engine;
  late List<CameraDescription> cameras;
  late CameraController cameraController;
  int count = 3;
  int direction = 1;
  bool start = false;
  late IO.Socket socket;
  List<ChatModel> messages = [];
  ChatController chatController = Get.put(ChatController());

  @override
  void onInit() {
    getChannel();
    initSocket();
    super.onInit();
  }

  pickImage() async {
    statusLoading = true;
    update();
    pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    statusLoading = false;
    update();
  }

  Future<void> initAgora() async {
    await [Permission.microphone, Permission.camera].request();

    //create the engine
    engine = createAgoraRtcEngine();
    await engine.initialize(const RtcEngineContext(
      appId: appId,
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
    ));

    engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          debugPrint("local user ${connection.localUid} joined");
          localUserJoined = true;
          update();
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          debugPrint("remote user $remoteUid joined");
          remoteUid = remoteUid;
          update();
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          debugPrint("remote user $remoteUid left channel");
          update();
        },
        onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
          debugPrint(
              '[onTokenPrivilegeWillExpire] connection: ${connection.toJson()}, token: $token');
        },
      ),
    );

    await engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await engine.enableVideo();
    await engine.startPreview();

    final uid = '${UserData.user!.uid}';
    final role = RtcRole.publisher;

    final expirationInSeconds = 3600;
    final currentTimestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    final expireTimestamp = currentTimestamp + expirationInSeconds;

    final token = RtcTokenBuilder.build(
      appId: appId,
      appCertificate: appCertificate,
      channelName: channelName.text,
      uid: uid,
      role: role,
      expireTimestamp: expireTimestamp,
    );

    await engine.joinChannel(
      token: token,
      channelId: channelName.text,
      uid: int.parse(UserData.user!.uid.toString()),
      options: const ChannelMediaOptions(),
    );
  }

  Future<void> OnDispose() async {
    await engine.leaveChannel();
    await engine.release();
    deleteChannel();
  }

  final AgoraClient client = AgoraClient(
    agoraConnectionData: AgoraConnectionData(
      appId: "$appId",
      channelName: "test",
    ),
  );

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

      if (response["message"] == "Success") {
        channel = ChannelModel.fromJson(response['data']);
        statusLoading = false;
        update();
        Get.off(() => LiveScreen(
            uid: int.parse(
              UserData.user!.uid.toString(),
            ),
            channel: channelName.text));
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
    if (response['message'] == 'Success') {
      Get.back();
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

  startLive() async {
    start = true;
    update();
    while (count > 0) {
      await Future.delayed(Duration(seconds: 1));

      count = count - 1;
      update();
    }
    Get.off(
      () => LiveScreen(
          uid: int.parse(
            UserData.user!.uid.toString(),
          ),
          channel: channelName.text),
    );
    start = false;
    count = 3;
    update();
  }

  void startCamera(int direction) async {
    cameras = await availableCameras();
    cameraController =
        CameraController(cameras[direction], ResolutionPreset.max);
    cameraController.initialize().then((value) {
      update();
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            break;
          default:
            break;
        }
      }
    });
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
}
