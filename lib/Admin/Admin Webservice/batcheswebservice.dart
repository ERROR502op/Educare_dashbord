// To parse this JSON data, do
//
//     final batches = batchesFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Batches> batchesFromJson(String str) => List<Batches>.from(json.decode(str).map((x) => Batches.fromJson(x)));

String batchesToJson(List<Batches> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Batches {
  int batchId;
  String headId;
  String headName;
  String subheadId;
  String subheadName;
  String stdId;
  String stdName;
  String batchName;
  int orgId;
  String dateAdded;
  int studentCount;

  Batches({
    required this.batchId,
    required this.headId,
    required this.headName,
    required this.subheadId,
    required this.subheadName,
    required this.stdId,
    required this.stdName,
    required this.batchName,
    required this.orgId,
    required this.dateAdded,
    required this.studentCount,
  });

  factory Batches.fromJson(Map<String, dynamic> json) => Batches(
    batchId: json["Batch_Id"],
    headId: json["Head_Id"],
    headName: json["Head_Name"],
    subheadId: json["Subhead_Id"],
    subheadName: json["Subhead_Name"],
    stdId: json["Std_Id"],
    stdName: json["Std_Name"],
    batchName: json["Batch_Name"],
    orgId: json["Org_Id"],
    dateAdded: json["Date_Added"],
    studentCount: json["Student_Count"],
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
    "Org_Id": orgId,
    "Date_Added": dateAdded,
    "Student_Count": studentCount,
  };
}
