import 'package:code_zero/network/convert_interface.dart';

class WalletModel extends ConvertInterface {
  String? points;
  String? balance;
  String? commission;        //累计佣金
  String? commissionToday;	//今日佣金
  String? commissionWeek;   //近7日佣金
  WalletModel({this.points, this.balance, this.commission, this.commissionToday, this.commissionWeek});

  WalletModel.fromJson(Map<String, dynamic> json) {
    points = json['points'];
    balance = json['balance'];
    commission = json['commission'];
    commissionToday = json['commissionToday'];
    commissionWeek = json['commissionWeek'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['points'] = this.points;
    data['balance'] = this.balance;
    data['commission'] = this.commission;
    data['commissionToday'] = this.commissionToday;
    data['commissionWeek'] = this.commissionWeek;
    return data;
  }

  @override
  ConvertInterface fromJson(Map<String, dynamic> json) {
    return WalletModel.fromJson(json);
  }
}
