import 'package:code_zero/network/convert_interface.dart';

class RuleModel extends ConvertInterface{
  List<String>? roles;

  RuleModel({this.roles});

  RuleModel.fromJson(Map<String, dynamic> json) {
    roles = json['roles'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['roles'] = this.roles;
    return data;
  }

  @override
  ConvertInterface fromJson(Map<String, dynamic> json) {
    return RuleModel.fromJson(json);
  }
}
