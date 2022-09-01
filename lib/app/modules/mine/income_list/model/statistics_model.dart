import 'package:code_zero/network/convert_interface.dart';

class StatisticsModel extends ConvertInterface {
  String? total;
  String? today;

  StatisticsModel({this.total, this.today});

  StatisticsModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    today = json['today'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['today'] = this.today;
    return data;
  }

  @override
  ConvertInterface fromJson(Map<String, dynamic> json) {
    return StatisticsModel.fromJson(json);
  }
}
