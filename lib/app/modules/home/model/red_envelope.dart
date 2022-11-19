import 'package:code_zero/network/convert_interface.dart';

class RedEnvelope extends ConvertInterface{
  int? hasNewRedEnvelope;
  String? newRedEnvelopeAmount;
  int? isNewUser;

  RedEnvelope({this.hasNewRedEnvelope, this.newRedEnvelopeAmount, this.isNewUser});

  RedEnvelope.fromJson(Map<String, dynamic> json) {
    hasNewRedEnvelope = json['id'];
    newRedEnvelopeAmount = json['newRedEnvelopeAmount'];
    isNewUser = json['isNewUser'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hasNewRedEnvelope'] = this.hasNewRedEnvelope;
    data['newRedEnvelopeAmount'] = this.newRedEnvelopeAmount;
    data['isNewUser'] = this.isNewUser;
    return data;
  }

  @override
  ConvertInterface fromJson(Map<String, dynamic> json) {
    return RedEnvelope.fromJson(json);
  }
}