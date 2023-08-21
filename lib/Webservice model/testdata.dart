// To parse this JSON data, do
//
//     final testData = testDataFromJson(jsonString);

import 'dart:convert';

List<TestData> testDataFromJson(String str) => List<TestData>.from(json.decode(str).map((x) => TestData.fromJson(x)));

String testDataToJson(List<TestData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TestData {
  int id;
  String dateText;
  String testDay;
  String testSubject;
  String timing;
  String duration;
  double totalMarks;
  String syllabus;
  int topicId;
  String topicName;
  String subjectId;

  TestData({
    required this.id,
    required this.dateText,
    required this.testDay,
    required this.testSubject,
    required this.timing,
    required this.duration,
    required this.totalMarks,
    required this.syllabus,
    required this.topicId,
    required this.topicName,
    required this.subjectId,
  });

  factory TestData.fromJson(Map<String, dynamic> json) => TestData(
    id: json["ID"],
    dateText: json["Date_Text"],
    testDay: json["Test_Day"],
    testSubject: json["Test_Subject"],
    timing: json["Timing"],
    duration: json["Duration"],
    totalMarks: json["Total_Marks"],
    syllabus: json["Syllabus"],
    topicId: json["Topic_Id"],
    topicName: json["Topic_Name"],
    subjectId: json["Subject_Id"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "Date_Text": dateText,
    "Test_Day": testDay,
    "Test_Subject": testSubject,
    "Timing": timing,
    "Duration": duration,
    "Total_Marks": totalMarks,
    "Syllabus": syllabus,
    "Topic_Id": topicId,
    "Topic_Name": topicName,
    "Subject_Id": subjectId,
  };
}
