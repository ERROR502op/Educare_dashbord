// To parse this JSON data, do
//
//     final notice = noticeFromJson(jsonString);

import 'dart:convert';

List<Notice> noticeFromJson(String str) => List<Notice>.from(json.decode(str).map((x) => Notice.fromJson(x)));

String noticeToJson(List<Notice> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Notice {
  int srNo;
  String date;
  String title;
  String desc;
  String uploadBy;

  Notice({
    required this.srNo,
    required this.date,
    required this.title,
    required this.desc,
    required this.uploadBy,
  });

  factory Notice.fromJson(Map<String, dynamic> json) => Notice(
    srNo: json["Sr_No"],
    date: json["Date"],
    title: json["Title"],
    desc: json["Desc"],
    uploadBy: json["Upload_By"],
  );

  Map<String, dynamic> toJson() => {
    "Sr_No": srNo,
    "Date": date,
    "Title": title,
    "Desc": desc,
    "Upload_By": uploadBy,
  };
}
