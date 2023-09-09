// To parse this JSON data, do
//
//     final notes = notesFromJson(jsonString);

import 'dart:convert';

List<Notes> notesFromJson(String str) => List<Notes>.from(json.decode(str).map((x) => Notes.fromJson(x)));

String notesToJson(List<Notes> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Notes {
  int srNo;
  String headId;
  String subheadId;
  String stdId;
  String stdName;
  String batchId;
  String batchName;
  String date;
  String title;
  String subId;
  String subName;
  String filepath;
  String uploadedBy;
  String uploadedById;
  String uploadedOn;
  int orgId;
  String description;

  Notes({
    required this.srNo,
    required this.headId,
    required this.subheadId,
    required this.stdId,
    required this.stdName,
    required this.batchId,
    required this.batchName,
    required this.date,
    required this.title,
    required this.subId,
    required this.subName,
    required this.filepath,
    required this.uploadedBy,
    required this.uploadedById,
    required this.uploadedOn,
    required this.orgId,
    required this.description,
  });

  factory Notes.fromJson(Map<String, dynamic> json) => Notes(
    srNo: json["Sr_No"],
    headId: json["Head_Id"],
    subheadId: json["Subhead_Id"],
    stdId: json["Std_Id"],
    stdName: json["Std_Name"],
    batchId: json["Batch_Id"],
    batchName: json["Batch_Name"],
    date: json["Date"],
    title: json["Title"],
    subId: json["Sub_Id"],
    subName: json["Sub_Name"],
    filepath: json["Filepath"],
    uploadedBy: json["Uploaded_By"],
    uploadedById: json["Uploaded_By_Id"],
    uploadedOn: json["Uploaded_On"],
    orgId: json["Org_Id"],
    description: json["Description"],
  );

  Map<String, dynamic> toJson() => {
    "Sr_No": srNo,
    "Head_Id": headId,
    "Subhead_Id": subheadId,
    "Std_Id": stdId,
    "Std_Name": stdName,
    "Batch_Id": batchId,
    "Batch_Name": batchName,
    "Date": date,
    "Title": title,
    "Sub_Id": subId,
    "Sub_Name": subName,
    "Filepath": filepath,
    "Uploaded_By": uploadedBy,
    "Uploaded_By_Id": uploadedById,
    "Uploaded_On": uploadedOn,
    "Org_Id": orgId,
    "Description": description,
  };
}
