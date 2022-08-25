// ignore_for_file: unnecessary_new

import '../../network/convert_interface.dart';

class UserModel extends ConvertInterface {
  int? id;
  String? nickname;
  int? gender;
  String? avatarUrl;
  int? hasPhone;
  String? phone;
  int? isCaptain;
  int? isMember;
  int? hasBirthday;
  String? birthday;
  String? token;
  int? hasSignature;
  String? signatureUrl;
  int? hasAddress;  //	是否有收货地址：0->否、1->是
  int? hasPaymentMethod; // 是否有收款方式：0->否、1->是

  @override
  fromJson(Map<String, dynamic> json) {
    return UserModel.fromJson(json);
  }

  UserModel({this.id, this.nickname, this.gender, this.avatarUrl, this.hasPhone, this.phone, this.isCaptain, this.isMember, this.hasBirthday, this.birthday, this.token, this.hasSignature, this.signatureUrl, this.hasAddress, this.hasPaymentMethod});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nickname = json['nickname'];
    gender = json['gender'];
    avatarUrl = json['avatarUrl'];
    hasPhone = json['hasPhone'];
    phone = json['phone'];
    isCaptain = json['isCaptain'];
    isMember = json['isMember'];
    hasBirthday = json['hasBirthday'];
    birthday = json['birthday'];
    token = json['token'];
    hasSignature = json['hasSignature'];
    signatureUrl = json['signatureUrl'];
    hasAddress = json['hasAddress'];
    hasPaymentMethod = json['hasPaymentMethod'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nickname'] = this.nickname;
    data['gender'] = this.gender;
    data['avatarUrl'] = this.avatarUrl;
    data['hasPhone'] = this.hasPhone;
    data['phone'] = this.phone;
    data['isCaptain'] = this.isCaptain;
    data['isMember'] = this.isMember;
    data['hasBirthday'] = this.hasBirthday;
    data['birthday'] = this.birthday;
    data['token'] = this.token;
    data['hasSignature'] = this.hasSignature;
    data['signatureUrl'] = this.signatureUrl;
    data['hasAddress'] = this.hasAddress;
    data['hasPaymentMethod'] = this.hasPaymentMethod;
    return data;
  }

  bool member() {
    return isMember == 1;
  }

  bool captain() {
    return isCaptain == 1;
  }

  String getGender() {
    return gender == 0 ? "保密" : (gender == 1 ? "男" : "女");
  }
}
