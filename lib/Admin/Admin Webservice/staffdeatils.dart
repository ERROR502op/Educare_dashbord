// To parse this JSON data, do
//
//     final staffdeatils = staffdeatilsFromJson(jsonString);

import 'dart:convert';

List<Staffdeatils> staffdeatilsFromJson(String str) => List<Staffdeatils>.from(json.decode(str).map((x) => Staffdeatils.fromJson(x)));

String staffdeatilsToJson(List<Staffdeatils> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Staffdeatils {
  int userId;
  int id;
  String branchId;
  String branchName;
  int orgId;
  String firstName;
  String middleName;
  String lastName;
  dynamic dob;
  String gender;
  String email;
  String mobileForSms;
  String mobile2;
  String address;
  String qualification;
  String photo;
  String idProof;
  String addressProof;
  String role;
  String roleType;
  String username;
  String password;
  String status;
  dynamic lastLoginAt;
  String gcm;
  String otp;
  String active;
  String mfInTime;
  String mfOutTime;
  dynamic satInTime;
  dynamic satOutTime;
  String designation;
  String facultyType;
  String payType;
  String amount;
  String overtimeConsideration;
  String deductions;
  String weekOff;
  bool singlePunch;
  String lateHalf;
  String secondShiftDay;
  bool payroll;
  dynamic tempIds;

  Staffdeatils({
    required this.userId,
    required this.id,
    required this.branchId,
    required this.branchName,
    required this.orgId,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.dob,
    required this.gender,
    required this.email,
    required this.mobileForSms,
    required this.mobile2,
    required this.address,
    required this.qualification,
    required this.photo,
    required this.idProof,
    required this.addressProof,
    required this.role,
    required this.roleType,
    required this.username,
    required this.password,
    required this.status,
    required this.lastLoginAt,
    required this.gcm,
    required this.otp,
    required this.active,
    required this.mfInTime,
    required this.mfOutTime,
    required this.satInTime,
    required this.satOutTime,
    required this.designation,
    required this.facultyType,
    required this.payType,
    required this.amount,
    required this.overtimeConsideration,
    required this.deductions,
    required this.weekOff,
    required this.singlePunch,
    required this.lateHalf,
    required this.secondShiftDay,
    required this.payroll,
    required this.tempIds,
  });

  factory Staffdeatils.fromJson(Map<String, dynamic> json) => Staffdeatils(
    userId: json["User_Id"],
    id: json["ID"],
    branchId: json["Branch_Id"],
    branchName: json["Branch_Name"],
    orgId: json["Org_ID"],
    firstName: json["First_Name"],
    middleName: json["Middle_Name"],
    lastName: json["Last_Name"],
    dob: json["DOB"],
    gender: json["Gender"],
    email: json["Email"],
    mobileForSms: json["Mobile_For_SMS"],
    mobile2: json["Mobile2"],
    address: json["Address"],
    qualification: json["Qualification"],
    photo: json["Photo"],
    idProof: json["ID_Proof"],
    addressProof: json["Address_Proof"],
    role: json["Role"],
    roleType: json["Role_Type"],
    username: json["Username"],
    password: json["Password"],
    status: json["Status"],
    lastLoginAt: json["Last_Login_At"],
    gcm: json["GCM"],
    otp: json["OTP"],
    active: json["Active"],
    mfInTime: json["MF_InTime"],
    mfOutTime: json["MF_OutTime"],
    satInTime: json["Sat_InTime"],
    satOutTime: json["Sat_OutTime"],
    designation: json["Designation"],
    facultyType: json["Faculty_Type"],
    payType: json["PayType"],
    amount: json["Amount"],
    overtimeConsideration: json["Overtime_Consideration"],
    deductions: json["Deductions"],
    weekOff: json["WeekOff"],
    singlePunch: json["SinglePunch"],
    lateHalf: json["LateHalf"],
    secondShiftDay: json["SecondShiftDay"],
    payroll: json["Payroll"],
    tempIds: json["Temp_Ids"],
  );

  Map<String, dynamic> toJson() => {
    "User_Id": userId,
    "ID": id,
    "Branch_Id": branchId,
    "Branch_Name": branchName,
    "Org_ID": orgId,
    "First_Name": firstName,
    "Middle_Name": middleName,
    "Last_Name": lastName,
    "DOB": dob,
    "Gender": gender,
    "Email": email,
    "Mobile_For_SMS": mobileForSms,
    "Mobile2": mobile2,
    "Address": address,
    "Qualification": qualification,
    "Photo": photo,
    "ID_Proof": idProof,
    "Address_Proof": addressProof,
    "Role": role,
    "Role_Type": roleType,
    "Username": username,
    "Password": password,
    "Status": status,
    "Last_Login_At": lastLoginAt,
    "GCM": gcm,
    "OTP": otp,
    "Active": active,
    "MF_InTime": mfInTime,
    "MF_OutTime": mfOutTime,
    "Sat_InTime": satInTime,
    "Sat_OutTime": satOutTime,
    "Designation": designation,
    "Faculty_Type": facultyType,
    "PayType": payType,
    "Amount": amount,
    "Overtime_Consideration": overtimeConsideration,
    "Deductions": deductions,
    "WeekOff": weekOff,
    "SinglePunch": singlePunch,
    "LateHalf": lateHalf,
    "SecondShiftDay": secondShiftDay,
    "Payroll": payroll,
    "Temp_Ids": tempIds,
  };
}
