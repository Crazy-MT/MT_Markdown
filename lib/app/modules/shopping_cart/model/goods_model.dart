import 'package:code_zero/network/convert_interface.dart';

class GoodsModel extends ConvertInterface {
  int? id;
  String? name;
  String? price;
  String? url;
  int? num;
  String? desc;

  @override
  fromJson(Map<String, dynamic> json) {
    return GoodsModel.fromJson(json);
  }

  GoodsModel({this.id, this.name, this.price, this.url, this.num, this.desc});

  GoodsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    url = json['url'];
    num = json['num'];
    desc = json['desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['url'] = this.url;
    data['num'] = this.num;
    data['desc'] = this.desc;
    return data;
  }
}
