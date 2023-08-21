// To parse this JSON data, do
//
//     final lecPresent = lecPresentFromJson(jsonString);

import 'dart:convert';

List<LecPresent> lecPresentFromJson(String str) => List<LecPresent>.from(json.decode(str).map((x) => LecPresent.fromJson(x)));

String lecPresentToJson(List<LecPresent> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LecPresent {
  int srNo;
  String headId;
  String subheadId;
  String stdId;
  String stdName;
  String batchId;
  String batchName;
  String uuid;
  String id;
  String studentId;
  String name;
  String type;
  String date;
  String day;
  String month;
  String year;
  String lectureId;
  String status;
  String remark;
  String uploadedById;
  String uploadedOn;
  String lectureName;
  String dateOn;

  LecPresent({
    required this.srNo,
    required this.headId,
    required this.subheadId,
    required this.stdId,
    required this.stdName,
    required this.batchId,
    required this.batchName,
    required this.uuid,
    required this.id,
    required this.studentId,
    required this.name,
    required this.type,
    required this.date,
    required this.day,
    required this.month,
    required this.year,
    required this.lectureId,
    required this.status,
    required this.remark,
    required this.uploadedById,
    required this.uploadedOn,
    required this.lectureName,
    required this.dateOn,
  });

  factory LecPresent.fromJson(Map<String, dynamic> json) => LecPresent(
    srNo: json["Sr_No"],
    headId: json["Head_Id"],
    subheadId: json["Subhead_Id"],
    stdId: json["Std_Id"],
    stdName: json["Std_Name"],
    batchId: json["Batch_Id"],
    batchName: json["Batch_Name"],
    uuid: json["UUID"],
    id: json["ID"],
    studentId: json["Student_Id"],
    name: json["Name"],
    type: json["Type"],
    date: json["Date"],
    day: json["Day"],
    month: json["Month"],
    year: json["Year"],
    lectureId: json["Lecture_Id"],
    status: json["Status"],
    remark: json["Remark"],
    uploadedById: json["Uploaded_By_Id"],
    uploadedOn: json["Uploaded_On"],
    lectureName: json["Lecture_Name"],
    dateOn: json["Date_On"],
  );

  Map<String, dynamic> toJson() => {
    "Sr_No": srNo,
    "Head_Id": headId,
    "Subhead_Id": subheadId,
    "Std_Id": stdId,
    "Std_Name": stdName,
    "Batch_Id": batchId,
    "Batch_Name": batchName,
    "UUID": uuid,
    "ID": id,
    "Student_Id": studentId,
    "Name": name,
    "Type": type,
    "Date": date,
    "Day": day,
    "Month": month,
    "Year": year,
    "Lecture_Id": lectureId,
    "Status": status,
    "Remark": remark,
    "Uploaded_By_Id": uploadedById,
    "Uploaded_On": uploadedOn,
    "Lecture_Name": lectureName,
    "Date_On": dateOn,
  };
}
