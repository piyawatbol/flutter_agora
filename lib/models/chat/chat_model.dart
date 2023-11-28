class ChatModel {
  String? userName;
  String? userImg;
  String? message;
  String? time;

  ChatModel({this.userName, this.userImg, this.message, this.time});

  ChatModel.fromJson(Map<String, dynamic> json) {
    userName = json['user_name'];
    userImg = json['user_img'];
    message = json['message'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_name'] = this.userName;
    data['user_img'] = this.userImg;
    data['message'] = this.message;
    data['time'] = this.time;
    return data;
  }
}
