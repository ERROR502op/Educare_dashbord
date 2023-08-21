// To parse this JSON data, do
//
//     final holiday = holidayFromJson(jsonString);

import 'dart:convert';

List<Holiday> holidayFromJson(String str) => List<Holiday>.from(json.decode(str).map((x) => Holiday.fromJson(x)));

String holidayToJson(List<Holiday> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Holiday {
  int id;
  String headId;
  String subheadId;
  String stdId;
  String stdName;
  String batchId;
  String batchName;
  String day;
  String month;
  String year;
  String holidayDate;
  String discription;
  String uploadedById;
  String uploadedOn;
  int orgId;
  String dateOn;

  Holiday({
    required this.id,
    required this.headId,
    required this.subheadId,
    required this.stdId,
    required this.stdName,
    required this.batchId,
    required this.batchName,
    required this.day,
    required this.month,
    required this.year,
    required this.holidayDate,
    required this.discription,
    required this.uploadedById,
    required this.uploadedOn,
    required this.orgId,
    required this.dateOn,
  });

  factory Holiday.fromJson(Map<String, dynamic> json) => Holiday(
    id: json["ID"],
    headId: json["Head_Id"],
    subheadId: json["Subhead_Id"],
    stdId: json["Std_Id"],
    stdName: json["Std_Name"],
    batchId: json["Batch_Id"],
    batchName: json["Batch_Name"],
    day: json["Day"],
    month: json["Month"],
    year: json["Year"],
    holidayDate: json["Holiday_Date"],
    discription: json["Discription"],
    uploadedById: json["Uploaded_By_Id"],
    uploadedOn: json["Uploaded_On"],
    orgId: json["Org_Id"],
    dateOn: json["Date_On"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "Head_Id": headId,
    "Subhead_Id": subheadId,
    "Std_Id": stdId,
    "Std_Name": stdName,
    "Batch_Id": batchId,
    "Batch_Name": batchName,
    "Day": day,
    "Month": month,
    "Year": year,
    "Holiday_Date": holidayDate,
    "Discription": discription,
    "Uploaded_By_Id": uploadedById,
    "Uploaded_On": uploadedOn,
    "Org_Id": orgId,
    "Date_On": dateOn,
  };
}
