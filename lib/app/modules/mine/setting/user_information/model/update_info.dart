/*{
"id": 7,
"avatarUrl": "http://127.0.0.1:8080/uploads/20220818/6e8b952661735235ef6f6dafd3daa42b.jpeg",
"nickname": "sasaxie",
"gender": 1,
"hasBirthday": 1,
"birthday": "2001-02-03"
}*/

import '../../../../../../network/convert_interface.dart';

class UpdateInfoModel extends ConvertInterface {
  int? id;
  String? avatarUrl;
  String? nickname;
  int? gender;
  int? hasBirthday;
  String? birthday;

  @override
  fromJson(Map<String, dynamic> json) {
    return UpdateInfoModel.fromJson(json);
  }

  UpdateInfoModel(
      {this.id,
      this.avatarUrl,
      this.nickname,
      this.gender,
      this.hasBirthday,
      this.birthday});

  UpdateInfoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    avatarUrl = json['avatarUrl'];
    nickname = json['nickname'];
    gender = json['gender'];
    hasBirthday = json['hasBirthday'];
    birthday = json['birthday'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['avatarUrl'] = this.avatarUrl;
    data['nickname'] = this.nickname;
    data['gender'] = this.gender;
    data['hasBirthday'] = this.hasBirthday;
    data['birthday'] = this.birthday;
    return data;
  }
}
