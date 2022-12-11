import 'package:code_zero/network/convert_interface.dart';

class RedEnvelopeReward extends ConvertInterface{
  List<Items>? items;
  int? totalCount;

  RedEnvelopeReward({this.items, this.totalCount});

  RedEnvelopeReward.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
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
    return RedEnvelopeReward.fromJson(json);
  }
}

class Items {
  String? nickname;
  String? avatarUrl;
  String? createdAt;
  String? amount;
  int? redEnvelopeType;
  int? isCompleted;
  int? completedOrderNum;

  Items(
      {this.nickname,
        this.avatarUrl,
        this.createdAt,
        this.amount,
        this.redEnvelopeType,
        this.isCompleted,
        this.completedOrderNum});

  Items.fromJson(Map<String, dynamic> json) {
    nickname = json['nickname'];
    avatarUrl = json['avatarUrl'];
    createdAt = json['createdAt'];
    amount = json['amount'];
    redEnvelopeType = json['redEnvelopeType'];
    isCompleted = json['isCompleted'];
    completedOrderNum = json['completedOrderNum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nickname'] = this.nickname;
    data['avatarUrl'] = this.avatarUrl;
    data['createdAt'] = this.createdAt;
    data['amount'] = this.amount;
    data['redEnvelopeType'] = this.redEnvelopeType;
    data['isCompleted'] = this.isCompleted;
    data['completedOrderNum'] = this.completedOrderNum;
    return data;
  }
}
