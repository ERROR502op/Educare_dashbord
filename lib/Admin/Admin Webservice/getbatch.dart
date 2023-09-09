// To parse this JSON data, do
//
//     final getbatch = getbatchFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Getbatch> getbatchFromJson(String str) => List<Getbatch>.from(json.decode(str).map((x) => Getbatch.fromJson(x)));

String getbatchToJson(List<Getbatch> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Getbatch {
  int batchId;
  String headId;
  String headName;
  String subheadId;
  String subheadName;
  String stdId;
  String stdName;
  String batchName;
  String dateAdded;
  int orgId;

  Getbatch({
    required this.batchId,
    required this.headId,
    required this.headName,
    required this.subheadId,
    required this.subheadName,
    required this.stdId,
    required this.stdName,
    required this.batchName,
    required this.dateAdded,
    required this.orgId,
  });

  factory Getbatch.fromJson(Map<String, dynamic> json) => Getbatch(
    batchId: json["Batch_Id"],
    headId: json["Head_Id"],
    headName: json["Head_Name"],
    subheadId: json["Subhead_Id"],
    subheadName: json["Subhead_Name"],
    stdId: json["Std_Id"],
    stdName: json["Std_Name"],
    batchName: json["Batch_Name"],
    dateAdded: json["Date_Added"],
    orgId: json["Org_Id"],
  );

  Map<String, dynamic> toJson() => {
    "Batch_Id": batchId,
    "Head_Id": headId,
    "Head_Name": headName,
    "Subhead_Id": subheadId,
    "Subhead_Name": subheadName,
    "Std_Id": stdId,
    "Std_Name": stdName,
    "Batch_Name": batchName,
    "Date_Added": dateAdded,
    "Org_Id": orgId,
  };
}
