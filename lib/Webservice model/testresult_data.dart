// To parse this JSON data, do
//
//     final testResult = testResultFromJson(jsonString);

import 'dart:convert';

List<TestResult> testResultFromJson(String str) => List<TestResult>.from(json.decode(str).map((x) => TestResult.fromJson(x)));

String testResultToJson(List<TestResult> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TestResult {
  String testSubject;
  double marksObtained;
  double totalMarks;
  String dateText;
  String resultRemarks;
  String attendance;
  String result;
  int resultId;
  int testId;
  int headId;
  String subheadId;
  String stdId;
  String stdName;
  String batchId;
  String batchName;
  String subjectId;
  String subName;
  int id;
  String uuid;
  String studentId;
  String name;
  String attendance1;
  String attendanceRemark;
  double maxMarks;
  double minMarks;
  double marksObtained1;
  String result1;
  String resultRemark;
  String uploadedById;
  String uploadedOn;
  dynamic marksInserted;
  String uploadedByRole;
  String approval;
  int orgId;
  String dateText1;
  String testDate;

  TestResult({
    required this.testSubject,
    required this.marksObtained,
    required this.totalMarks,
    required this.dateText,
    required this.resultRemarks,
    required this.attendance,
    required this.result,
    required this.resultId,
    required this.testId,
    required this.headId,
    required this.subheadId,
    required this.stdId,
    required this.stdName,
    required this.batchId,
    required this.batchName,
    required this.subjectId,
    required this.subName,
    required this.id,
    required this.uuid,
    required this.studentId,
    required this.name,
    required this.attendance1,
    required this.attendanceRemark,
    required this.maxMarks,
    required this.minMarks,
    required this.marksObtained1,
    required this.result1,
    required this.resultRemark,
    required this.uploadedById,
    required this.uploadedOn,
    required this.marksInserted,
    required this.uploadedByRole,
    required this.approval,
    required this.orgId,
    required this.dateText1,
    required this.testDate,
  });

  factory TestResult.fromJson(Map<String, dynamic> json) => TestResult(
    testSubject: json["Test_Subject"],
    marksObtained: json["Marks_Obtained"],
    totalMarks: json["Total_Marks"],
    dateText: json["Date_Text"],
    resultRemarks: json["Result_Remarks"],
    attendance: json["Attendance"],
    result: json["Result"],
    resultId: json["Result_Id"],
    testId: json["Test_Id"],
    headId: json["Head_Id"],
    subheadId: json["Subhead_Id"],
    stdId: json["Std_Id"],
    stdName: json["Std_Name"],
    batchId: json["Batch_Id"],
    batchName: json["Batch_Name"],
    subjectId: json["Subject_Id"],
    subName: json["Sub_Name"],
    id: json["ID"],
    uuid: json["UUID"],
    studentId: json["Student_Id"],
    name: json["Name"],
    attendance1: json["Attendance1"],
    attendanceRemark: json["Attendance_Remark"],
    maxMarks: json["Max_Marks"],
    minMarks: json["Min_Marks"],
    marksObtained1: json["Marks_Obtained1"],
    result1: json["Result1"],
    resultRemark: json["Result_Remark"],
    uploadedById: json["Uploaded_BY_Id"],
    uploadedOn: json["Uploaded_On"],
    marksInserted: json["Marks_Inserted"],
    uploadedByRole: json["Uploaded_By_Role"],
    approval: json["Approval"],
    orgId: json["Org_Id"],
    dateText1: json["Date_Text1"],
    testDate: json["Test_Date"],
  );

  Map<String, dynamic> toJson() => {
    "Test_Subject": testSubject,
    "Marks_Obtained": marksObtained,
    "Total_Marks": totalMarks,
    "Date_Text": dateText,
    "Result_Remarks": resultRemarks,
    "Attendance": attendance,
    "Result": result,
    "Result_Id": resultId,
    "Test_Id": testId,
    "Head_Id": headId,
    "Subhead_Id": subheadId,
    "Std_Id": stdId,
    "Std_Name": stdName,
    "Batch_Id": batchId,
    "Batch_Name": batchName,
    "Subject_Id": subjectId,
    "Sub_Name": subName,
    "ID": id,
    "UUID": uuid,
    "Student_Id": studentId,
    "Name": name,
    "Attendance1": attendance1,
    "Attendance_Remark": attendanceRemark,
    "Max_Marks": maxMarks,
    "Min_Marks": minMarks,
    "Marks_Obtained1": marksObtained1,
    "Result1": result1,
    "Result_Remark": resultRemark,
    "Uploaded_BY_Id": uploadedById,
    "Uploaded_On": uploadedOn,
    "Marks_Inserted": marksInserted,
    "Uploaded_By_Role": uploadedByRole,
    "Approval": approval,
    "Org_Id": orgId,
    "Date_Text1": dateText1,
    "Test_Date": testDate,
  };
}
