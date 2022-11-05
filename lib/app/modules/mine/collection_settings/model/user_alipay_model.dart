import 'package:code_zero/network/convert_interface.dart';

class UserAlipayModel extends ConvertInterface {
  int? id;
  String? name;
  String? phone;
  String? alipayAccount;
  String? alipayPaymentCodeUrl;
  int? userId;

  UserAlipayModel({this.id, this.name, this.phone, this.alipayAccount, this.alipayPaymentCodeUrl, this.userId});

  UserAlipayModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    alipayAccount = json['alipayAccount'];
    alipayPaymentCodeUrl = json['alipayPaymentCodeUrl'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['alipayAccount'] = this.alipayAccount;
    data['alipayPaymentCodeUrl'] = this.alipayPaymentCodeUrl;
    data['userId'] = this.userId;
    return data;
  }

  @override
  ConvertInterface fromJson(Map<String, dynamic> json) {
    return UserAlipayModel.fromJson(json);
  }
}
