import 'package:code_zero/network/convert_interface.dart';

class IncomeModel extends ConvertInterface{
  List<IncomeItems>? items;
  int? totalCount;

  IncomeModel({this.items, this.totalCount});

  IncomeModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <IncomeItems>[];
      json['items'].forEach((v) {
        items!.add(new IncomeItems.fromJson(v));
      });
    }
    totalCount = json['totalCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    data['totalCount'] = this.totalCount;
    return data;
  }

  @override
  ConvertInterface fromJson(Map<String, dynamic> json) {
    return IncomeModel.fromJson(json);
  }
}

class IncomeItems {
  int? id;
  String? sellPrice;
  String? buyPrice;
  String? charge;
  String? income;
  String? desc;
  String? createdAt;
  String? name;

  IncomeItems(
      {this.id,
        this.sellPrice,
        this.buyPrice,
        this.charge,
        this.income,
        this.desc,
        this.createdAt,
        this.name});

  IncomeItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sellPrice = json['sellPrice'];
    buyPrice = json['buyPrice'];
    charge = json['charge'];
    income = json['income'];
    desc = json['desc'];
    createdAt = json['createdAt'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sellPrice'] = this.sellPrice;
    data['buyPrice'] = this.buyPrice;
    data['charge'] = this.charge;
    data['income'] = this.income;
    data['desc'] = this.desc;
    data['createdAt'] = this.createdAt;
    data['name'] = this.name;
    return data;
  }
}
