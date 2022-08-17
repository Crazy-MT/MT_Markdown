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

  @override
  fromJson(Map<String, dynamic> json) {
    return UserModel.fromJson(json);
  }

  UserModel({this.id, this.nickname, this.gender, this.avatarUrl, this.hasPhone, this.phone, this.isCaptain, this.isMember, this.hasBirthday, this.birthday, this.token});

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
    return data;
  }
}
