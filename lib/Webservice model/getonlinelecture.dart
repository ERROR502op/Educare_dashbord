// To parse this JSON data, do
//
//     final getonlinelecture = getonlinelectureFromJson(jsonString);

import 'dart:convert';

List<Getonlinelecture> getonlinelectureFromJson(String str) => List<Getonlinelecture>.from(json.decode(str).map((x) => Getonlinelecture.fromJson(x)));

String getonlinelectureToJson(List<Getonlinelecture> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Getonlinelecture {
  int srNo;
  String lecture;
  String dateText;
  String lectDay;
  String lectTiming;
  String remarks;
  String facultyName;
  String topicId;
  String topicName;
  String subjectId;

  Getonlinelecture({
    required this.srNo,
    required this.lecture,
    required this.dateText,
    required this.lectDay,
    required this.lectTiming,
    required this.remarks,
    required this.facultyName,
    required this.topicId,
    required this.topicName,
    required this.subjectId,
  });

  factory Getonlinelecture.fromJson(Map<String, dynamic> json) => Getonlinelecture(
    srNo: json["Sr_No"],
    lecture: json["Lecture"],
    dateText: json["Date_Text"],
    lectDay: json["Lect_Day"],
    lectTiming: json["Lect_Timing"],
    remarks: json["Remarks"],
    facultyName: json["Faculty_Name"],
    topicId: json["Topic_Id"],
    topicName: json["Topic_Name"],
    subjectId: json["Subject_Id"],
  );

  Map<String, dynamic> toJson() => {
    "Sr_No": srNo,
    "Lecture": lecture,
    "Date_Text": dateText,
    "Lect_Day": lectDay,
    "Lect_Timing": lectTiming,
    "Remarks": remarks,
    "Faculty_Name": facultyName,
    "Topic_Id": topicId,
    "Topic_Name": topicName,
    "Subject_Id": subjectId,
  };
}
