// To parse this JSON data, do
//
//     final remarkData = remarkDataFromJson(jsonString);

import 'dart:convert';

List<RemarkData> remarkDataFromJson(String str) => List<RemarkData>.from(json.decode(str).map((x) => RemarkData.fromJson(x)));

String remarkDataToJson(List<RemarkData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RemarkData {
  String remarks;
  String uploadBy;
  String uploadedOn;

  RemarkData({
    required this.remarks,
    required this.uploadBy,
    required this.uploadedOn,
  });

  factory RemarkData.fromJson(Map<String, dynamic> json) => RemarkData(
    remarks: json["Remarks"],
    uploadBy: json["Upload_By"],
    uploadedOn: json["Uploaded_On"],
  );

  Map<String, dynamic> toJson() => {
    "Remarks": remarks,
    "Upload_By": uploadBy,
    "Uploaded_On": uploadedOn,
  };
}
