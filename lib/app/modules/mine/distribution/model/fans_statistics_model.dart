import 'package:code_zero/network/convert_interface.dart';

class FansStatisticsModel extends ConvertInterface {
  int? todayCount;
  int? historyCount;

  FansStatisticsModel({this.todayCount, this.historyCount});

  FansStatisticsModel.fromJson(Map<String, dynamic> json) {
    todayCount = json['todayCount'];
    historyCount = json['historyCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['todayCount'] = this.todayCount;
    data['historyCount'] = this.historyCount;
    return data;
  }

  @override
  ConvertInterface fromJson(Map<String, dynamic> json) {
    return FansStatisticsModel.fromJson(json);
  }
}
