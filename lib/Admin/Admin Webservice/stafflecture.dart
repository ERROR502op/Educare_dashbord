// To parse this JSON data, do
//
//     final stafflecture = stafflectureFromJson(jsonString);

import 'dart:convert';

List<Stafflecture> stafflectureFromJson(String str) => List<Stafflecture>.from(json.decode(str).map((x) => Stafflecture.fromJson(x)));

String stafflectureToJson(List<Stafflecture> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Stafflecture {
  int id;
  String date;
  String headId;
  String subheadId;
  String stdId;
  String stdName;
  String batchId;
  String batchName;
  String subjectId;
  String subjectName;
  String type;
  String teacherId;
  String teacherName;
  String lectureTest;
  String lectureDate;
  String dateTxt;
  String fromTime;
  String toTime;
  String duration;
  String description;
  String uploadedById;
  String attendanceMarked;
  String topicId;
  String topicName;
  int orgId;
  dynamic lecType;
  dynamic link;
  dynamic meetingId;
  dynamic password;

  Stafflecture({
    required this.id,
    required this.date,
    required this.headId,
    required this.subheadId,
    required this.stdId,
    required this.stdName,
    required this.batchId,
    required this.batchName,
    required this.subjectId,
    required this.subjectName,
    required this.type,
    required this.teacherId,
    required this.teacherName,
    required this.lectureTest,
    required this.lectureDate,
    required this.dateTxt,
    required this.fromTime,
    required this.toTime,
    required this.duration,
    required this.description,
    required this.uploadedById,
    required this.attendanceMarked,
    required this.topicId,
    required this.topicName,
    required this.orgId,
    this.lecType,
    this.link,
    this.meetingId,
    this.password,
  });

  factory Stafflecture.fromJson(Map<String, dynamic> json) => Stafflecture(
    id: json["ID"],
    date: json["Date"],
    headId: json["Head_Id"],
    subheadId: json["Subhead_Id"],
    stdId: json["Std_Id"],
    stdName: json["Std_Name"],
    batchId: json["Batch_Id"],
    batchName: json["Batch_Name"],
    subjectId: json["Subject_Id"],
    subjectName: json["Subject_Name"],
    type: json["Type"],
    teacherId: json["Teacher_Id"],
    teacherName: json["Teacher_Name"],
    lectureTest: json["Lecture_Test"],
    lectureDate: json["Lecture_Date"],
    dateTxt: json["Date_Txt"],
    fromTime: json["From_Time"],
    toTime: json["To_Time"],
    duration: json["Duration"],
    description: json["Description"],
    uploadedById: json["Uploaded_By_Id"],
    attendanceMarked: json["Attendance_Marked"],
    topicId: json["Topic_Id"],
    topicName: json["Topic_Name"],
    orgId: json["Org_Id"],
    lecType: json["Lec_Type"],
    link: json["Link"],
    meetingId: json["Meeting_Id"],
    password: json["Password"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "Date": date,
    "Head_Id": headId,
    "Subhead_Id": subheadId,
    "Std_Id": stdId,
    "Std_Name": stdName,
    "Batch_Id": batchId,
    "Batch_Name": batchName,
    "Subject_Id": subjectId,
    "Subject_Name": subjectName,
    "Type": type,
    "Teacher_Id": teacherId,
    "Teacher_Name": teacherName,
    "Lecture_Test": lectureTest,
    "Lecture_Date": lectureDate,
    "Date_Txt": dateTxt,
    "From_Time": fromTime,
    "To_Time": toTime,
    "Duration": duration,
    "Description": description,
    "Uploaded_By_Id": uploadedById,
    "Attendance_Marked": attendanceMarked,
    "Topic_Id": topicId,
    "Topic_Name": topicName,
    "Org_Id": orgId,
    "Lec_Type": lecType,
    "Link": link,
    "Meeting_Id": meetingId,
    "Password": password,
  };
}
