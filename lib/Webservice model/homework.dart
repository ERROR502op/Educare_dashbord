// To parse this JSON data, do
//
//     final homework = homeworkFromJson(jsonString);

import 'dart:convert';

List<Homework> homeworkFromJson(String str) => List<Homework>.from(json.decode(str).map((x) => Homework.fromJson(x)));

String homeworkToJson(List<Homework> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Homework {
  int homeworkId;
  String subjectId;
  String name;
  String subject;
  String description;
  String dateIssued;
  String submissionDate;
  String uploadBy;

  Homework({
    required this.homeworkId,
    required this.subjectId,
    required this.name,
    required this.subject,
    required this.description,
    required this.dateIssued,
    required this.submissionDate,
    required this.uploadBy,
  });

  factory Homework.fromJson(Map<String, dynamic> json) => Homework(
    homeworkId: json["Homework_Id"],
    subjectId: json["Subject_Id"],
    name: json["Name"],
    subject: json["Subject"],
    description: json["Description"],
    dateIssued: json["Date_Issued"],
    submissionDate: json["Submission_Date"],
    uploadBy: json["Upload_By"],
  );

  Map<String, dynamic> toJson() => {
    "Homework_Id": homeworkId,
    "Subject_Id": subjectId,
    "Name": name,
    "Subject": subject,
    "Description": description,
    "Date_Issued": dateIssued,
    "Submission_Date": submissionDate,
    "Upload_By": uploadBy,
  };
}
