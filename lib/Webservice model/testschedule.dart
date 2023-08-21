// To parse this JSON data, do
//
//     final testSchedule = testScheduleFromJson(jsonString);

import 'dart:convert';

List<TestSchedule> testScheduleFromJson(String str) => List<TestSchedule>.from(json.decode(str).map((x) => TestSchedule.fromJson(x)));

String testScheduleToJson(List<TestSchedule> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TestSchedule {
  String monthNo;
  String monthName;
  int monthNo1;

  TestSchedule({
    required this.monthNo,
    required this.monthName,
    required this.monthNo1,
  });

  factory TestSchedule.fromJson(Map<String, dynamic> json) => TestSchedule(
    monthNo: json["Month_No"],
    monthName: json["Month_Name"],
    monthNo1: json["Month_No1"],
  );

  Map<String, dynamic> toJson() => {
    "Month_No": monthNo,
    "Month_Name": monthName,
    "Month_No1": monthNo1,
  };
}
