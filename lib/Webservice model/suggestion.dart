// To parse this JSON data, do
//
//     final getSuggestion = getSuggestionFromJson(jsonString);

import 'dart:convert';

List<GetSuggestion> getSuggestionFromJson(String str) => List<GetSuggestion>.from(json.decode(str).map((x) => GetSuggestion.fromJson(x)));

String getSuggestionToJson(List<GetSuggestion> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetSuggestion {
  int complaintId;
  dynamic complaintNo;
  String headId;
  String headName;
  String subheadId;
  String subheadName;
  String stdId;
  String stdName;
  String batchId;
  String batchName;
  String id;
  String uuid;
  String studentId;
  String name;
  String title;
  String description;
  String raisedById;
  String raisedByRole;
  String raisedOn;
  String status;
  dynamic resolvingDes;
  dynamic resolvedById;
  dynamic resolvedByRole;
  dynamic resolvedOn;
  int orgId;
  String raisedOnConvert;
  dynamic resolvedOnConvert;

  GetSuggestion({
    required this.complaintId,
    required this.complaintNo,
    required this.headId,
    required this.headName,
    required this.subheadId,
    required this.subheadName,
    required this.stdId,
    required this.stdName,
    required this.batchId,
    required this.batchName,
    required this.id,
    required this.uuid,
    required this.studentId,
    required this.name,
    required this.title,
    required this.description,
    required this.raisedById,
    required this.raisedByRole,
    required this.raisedOn,
    required this.status,
    required this.resolvingDes,
    required this.resolvedById,
    required this.resolvedByRole,
    required this.resolvedOn,
    required this.orgId,
    required this.raisedOnConvert,
    required this.resolvedOnConvert,
  });

  factory GetSuggestion.fromJson(Map<String, dynamic> json) => GetSuggestion(
    complaintId: json["Complaint_Id"],
    complaintNo: json["Complaint_No"],
    headId: json["Head_Id"],
    headName: json["Head_Name"],
    subheadId: json["Subhead_Id"],
    subheadName: json["Subhead_Name"],
    stdId: json["Std_Id"],
    stdName: json["Std_Name"],
    batchId: json["Batch_Id"],
    batchName: json["Batch_Name"],
    id: json["ID"],
    uuid: json["UUID"],
    studentId: json["Student_Id"],
    name: json["Name"],
    title: json["Title"],
    description: json["Description"],
    raisedById: json["Raised_By_Id"],
    raisedByRole: json["Raised_By_role"],
    raisedOn: json["Raised_On"],
    status: json["Status"],
    resolvingDes: json["Resolving_des"],
    resolvedById: json["Resolved_By_Id"],
    resolvedByRole: json["Resolved_By_role"],
    resolvedOn: json["Resolved_On"],
    orgId: json["Org_Id"],
    raisedOnConvert: json["Raised_On_Convert"],
    resolvedOnConvert: json["Resolved_On_Convert"],
  );

  Map<String, dynamic> toJson() => {
    "Complaint_Id": complaintId,
    "Complaint_No": complaintNo,
    "Head_Id": headId,
    "Head_Name": headName,
    "Subhead_Id": subheadId,
    "Subhead_Name": subheadName,
    "Std_Id": stdId,
    "Std_Name": stdName,
    "Batch_Id": batchId,
    "Batch_Name": batchName,
    "ID": id,
    "UUID": uuid,
    "Student_Id": studentId,
    "Name": name,
    "Title": title,
    "Description": description,
    "Raised_By_Id": raisedById,
    "Raised_By_role": raisedByRole,
    "Raised_On": raisedOn,
    "Status": status,
    "Resolving_des": resolvingDes,
    "Resolved_By_Id": resolvedById,
    "Resolved_By_role": resolvedByRole,
    "Resolved_On": resolvedOn,
    "Org_Id": orgId,
    "Raised_On_Convert": raisedOnConvert,
    "Resolved_On_Convert": resolvedOnConvert,
  };
}
