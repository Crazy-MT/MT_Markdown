import 'dart:convert';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';

import '../../../../../network/convert_interface.dart';

class DataModel extends ConvertInterface {
  DataModel({
    this.id = 0,
  });

  int id = 0;

  Map<String, dynamic> toJson() => {
    "id": id,
  };

  @override
  ConvertInterface fromJson(Map<String, dynamic> json) => DataModel(
    id: json["id"],
  );
}