import 'package:code_zero/network/convert_interface.dart';

class MessageModel extends ConvertInterface{
  int? totalCount;
  List<MessageItems>? items;

  MessageModel({this.totalCount, this.items});

  MessageModel.fromJson(Map<String, dynamic> json) {
    totalCount = json['totalCount'];
    if (json['items'] != null) {
      items = <MessageItems>[];
      json['items'].forEach((v) {
        items!.add(new MessageItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalCount'] = this.totalCount;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  ConvertInterface fromJson(Map<String, dynamic> json) {
    return MessageModel.fromJson(json);
  }
}

class MessageItems {
  int? id;
  String? msgTitle;
  int? msgType;
  int? status;
  String? msgContent;
  int? userId;
  String? coverImageUrl;
  String? createdAt;
  String? updatedAt;

  MessageItems(
      {this.id,
        this.msgTitle,
        this.msgType,
        this.status,
        this.msgContent,
        this.userId,
        this.coverImageUrl,
        this.createdAt,
        this.updatedAt});

  MessageItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    msgTitle = json['msgTitle'];
    msgType = json['msgType'];
    status = json['status'];
    msgContent = json['msgContent'];
    userId = json['userId'];
    coverImageUrl = json['coverImageUrl'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['msgTitle'] = this.msgTitle;
    data['msgType'] = this.msgType;
    data['status'] = this.status;
    data['msgContent'] = this.msgContent;
    data['userId'] = this.userId;
    data['coverImageUrl'] = this.coverImageUrl;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
