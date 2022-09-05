import 'package:code_zero/network/convert_interface.dart';

class ShelfCommodityModel extends ConvertInterface {
  int? buyingTransactionId;
  int? commodityId;
  String? commoditySessionName;
  String? commodityName;
  String? commodityPrice;
  String? maxPrice;
  String? recommendPrice;
  String? charge;

  ShelfCommodityModel(
      {this.buyingTransactionId,
        this.commodityId,
        this.commoditySessionName,
        this.commodityName,
        this.commodityPrice,
        this.maxPrice,
        this.recommendPrice,
        this.charge});

  ShelfCommodityModel.fromJson(Map<String, dynamic> json) {
    buyingTransactionId = json['buyingTransactionId'];
    commodityId = json['commodityId'];
    commoditySessionName = json['commoditySessionName'];
    commodityName = json['commodityName'];
    commodityPrice = json['commodityPrice'];
    maxPrice = json['maxPrice'];
    recommendPrice = json['recommendPrice'];
    charge = json['charge'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['buyingTransactionId'] = this.buyingTransactionId;
    data['commodityId'] = this.commodityId;
    data['commoditySessionName'] = this.commoditySessionName;
    data['commodityName'] = this.commodityName;
    data['commodityPrice'] = this.commodityPrice;
    data['maxPrice'] = this.maxPrice;
    data['recommendPrice'] = this.recommendPrice;
    data['charge'] = this.charge;
    return data;
  }

  @override
  ConvertInterface fromJson(Map<String, dynamic> json) {
    return ShelfCommodityModel.fromJson(json);
  }
}
