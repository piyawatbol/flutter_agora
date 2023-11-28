// import 'package:flutter/material.dart';
// import 'package:flutter_agora_app/controllers/profile/profile_controller.dart';
// import 'package:get/get.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;

// import 'models/users/userData.dart';

// class SocketIoExample extends StatefulWidget {
//   @override
//   _SocketIoExampleState createState() => _SocketIoExampleState();
// }

// class _SocketIoExampleState extends State<SocketIoExample> {
//   late IO.Socket socket;
//   TextEditingController _messageController = TextEditingController();
//   List<String> messages = []; // เก็บข้อความที่ได้รับ

//   @override
//   void initState() {
//     super.initState();
//     Get.put(ProfileController());

//   }

//   @override
//   void dispose() {
//     socket.disconnect();
//     super.dispose();
//   }

  

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         FocusScope.of(context).requestFocus(FocusNode());
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('Socket.IO Example'),
//         ),
//         body: Padding(
//           padding: EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: <Widget>[
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: messages.length,
//                   itemBuilder: (context, index) {
//                     return ListTile(
//                       title: Text(messages[index]),
//                     );
//                   },
//                 ),
//               ),
//               TextField(
//                 controller: _messageController,
//                 decoration: InputDecoration(
//                   hintText: 'Enter your message',
//                 ),
//               ),
//               SizedBox(height: 16.0),
//               ElevatedButton(
//                 onPressed: sendMessage,
//                 child: Text('Send'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
