// To parse this JSON data, do
//
//     final getsubject = getsubjectFromJson(jsonString);

import 'dart:convert';

List<Getsubject> getsubjectFromJson(String str) => List<Getsubject>.from(json.decode(str).map((x) => Getsubject.fromJson(x)));

String getsubjectToJson(List<Getsubject> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Getsubject {
  String subId;
  String subName;

  Getsubject({
    required this.subId,
    required this.subName,
  });

  factory Getsubject.fromJson(Map<String, dynamic> json) => Getsubject(
    subId: json["Sub_Id"],
    subName: json["Sub_Name"],
  );

  Map<String, dynamic> toJson() => {
    "Sub_Id": subId,
    "Sub_Name": subName,
  };
}
