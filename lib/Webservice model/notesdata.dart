// To parse this JSON data, do
//
//     final notesData = notesDataFromJson(jsonString);

import 'dart:convert';

List<NotesData> notesDataFromJson(String str) => List<NotesData>.from(json.decode(str).map((x) => NotesData.fromJson(x)));

String notesDataToJson(List<NotesData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NotesData {
  int srNo;
  String title;
  String filepath;
  String subName;
  String description;

  NotesData({
    required this.srNo,
    required this.title,
    required this.filepath,
    required this.subName,
    required this.description,
  });

  factory NotesData.fromJson(Map<String, dynamic> json) => NotesData(
    srNo: json["Sr_No"],
    title: json["Title"],
    filepath: json["Filepath"],
    subName: json["Sub_Name"],
    description: json["Description"],
  );

  Map<String, dynamic> toJson() => {
    "Sr_No": srNo,
    "Title": title,
    "Filepath": filepath,
    "Sub_Name": subName,
    "Description": description,
  };
}
