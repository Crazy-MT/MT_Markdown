import '../../../../../network/convert_interface.dart';

class CommodityModel extends ConvertInterface {
    CommodityModel({
        this.items,
        this.totalCount,
    });

    List<Item>? items;
    int? totalCount;

    Map<String, dynamic> toJson() => {
        "items": items == null ? List<dynamic>.from(items!.map((x) => x.toJson())) : [],
        "totalCount": totalCount,
    };

  @override
  ConvertInterface fromJson(Map<String, dynamic> json) => CommodityModel(
      items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      totalCount: json["totalCount"],
  );
}

class Item {
    Item({
        this.id,
        this.name,
        this.commodityType,
        this.sessionId,
        this.sessionName,
        this.categoryId,
        this.categoryName,
        this.originalPrice,
        this.currentPrice,
        this.orderNo,
        this.showParams,
        this.isDelete,
        this.status,
        this.shelfId,
        this.shelfNickname,
        this.shelfPhone,
        this.shelfAt,
        this.ownerIsAdmin,
        this.inventory,
        this.transCount,
        this.thumbnails,
        this.parameterImages,
        this.images,
    });

    int? id;
    String? name;
    int? commodityType;
    int? sessionId;
    String? sessionName;
    int? categoryId;
    String? categoryName;
    String? originalPrice;
    String? currentPrice;
    int? orderNo;
    List<ShowParam>? showParams;
    int? isDelete;
    int? status;
    int? shelfId;
    ShelfNickname? shelfNickname;
    ShelfPhone? shelfPhone;
    DateTime? shelfAt;
    int? ownerIsAdmin;
    int? inventory;
    int? transCount;
    List<String>? thumbnails;
    List<String>? parameterImages;
    List<String>? images;

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        name: json["name"],
        commodityType: json["commodityType"],
        sessionId: json["sessionId"],
        sessionName: json["sessionName"],
        categoryId: json["categoryId"],
        categoryName: json["categoryName"],
        originalPrice: json["originalPrice"],
        currentPrice: json["currentPrice"],
        orderNo: json["orderNo"],
        showParams: List<ShowParam>.from(json["showParams"].map((x) => ShowParam.fromJson(x))),
        isDelete: json["isDelete"],
        status: json["status"],
        shelfId: json["shelfId"],
        shelfNickname: shelfNicknameValues.map[json["shelfNickname"]],
        shelfPhone: shelfPhoneValues.map[json["shelfPhone"]],
        shelfAt: DateTime.parse(json["shelfAt"]),
        ownerIsAdmin: json["ownerIsAdmin"],
        inventory: json["inventory"],
        transCount: json["transCount"],
        thumbnails: List<String>.from(json["thumbnails"].map((x) => x)),
        parameterImages: List<String>.from(json["parameterImages"].map((x) => x)),
        images: List<String>.from(json["images"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": nameValues.reverse[name],
        "commodityType": commodityType,
        "sessionId": sessionId,
        "sessionName": sessionNameValues.reverse[sessionName],
        "categoryId": categoryId,
        "categoryName": categoryName,
        "originalPrice": originalPrice,
        "currentPrice": currentPrice,
        "orderNo": orderNo,
        "showParams": showParams != null ? List<dynamic>.from(showParams!.map((x) => x.toJson())) : [],
        "isDelete": isDelete,
        "status": status,
        "shelfId": shelfId,
        "shelfNickname": shelfNicknameValues.reverse[shelfNickname],
        "shelfPhone": shelfPhoneValues.reverse[shelfPhone],
        "shelfAt": shelfAt?.toIso8601String(),
        "ownerIsAdmin": ownerIsAdmin,
        "inventory": inventory,
        "transCount": transCount,
        "thumbnails": thumbnails != null ? List<dynamic>.from(thumbnails!.map((x) => x)) : [],
        "parameterImages": parameterImages != null ? List<dynamic>.from(parameterImages!.map((x) => x))  : [],
        "images": images != null ? List<dynamic>.from(images!.map((x) => x)) : [],
    };
}

enum Name { THE_3 }

final nameValues = EnumValues({
    "大金镯子3": Name.THE_3
});

enum SessionName { EMPTY, SESSION_NAME }

final sessionNameValues = EnumValues({
    "黄金": SessionName.EMPTY,
    "翡翠专区": SessionName.SESSION_NAME
});

enum ShelfNickname { SASAXIE, EMPTY }

final shelfNicknameValues = EnumValues({
    "商家自营": ShelfNickname.EMPTY,
    "sasaxie": ShelfNickname.SASAXIE
});

enum ShelfPhone { THE_15510015550, EMPTY }

final shelfPhoneValues = EnumValues({
    "": ShelfPhone.EMPTY,
    "15510015550": ShelfPhone.THE_15510015550
});

class ShowParam {
    ShowParam({
        this.empty,
        this.isGood,
    });

    Empty? empty;
    int? isGood;

    factory ShowParam.fromJson(Map<String, dynamic> json) => ShowParam(
        empty: json["名称"] == null ? null : emptyValues.map[json["名称"]],
        isGood: json["isGood"] == null ? null : json["isGood"],
    );

    Map<String, dynamic> toJson() => {
        "名称": empty == null ? null : emptyValues.reverse[empty],
        "isGood": isGood == null ? null : isGood,
    };
}

enum Empty { EMPTY }

final emptyValues = EnumValues({
    "大金镯子": Empty.EMPTY
});

class EnumValues<T> {
    Map<String, T> map = {};
    Map<T, String> reverseMap = {};

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}
