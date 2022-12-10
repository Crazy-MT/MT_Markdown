import 'package:code_zero/network/convert_interface.dart';

class WalletModel extends ConvertInterface {
  String? points;
  String? balance;
  String? commission;        //累计收益
  String? commissionToday;	//今日收益
  String? commissionWeek;   //近7日收益
  String? tranTotalPrice;	//订单总额
  String? redEnvelopeAmount; // 红包金额
  String? completedRedEnvelopeAmount; // 可提现金额
  int? tranTotalCount;	//订单数
  WalletModel({this.points, this.balance, this.commission, this.commissionToday, this.commissionWeek, this.tranTotalCount, this.tranTotalPrice, this.redEnvelopeAmount, this.completedRedEnvelopeAmount});

  WalletModel.fromJson(Map<String, dynamic> json) {
    points = json['points'];
    balance = json['balance'];
    commission = json['commission'];
    commissionToday = json['commissionToday'];
    commissionWeek = json['commissionWeek'];
    tranTotalPrice = json['tranTotalPrice'];
    tranTotalCount = json['tranTotalCount'];
    redEnvelopeAmount =  json['redEnvelopeAmount'];
    completedRedEnvelopeAmount = json['completedRedEnvelopeAmount'];
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
    data['redEnvelopeAmount'] = this.redEnvelopeAmount;
    data['completedRedEnvelopeAmount'] = this.completedRedEnvelopeAmount;
    return data;
  }

  @override
  ConvertInterface fromJson(Map<String, dynamic> json) {
    return WalletModel.fromJson(json);
  }
}
