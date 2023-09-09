// To parse this JSON data, do
//
//     final getstd = getstdFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Getstd> getstdFromJson(String str) => List<Getstd>.from(json.decode(str).map((x) => Getstd.fromJson(x)));

String getstdToJson(List<Getstd> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Getstd {
  int stdId;
  String headId;
  String headName;
  String subheadId;
  String subheadName;
  String stdName;
  String dateAdded;
  int orgId;
  dynamic prefix;

  Getstd({
    required this.stdId,
    required this.headId,
    required this.headName,
    required this.subheadId,
    required this.subheadName,
    required this.stdName,
    required this.dateAdded,
    required this.orgId,
    required this.prefix,
  });

  factory Getstd.fromJson(Map<String, dynamic> json) => Getstd(
    stdId: json["Std_Id"],
    headId: json["Head_Id"],
    headName: json["Head_Name"],
    subheadId: json["Subhead_Id"],
    subheadName: json["Subhead_Name"],
    stdName: json["Std_Name"],
    dateAdded: json["Date_Added"],
    orgId: json["Org_Id"],
    prefix: json["Prefix"],
  );

  Map<String, dynamic> toJson() => {
    "Std_Id": stdId,
    "Head_Id": headId,
    "Head_Name": headName,
    "Subhead_Id": subheadId,
    "Subhead_Name": subheadName,
    "Std_Name": stdName,
    "Date_Added": dateAdded,
    "Org_Id": orgId,
    "Prefix": prefix,
  };
}
