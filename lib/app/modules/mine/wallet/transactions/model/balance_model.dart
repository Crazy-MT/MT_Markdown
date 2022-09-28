import 'package:code_zero/network/convert_interface.dart';
import 'package:code_zero/utils/log_utils.dart';
import 'package:flutter/cupertino.dart';

class BalanceModel extends ConvertInterface{
  List<BalanceItems>? items;
  int? totalCount;

  BalanceModel({this.items, this.totalCount});

  BalanceModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <BalanceItems>[];
      json['items'].forEach((v) {
        items!.add(new BalanceItems.fromJson(v));
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
    return BalanceModel.fromJson(json);
  }
}

class BalanceItems {
  int? id;
  String? flowNo;
  String? nickname;
  String? balance;
  String? userBalance;
  int? method;
  String? name;
  String? wechatAccount;
  String? phone;
  String? bankCardNum;
  String? bankAddress;
  String? bankName;
  String? bank;
  String? wechatPaymentCodeUrl;
  int? status;
  int? judgeStatus;
  int? paymentStatus;
  String? paymentAt;
  String? createdAt;
  String? updatedAt;
  int? userId;

  BalanceItems(
      {this.id,
      this.flowNo,
      this.nickname,
      this.balance,
      this.userBalance,
      this.method,
      this.name,
      this.wechatAccount,
      this.phone,
      this.bankCardNum,
      this.bankAddress,
      this.bankName,
      this.bank,
      this.wechatPaymentCodeUrl,
      this.status,
      this.judgeStatus,
      this.paymentStatus,
      this.paymentAt,
      this.createdAt,
      this.updatedAt,
      this.userId});

  BalanceItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    flowNo = json['flowNo'];
    nickname = json['nickname'];
    balance = json['balance'];
    userBalance = json['userBalance'];
    method = json['method'];
    name = json['name'];
    wechatAccount = json['wechatAccount'];
    phone = json['phone'];
    bankCardNum = json['bankCardNum'];
    bankAddress = json['bankAddress'];
    bankName = json['bankName'];
    bank = json['bank'];
    wechatPaymentCodeUrl = json['wechatPaymentCodeUrl'];
    status = json['status'];
    judgeStatus = json['judgeStatus'];
    paymentStatus = json['paymentStatus'];
    paymentAt = json['paymentAt'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['flowNo'] = this.flowNo;
    data['nickname'] = this.nickname;
    data['balance'] = this.balance;
    data['userBalance'] = this.userBalance;
    data['method'] = this.method;
    data['name'] = this.name;
    data['wechatAccount'] = this.wechatAccount;
    data['phone'] = this.phone;
    data['bankCardNum'] = this.bankCardNum;
    data['bankAddress'] = this.bankAddress;
    data['bankName'] = this.bankName;
    data['bank'] = this.bank;
    data['wechatPaymentCodeUrl'] = this.wechatPaymentCodeUrl;
    data['status'] = this.status;
    data['judgeStatus'] = this.judgeStatus;
    data['paymentStatus'] = this.paymentStatus;
    data['paymentAt'] = this.paymentAt;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['userId'] = this.userId;
    return data;
  }

  getStatus() {
    lLog('MTMTMT BalanceItems.getStatus ${status} ');
    Map s = {};
    switch(status) {
      case 0:
        s['text'] = '待审核';
        s['color'] = Color(0xFFD0A06D).value;
        break;
      case 1:
        s['text'] = '待打款';
        s['color'] = Color(0xFFFF3939).value;
        break;
      case 2:
        lLog('MTMTMT BalanceItems.getStatus } ');
        s['text'] = '已完成';
        s['color'] = Color(0xFF1BDB8A).value;
        break;
      case 3:
        s['text'] = '打款异常';
        s['color'] = Color(0xFFFF3939).value;
        break;
      case 4:
        s['text'] = '审核未通过';
        s['color'] = Color(0xFFFF3939).value;
        break;
    }
    return s;
  }
}
