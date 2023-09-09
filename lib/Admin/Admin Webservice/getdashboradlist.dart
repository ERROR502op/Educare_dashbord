
import 'dart:convert';

List<Getdashboradlist> getdashboradlistFromJson(String str) => List<Getdashboradlist>.from(json.decode(str).map((x) => Getdashboradlist.fromJson(x)));

String getdashboradlistToJson(List<Getdashboradlist> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Getdashboradlist {
  String name;
  dynamic std;
  dynamic batch;
  String mobile;
  String studentId;
  String address;
  String mobileForSms;
  String fatherName;
  String fatherMobile;
  String motherName;
  String motherMobile;

  Getdashboradlist({
    required this.name,
    required this.std,
    required this.batch,
    required this.mobile,
    required this.studentId,
    required this.address,
    required this.mobileForSms,
    required this.fatherName,
    required this.fatherMobile,
    required this.motherName,
    required this.motherMobile,
  });

  factory Getdashboradlist.fromJson(Map<String, dynamic> json) => Getdashboradlist(
    name: json["Name"],
    std: json["Std"],
    batch: json["Batch"],
    mobile: json["Mobile"],
    studentId: json["StudentId"],
    address: json["Address"],
    mobileForSms: json["Mobile_For_SMS"],
    fatherName: json["Father_Name"],
    fatherMobile: json["Father_Mobile"],
    motherName: json["Mother_Name"],
    motherMobile: json["Mother_Mobile"],
  );

  Map<String, dynamic> toJson() => {
    "Name": name,
    "Std": std,
    "Batch": batch,
    "Mobile": mobile,
    "StudentId": studentId,
    "Address": address,
    "Mobile_For_SMS": mobileForSms,
    "Father_Name": fatherName,
    "Father_Mobile": fatherMobile,
    "Mother_Name": motherName,
    "Mother_Mobile": motherMobile,
  };
}
