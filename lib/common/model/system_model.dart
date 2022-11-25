import 'package:code_zero/network/convert_interface.dart';

class SystemSettingModel extends ConvertInterface{
  int? id;
  String? charge;
  int? openCommission;
  String? firstCommissionRate;
  int? tradeTime;
  int? tradeConfirmTime;
  String? buyingNotice;
  int? buyingCount;
  int? buyingAdvanceTime;
  String? maxPriceRate;
  String? recommendPriceRate;
  String? shelfStartTime;
  String? shelfEndTime;
  int? confirmReceiptTime;
  String? paymentName;
  String? paymentPhone;
  String? paymentBankCardNum;
  String? paymentBankAddress;
  String? paymentBankName;
  String? paymentBank;
  String? updatedAt;
  String? hotline;
  String? sponsoredLinks;
  String? posterUrl;
  int? auditSwitch; // 审核开关：0->关闭、1->开启
  String? fromUserReward;
  String? toUserReward;

  SystemSettingModel(
      {this.id,
        this.fromUserReward,
        this.toUserReward,
        this.charge,
        this.posterUrl,
        this.openCommission,
        this.firstCommissionRate,
        this.tradeTime,
        this.tradeConfirmTime,
        this.buyingNotice,
        this.buyingCount,
        this.maxPriceRate,
        this.recommendPriceRate,
        this.shelfStartTime,
        this.shelfEndTime,
        this.confirmReceiptTime,
        this.sponsoredLinks,
        this.paymentName,
        this.paymentPhone,
        this.paymentBankCardNum,
        this.paymentBankAddress,
        this.buyingAdvanceTime,
        this.paymentBankName,
        this.paymentBank,
        this.updatedAt,
        this.hotline,
      this.auditSwitch});

  SystemSettingModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    toUserReward = json['toUserReward'];
    fromUserReward = json['fromUserReward'];
    charge = json['charge'];
    openCommission = json['openCommission'];
    firstCommissionRate = json['firstCommissionRate'];
    tradeTime = json['tradeTime'];
    tradeConfirmTime = json['tradeConfirmTime'];
    buyingNotice = json['buyingNotice'];
    buyingCount = json['buyingCount'];
    maxPriceRate = json['maxPriceRate'];
    sponsoredLinks = json['sponsoredLinks'];
    recommendPriceRate = json['recommendPriceRate'];
    shelfStartTime = json['shelfStartTime'];
    shelfEndTime = json['shelfEndTime'];
    confirmReceiptTime = json['confirmReceiptTime'];
    paymentName = json['paymentName'];
    paymentPhone = json['paymentPhone'];
    paymentBankCardNum = json['paymentBankCardNum'];
    paymentBankAddress = json['paymentBankAddress'];
    paymentBankName = json['paymentBankName'];
    buyingAdvanceTime = json['buyingAdvanceTime'];
    paymentBank = json['paymentBank'];
    updatedAt = json['updatedAt'];
    hotline = json['hotline'];
    auditSwitch = json['auditSwitch'];
    posterUrl = json['posterUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['charge'] = this.charge;
    data['openCommission'] = this.openCommission;
    data['firstCommissionRate'] = this.firstCommissionRate;
    data['tradeTime'] = this.tradeTime;
    data['tradeConfirmTime'] = this.tradeConfirmTime;
    data['buyingNotice'] = this.buyingNotice;
    data['buyingCount'] = this.buyingCount;
    data['maxPriceRate'] = this.maxPriceRate;
    data['recommendPriceRate'] = this.recommendPriceRate;
    data['shelfStartTime'] = this.shelfStartTime;
    data['shelfEndTime'] = this.shelfEndTime;
    data['confirmReceiptTime'] = this.confirmReceiptTime;
    data['paymentName'] = this.paymentName;
    data['paymentPhone'] = this.paymentPhone;
    data['paymentBankCardNum'] = this.paymentBankCardNum;
    data['paymentBankAddress'] = this.paymentBankAddress;
    data['paymentBankName'] = this.paymentBankName;
    data['paymentBank'] = this.paymentBank;
    data['updatedAt'] = this.updatedAt;
    data['hotline'] = this.hotline;
    data['buyingAdvanceTime'] = this.buyingAdvanceTime;
    data['auditSwitch'] = this.auditSwitch;
    data['posterUrl'] = this.posterUrl;
    data['fromUserReward'] = this.fromUserReward;
    data['toUserReward'] = this.toUserReward;
    return data;
  }

  @override
  ConvertInterface fromJson(Map<String, dynamic> json) {
    return SystemSettingModel.fromJson(json);
  }
}
