class UserModel {
  String? uid;
  String? firstName;
  String? lastName;
  String? phone;
  String? email;
  String? password;
  String? userImg;
  String? loginType;
  String? role;
  String? sId;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? token;

  UserModel(
      {this.uid,
      this.firstName,
      this.lastName,
      this.phone,
      this.email,
      this.password,
      this.userImg,
      this.loginType,
      this.role,
      this.sId,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.token});

  UserModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phone = json['phone'];
    email = json['email'];
    password = json['password'];
    userImg = json['user_img'];
    loginType = json['login_type'];
    role = json['role'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['password'] = this.password;
    data['user_img'] = this.userImg;
    data['login_type'] = this.loginType;
    data['role'] = this.role;
    data['_id'] = this.sId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['token'] = this.token;
    return data;
  }
}
