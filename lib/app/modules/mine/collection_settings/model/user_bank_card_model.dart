import 'package:code_zero/network/convert_interface.dart';

class UserBankCardModel extends ConvertInterface {
  int? id;
  String? name;
  String? phone;
  String? bankCardNum;
  String? bankAddress;
  String? bankName;
  String? bank;
  int? userId;

  UserBankCardModel({this.id, this.name, this.phone, this.bankCardNum, this.bankAddress, this.bankName, this.bank, this.userId});

  UserBankCardModel.fromJson(Map<String, dynamic> json) {
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

  @override
  ConvertInterface fromJson(Map<String, dynamic> json) {
    return UserBankCardModel.fromJson(json);
  }
}
