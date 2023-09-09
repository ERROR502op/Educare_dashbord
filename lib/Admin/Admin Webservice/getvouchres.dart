// To parse this JSON data, do
//
//     final vouchers = vouchersFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Vouchers> vouchersFromJson(String str) => List<Vouchers>.from(json.decode(str).map((x) => Vouchers.fromJson(x)));

String vouchersToJson(List<Vouchers> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Vouchers {
  int id;
  String vNo;
  String receiver;
  String particulars;
  dynamic amount;

  Vouchers({
    required this.id,
    required this.vNo,
    required this.receiver,
    required this.particulars,
    required this.amount,
  });

  factory Vouchers.fromJson(Map<String, dynamic> json) => Vouchers(
    id: json["Id"],
    vNo: json["V_No"],
    receiver: json["Receiver"],
    particulars: json["Particulars"],
    amount: json["Amount"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "V_No": vNo,
    "Receiver": receiver,
    "Particulars": particulars,
    "Amount": amount,
  };
}
