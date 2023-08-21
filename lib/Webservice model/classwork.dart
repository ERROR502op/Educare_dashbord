// To parse this JSON data, do
//
//     final classwork = classworkFromJson(jsonString);

import 'dart:convert';

List<Classwork> classworkFromJson(String str) => List<Classwork>.from(json.decode(str).map((x) => Classwork.fromJson(x)));

String classworkToJson(List<Classwork> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Classwork {
  int id;
  String attatchment;
  String subjectId;
  String subject;
  String description;
  String dateIssued;
  String submissionDate;
  String uploadBy;

  Classwork({
    required this.id,
    required this.attatchment,
    required this.subjectId,
    required this.subject,
    required this.description,
    required this.dateIssued,
    required this.submissionDate,
    required this.uploadBy,
  });

  factory Classwork.fromJson(Map<String, dynamic> json) => Classwork(
    id: json["ID"],
    attatchment: json["Attatchment"],
    subjectId: json["Subject_Id"],
    subject: json["Subject"],
    description: json["Description"],
    dateIssued: json["Date_Issued"],
    submissionDate: json["Submission_Date"],
    uploadBy: json["Upload_By"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "Attatchment": attatchment,
    "Subject_Id": subjectId,
    "Subject": subject,
    "Description": description,
    "Date_Issued": dateIssued,
    "Submission_Date": submissionDate,
    "Upload_By": uploadBy,
  };
}
