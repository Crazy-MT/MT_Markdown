import 'package:code_zero/network/convert_interface.dart';

class FansListModel extends ConvertInterface {
  List<FansItem>? items;
  int? totalCount;

  FansListModel({this.items, this.totalCount});

  FansListModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <FansItem>[];
      json['items'].forEach((v) {
        items!.add(new FansItem.fromJson(v));
      });
    }
    totalCount = json['totalCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    data['totalCount'] = this.totalCount;
    return data;
  }

  @override
  ConvertInterface fromJson(Map<String, dynamic> json) {
    return FansListModel.fromJson(json);
  }
}

class FansItem {
  int? id;
  String? avatarUrl;
  String? nickname;
  String? todayTransCount;
  int? fromUserId;
  String? fromUserNickname;
  int? isMember;
  String? points;
  String? income;
  String? balance;
  String? phone;
  String? createdAt;
  String? buyAt;
  int? buyLimit;
  int? buySwitch;
  int? status;
  int? hasSignature;
  String? signatureUrl;

  FansItem(
      {this.id,
      this.avatarUrl,
      this.nickname,
      this.todayTransCount,
      this.fromUserId,
      this.fromUserNickname,
      this.isMember,
      this.points,
      this.income,
      this.balance,
      this.phone,
      this.createdAt,
      this.buyAt,
      this.buyLimit,
      this.buySwitch,
      this.status,
      this.hasSignature,
      this.signatureUrl});

  FansItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    avatarUrl = json['avatarUrl'];
    nickname = json['nickname'];
    todayTransCount = json['todayTransCount'];
    fromUserId = json['fromUserId'];
    fromUserNickname = json['fromUserNickname'];
    isMember = json['isMember'];
    points = json['points'];
    income = json['income'];
    balance = json['balance'];
    phone = json['phone'];
    createdAt = json['createdAt'];
    buyAt = json['buyAt'];
    buyLimit = json['buyLimit'];
    buySwitch = json['buySwitch'];
    status = json['status'];
    hasSignature = json['hasSignature'];
    signatureUrl = json['signatureUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['avatarUrl'] = this.avatarUrl;
    data['nickname'] = this.nickname;
    data['todayTransCount'] = this.todayTransCount;
    data['fromUserId'] = this.fromUserId;
    data['fromUserNickname'] = this.fromUserNickname;
    data['isMember'] = this.isMember;
    data['points'] = this.points;
    data['income'] = this.income;
    data['balance'] = this.balance;
    data['phone'] = this.phone;
    data['createdAt'] = this.createdAt;
    data['buyAt'] = this.buyAt;
    data['buyLimit'] = this.buyLimit;
    data['buySwitch'] = this.buySwitch;
    data['status'] = this.status;
    data['hasSignature'] = this.hasSignature;
    data['signatureUrl'] = this.signatureUrl;
    return data;
  }
}
