import 'package:code_zero/network/convert_interface.dart';

class MenuInfo extends ConvertInterface{
  String? name;
  String? path;

  MenuInfo(this.name, this.path);

  @override
  fromJson(Map<String, dynamic> json) {
    return MenuInfo.fromJson(json);
  }


  MenuInfo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['path'] = this.path;
    return data;
  }
}