import 'package:code_zero/network/convert_interface.dart';

class UserWechatModel extends ConvertInterface {
  int? id;
  String? name;
  String? phone;
  String? wechatAccount;
  String? wechatPaymentCodeUrl;
  int? userId;

  UserWechatModel({this.id, this.name, this.phone, this.wechatAccount, this.wechatPaymentCodeUrl, this.userId});

  UserWechatModel.fromJson(Map<String, dynamic> json) {
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

  @override
  ConvertInterface fromJson(Map<String, dynamic> json) {
    return UserWechatModel.fromJson(json);
  }
}
