import 'package:code_zero/network/convert_interface.dart';

class WalletModel extends ConvertInterface {
  String? points;
  String? balance;
  String? commission;        //累计佣金
  String? commissionToday;	//今日佣金
  String? commissionWeek;   //近7日佣金
  String? tranTotalPrice;	//订单总额
  int? tranTotalCount;	//订单数
  WalletModel({this.points, this.balance, this.commission, this.commissionToday, this.commissionWeek, this.tranTotalCount, this.tranTotalPrice});

  WalletModel.fromJson(Map<String, dynamic> json) {
    points = json['points'];
    balance = json['balance'];
    commission = json['commission'];
    commissionToday = json['commissionToday'];
    commissionWeek = json['commissionWeek'];
    tranTotalPrice = json['tranTotalPrice'];
    tranTotalCount = json['tranTotalCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['points'] = this.points;
    data['balance'] = this.balance;
    data['commission'] = this.commission;
    data['commissionToday'] = this.commissionToday;
    data['commissionWeek'] = this.commissionWeek;
    data['tranTotalPrice'] = this.tranTotalPrice;
    data['tranTotalCount'] = this.tranTotalCount;
    return data;
  }

  @override
  ConvertInterface fromJson(Map<String, dynamic> json) {
    return WalletModel.fromJson(json);
  }
}
