class ChannelModel {
  String? sId;
  String? imgLive;
  String? channelName;
  bool? liveStatus;
  String? createdAt;
  String? updatedAt;
  int? iV;

  ChannelModel(
      {this.sId,
      this.imgLive,
      this.channelName,
      this.liveStatus,
      this.createdAt,
      this.updatedAt,
      this.iV});

  ChannelModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    imgLive = json['img_live'];
    channelName = json['channel_name'];
    liveStatus = json['live_status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['img_live'] = this.imgLive;
    data['channel_name'] = this.channelName;
    data['live_status'] = this.liveStatus;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
