// To parse this JSON data, do
//
//     final feesSummary = feesSummaryFromJson(jsonString);

import 'dart:convert';

List<FeesSummary> feesSummaryFromJson(String str) => List<FeesSummary>.from(json.decode(str).map((x) => FeesSummary.fromJson(x)));

String feesSummaryToJson(List<FeesSummary> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FeesSummary {
  double finalTFees;
  double tPaid;
  double tBal;
  double finalDFees;
  double dPaid;
  double dBal;

  FeesSummary({
    required this.finalTFees,
    required this.tPaid,
    required this.tBal,
    required this.finalDFees,
    required this.dPaid,
    required this.dBal,
  });

  factory FeesSummary.fromJson(Map<String, dynamic> json) => FeesSummary(
    finalTFees: json["Final_T_Fees"],
    tPaid: json["T_Paid"],
    tBal: json["T_Bal"],
    finalDFees: json["Final_D_Fees"],
    dPaid: json["D_Paid"],
    dBal: json["D_Bal"],
  );

  Map<String, dynamic> toJson() => {
    "Final_T_Fees": finalTFees,
    "T_Paid": tPaid,
    "T_Bal": tBal,
    "Final_D_Fees": finalDFees,
    "D_Paid": dPaid,
    "D_Bal": dBal,
  };
}
