import 'package:code_zero/network/convert_interface.dart';

class UserWechatModel extends ConvertInterface {
  int? code;
  String? message;
  Data? data;

  @override
  fromJson(Map<String, dynamic> json) {
    return UserWechatModel.fromJson(json);
  }

  UserWechatModel({this.code, this.message, this.data});

  UserWechatModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? phone;
  String? wechatAccount;
  String? wechatPaymentCodeUrl;
  int? userId;

  Data({this.id, this.name, this.phone, this.wechatAccount, this.wechatPaymentCodeUrl, this.userId});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    wechatAccount = json['wechatAccount'];
    wechatPaymentCodeUrl = json['wechatPaymentCodeUrl'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['wechatAccount'] = this.wechatAccount;
    data['wechatPaymentCodeUrl'] = this.wechatPaymentCodeUrl;
    data['userId'] = this.userId;
    return data;
  }
}
