// To parse this JSON data, do
//
//     final staffData = staffDataFromJson(jsonString);

import 'dart:convert';

List<StaffData> staffDataFromJson(String str) => List<StaffData>.from(json.decode(str).map((x) => StaffData.fromJson(x)));

String staffDataToJson(List<StaffData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StaffData {
  int userId;
  int id;
  BranchId branchId;
  BranchName branchName;
  int orgId;
  String firstName;
  MiddleName middleName;
  String lastName;
  String? dob;
  Gender gender;
  Email email;
  String mobileForSms;
  String mobile2;
  Address address;
  Qualification qualification;
  Photo photo;
  String idProof;
  String addressProof;
  Role role;
  Role roleType;
  String username;
  Password password;
  String status;
  dynamic lastLoginAt;
  String gcm;
  Otp otp;
  String active;
  String? mfInTime;
  String? mfOutTime;
  dynamic satInTime;
  dynamic satOutTime;
  Designation designation;
  FacultyType facultyType;
  PayType payType;
  String amount;
  Deductions overtimeConsideration;
  Deductions deductions;
  WeekOff weekOff;
  bool singlePunch;
  LateHalf lateHalf;
  String secondShiftDay;
  bool payroll;
  dynamic tempIds;

  StaffData({
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

  factory StaffData.fromJson(Map<String, dynamic> json) => StaffData(
    userId: json["User_Id"],
    id: json["ID"],
    branchId: branchIdValues.map[json["Branch_Id"]]!,
    branchName: branchNameValues.map[json["Branch_Name"]]!,
    orgId: json["Org_ID"],
    firstName: json["First_Name"],
    middleName: middleNameValues.map[json["Middle_Name"]]!,
    lastName: json["Last_Name"],
    dob: json["DOB"],
    gender: genderValues.map[json["Gender"]]!,
    email: emailValues.map[json["Email"]]!,
    mobileForSms: json["Mobile_For_SMS"],
    mobile2: json["Mobile2"],
    address: addressValues.map[json["Address"]]!,
    qualification: qualificationValues.map[json["Qualification"]]!,
    photo: photoValues.map[json["Photo"]]!,
    idProof: json["ID_Proof"],
    addressProof: json["Address_Proof"],
    role: roleValues.map[json["Role"]]!,
    roleType: roleValues.map[json["Role_Type"]]!,
    username: json["Username"],
    password: passwordValues.map[json["Password"]]!,
    status: json["Status"],
    lastLoginAt: json["Last_Login_At"],
    gcm: json["GCM"],
    otp: otpValues.map[json["OTP"]]!,
    active: json["Active"],
    mfInTime: json["MF_InTime"],
    mfOutTime: json["MF_OutTime"],
    satInTime: json["Sat_InTime"],
    satOutTime: json["Sat_OutTime"],
    designation: designationValues.map[json["Designation"]]!,
    facultyType: facultyTypeValues.map[json["Faculty_Type"]]!,
    payType: payTypeValues.map[json["PayType"]]!,
    amount: json["Amount"],
    overtimeConsideration: deductionsValues.map[json["Overtime_Consideration"]]!,
    deductions: deductionsValues.map[json["Deductions"]]!,
    weekOff: weekOffValues.map[json["WeekOff"]]!,
    singlePunch: json["SinglePunch"],
    lateHalf: lateHalfValues.map[json["LateHalf"]]!,
    secondShiftDay: json["SecondShiftDay"],
    payroll: json["Payroll"],
    tempIds: json["Temp_Ids"],
  );

  Map<String, dynamic> toJson() => {
    "User_Id": userId,
    "ID": id,
    "Branch_Id": branchIdValues.reverse[branchId],
    "Branch_Name": branchNameValues.reverse[branchName],
    "Org_ID": orgId,
    "First_Name": firstName,
    "Middle_Name": middleNameValues.reverse[middleName],
    "Last_Name": lastName,
    "DOB": dob,
    "Gender": genderValues.reverse[gender],
    "Email": emailValues.reverse[email],
    "Mobile_For_SMS": mobileForSms,
    "Mobile2": mobile2,
    "Address": addressValues.reverse[address],
    "Qualification": qualificationValues.reverse[qualification],
    "Photo": photoValues.reverse[photo],
    "ID_Proof": idProof,
    "Address_Proof": addressProof,
    "Role": roleValues.reverse[role],
    "Role_Type": roleValues.reverse[roleType],
    "Username": username,
    "Password": passwordValues.reverse[password],
    "Status": status,
    "Last_Login_At": lastLoginAt,
    "GCM": gcm,
    "OTP": otpValues.reverse[otp],
    "Active": active,
    "MF_InTime": mfInTime,
    "MF_OutTime": mfOutTime,
    "Sat_InTime": satInTime,
    "Sat_OutTime": satOutTime,
    "Designation": designationValues.reverse[designation],
    "Faculty_Type": facultyTypeValues.reverse[facultyType],
    "PayType": payTypeValues.reverse[payType],
    "Amount": amount,
    "Overtime_Consideration": deductionsValues.reverse[overtimeConsideration],
    "Deductions": deductionsValues.reverse[deductions],
    "WeekOff": weekOffValues.reverse[weekOff],
    "SinglePunch": singlePunch,
    "LateHalf": lateHalfValues.reverse[lateHalf],
    "SecondShiftDay": secondShiftDay,
    "Payroll": payroll,
    "Temp_Ids": tempIds,
  };
}

enum Address {
  DOMBIVALI,
  EMPTY,
  ULHASNAGAR_4
}

final addressValues = EnumValues({
  "DOMBIVALI": Address.DOMBIVALI,
  "": Address.EMPTY,
  "ULHASNAGAR 4": Address.ULHASNAGAR_4
});

enum BranchId {
  ALL
}

final branchIdValues = EnumValues({
  "All": BranchId.ALL
});

enum BranchName {
  ALL_BRANCHES
}

final branchNameValues = EnumValues({
  "All Branches": BranchName.ALL_BRANCHES
});

enum Deductions {
  N,
  Y
}

final deductionsValues = EnumValues({
  "N": Deductions.N,
  "Y": Deductions.Y
});

enum Designation {
  EMPTY,
  QA_TESTER,
  TECHNICAL_SUPPORT
}

final designationValues = EnumValues({
  "": Designation.EMPTY,
  "QA TESTER": Designation.QA_TESTER,
  "TECHNICAL SUPPORT": Designation.TECHNICAL_SUPPORT
});

enum Email {
  EMPTY,
  SANKET_GMAIL_COM,
  VARSHA_GMAIL_COM
}

final emailValues = EnumValues({
  "": Email.EMPTY,
  "sanket@gmail.com": Email.SANKET_GMAIL_COM,
  "VARSHA@GMAIL.COM": Email.VARSHA_GMAIL_COM
});

enum FacultyType {
  NON_TEACHING,
  TEACHING
}

final facultyTypeValues = EnumValues({
  "NonTeaching": FacultyType.NON_TEACHING,
  "Teaching": FacultyType.TEACHING
});

enum Gender {
  FEMALE,
  MALE
}

final genderValues = EnumValues({
  "Female": Gender.FEMALE,
  "Male": Gender.MALE
});

enum LateHalf {
  SHIFTTIME,
  WORKINGHOUR
}

final lateHalfValues = EnumValues({
  "shifttime": LateHalf.SHIFTTIME,
  "workinghour": LateHalf.WORKINGHOUR
});

enum MiddleName {
  BABAN,
  EMPTY,
  GANESH
}

final middleNameValues = EnumValues({
  "BABAN": MiddleName.BABAN,
  "": MiddleName.EMPTY,
  "GANESH": MiddleName.GANESH
});

enum Otp {
  EMPTY,
  MASYS_123
}

final otpValues = EnumValues({
  "": Otp.EMPTY,
  "masys@123": Otp.MASYS_123
});

enum Password {
  TEACHER_123
}

final passwordValues = EnumValues({
  "teacher@123": Password.TEACHER_123
});

enum PayType {
  FIXED,
  HOURLY
}

final payTypeValues = EnumValues({
  "Fixed": PayType.FIXED,
  "Hourly": PayType.HOURLY
});

enum Photo {
  EMPTY,
  THE_4013_DOWNLOAD_JPG,
  THE_8130_DOWNLOAD_JPG
}

final photoValues = EnumValues({
  "": Photo.EMPTY,
  "4013download.jpg": Photo.THE_4013_DOWNLOAD_JPG,
  "8130download.jpg": Photo.THE_8130_DOWNLOAD_JPG
});

enum Qualification {
  BCA_MCA,
  BSC,
  EMPTY,
  M_SC
}

final qualificationValues = EnumValues({
  "BCA, MCA": Qualification.BCA_MCA,
  "BSC": Qualification.BSC,
  "": Qualification.EMPTY,
  "mSC": Qualification.M_SC
});

enum Role {
  TEACHER
}

final roleValues = EnumValues({
  "Teacher": Role.TEACHER
});

enum WeekOff {
  SUNDAY
}

final weekOffValues = EnumValues({
  "Sunday": WeekOff.SUNDAY
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
