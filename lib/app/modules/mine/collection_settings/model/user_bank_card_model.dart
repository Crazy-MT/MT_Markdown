import 'package:code_zero/network/convert_interface.dart';

class UserBankCardModel extends ConvertInterface {
  int? code;
  String? message;
  Data? data;

  @override
  fromJson(Map<String, dynamic> json) {
    return UserBankCardModel.fromJson(json);
  }

  UserBankCardModel({this.code, this.message, this.data});

  UserBankCardModel.fromJson(Map<String, dynamic> json) {
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
  String? bankCardNum;
  String? bankAddress;
  String? bankName;
  String? bank;
  int? userId;

  Data({this.id, this.name, this.phone, this.bankCardNum, this.bankAddress, this.bankName, this.bank, this.userId});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    bankCardNum = json['bankCardNum'];
    bankAddress = json['bankAddress'];
    bankName = json['bankName'];
    bank = json['bank'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['bankCardNum'] = this.bankCardNum;
    data['bankAddress'] = this.bankAddress;
    data['bankName'] = this.bankName;
    data['bank'] = this.bank;
    data['userId'] = this.userId;
    return data;
  }
}
