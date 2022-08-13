// ignore_for_file: unnecessary_new

import '../../network/convert_interface.dart';

class UserModel extends ConvertInterface {
  bool? isGuest;
  bool? isVip;
  String? email;
  String? token;
  int? phoneNumber;
  String? avatarUrl;
  String? name;
  int? id;

  @override
  fromJson(Map<String, dynamic> json) {
    return UserModel.fromJson(json);
  }

  UserModel(
      {this.isGuest,
      this.isVip,
      this.email,
      this.token,
      this.phoneNumber,
      this.avatarUrl,
      this.name,
      this.id});

  UserModel.fromJson(Map<String, dynamic> json) {
    isGuest = json['isGuest'];
    isVip = json['isVip'];
    email = json['email'];
    token = json['token'];
    phoneNumber = json['phoneNumber'];
    avatarUrl = json['avatarUrl'];
    name = json['name'];
    id = json['id'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isGuest'] = isGuest;
    data['isVip'] = isVip;
    data['email'] = email;
    data['token'] = token;
    data['phoneNumber'] = phoneNumber;
    data['avatarUrl'] = avatarUrl;
    data['name'] = name;
    data['id'] = id;
    return data;
  }
}
