// To parse this JSON data, do
//
//     final adminGetNotice = adminGetNoticeFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<AdminGetNotice> adminGetNoticeFromJson(String str) => List<AdminGetNotice>.from(json.decode(str).map((x) => AdminGetNotice.fromJson(x)));

String adminGetNoticeToJson(List<AdminGetNotice> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AdminGetNotice {
  int noticeId;
  String date;
  String headId;
  String subheadId;
  String stdId;
  String stdName;
  String batchId;
  String batchName;
  String type;
  String title;
  String description;
  String uploadedById;
  String role;
  String uploadedByName;
  dynamic fileName;
  dynamic fileType;
  int orgId;
  String dateConvert;

  AdminGetNotice({
    required this.noticeId,
    required this.date,
    required this.headId,
    required this.subheadId,
    required this.stdId,
    required this.stdName,
    required this.batchId,
    required this.batchName,
    required this.type,
    required this.title,
    required this.description,
    required this.uploadedById,
    required this.role,
    required this.uploadedByName,
    required this.fileName,
    required this.fileType,
    required this.orgId,
    required this.dateConvert,
  });

  factory AdminGetNotice.fromJson(Map<String, dynamic> json) => AdminGetNotice(
    noticeId: json["Notice_Id"],
    date: json["Date"],
    headId: json["Head_Id"],
    subheadId: json["Subhead_Id"],
    stdId: json["Std_Id"],
    stdName: json["Std_Name"],
    batchId: json["Batch_Id"],
    batchName: json["Batch_Name"],
    type: json["Type"],
    title: json["Title"],
    description: json["Description"],
    uploadedById: json["Uploaded_By_Id"],
    role: json["Role"],
    uploadedByName: json["Uploaded_By_Name"],
    fileName: json["FileName"],
    fileType: json["FileType"],
    orgId: json["Org_Id"],
    dateConvert: json["DateConvert"],
  );

  Map<String, dynamic> toJson() => {
    "Notice_Id": noticeId,
    "Date": date,
    "Head_Id": headId,
    "Subhead_Id": subheadId,
    "Std_Id": stdId,
    "Std_Name": stdName,
    "Batch_Id": batchId,
    "Batch_Name": batchName,
    "Type": type,
    "Title": title,
    "Description": description,
    "Uploaded_By_Id": uploadedById,
    "Role": role,
    "Uploaded_By_Name": uploadedByName,
    "FileName": fileName,
    "FileType": fileType,
    "Org_Id": orgId,
    "DateConvert": dateConvert,
  };
}
