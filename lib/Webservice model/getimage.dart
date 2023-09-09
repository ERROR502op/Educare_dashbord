// To parse this JSON data, do
//
//     final getimage = getimageFromJson(jsonString);

import 'dart:convert';

List<Getimage> getimageFromJson(String str) => List<Getimage>.from(json.decode(str).map((x) => Getimage.fromJson(x)));

String getimageToJson(List<Getimage> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Getimage {
  int srNo;
  String title;
  String imagename;
  String date;
  String uploadBy;

  Getimage({
    required this.srNo,
    required this.title,
    required this.imagename,
    required this.date,
    required this.uploadBy,
  });

  factory Getimage.fromJson(Map<String, dynamic> json) => Getimage(
    srNo: json["Sr_No"],
    title: json["Title"],
    imagename: json["Imagename"],
    date: json["Date"],
    uploadBy: json["Upload_By"],
  );

  Map<String, dynamic> toJson() => {
    "Sr_No": srNo,
    "Title": title,
    "Imagename": imagename,
    "Date": date,
    "Upload_By": uploadBy,
  };
}
