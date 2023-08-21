// To parse this JSON data, do
//
//     final getcircular = getcircularFromJson(jsonString);

import 'dart:convert';

List<Getcircular> getcircularFromJson(String str) => List<Getcircular>.from(json.decode(str).map((x) => Getcircular.fromJson(x)));

String getcircularToJson(List<Getcircular> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Getcircular {
  int srNo;
  String dateUploaded;
  String title;
  String desc;
  String uploadBy;

  Getcircular({
    required this.srNo,
    required this.dateUploaded,
    required this.title,
    required this.desc,
    required this.uploadBy,
  });

  factory Getcircular.fromJson(Map<String, dynamic> json) => Getcircular(
    srNo: json["Sr_No"],
    dateUploaded: json["Date_Uploaded"],
    title: json["Title"],
    desc: json["Desc"],
    uploadBy: json["Upload_By"],
  );

  Map<String, dynamic> toJson() => {
    "Sr_No": srNo,
    "Date_Uploaded": dateUploaded,
    "Title": title,
    "Desc": desc,
    "Upload_By": uploadBy,
  };
}
