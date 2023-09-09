// To parse this JSON data, do
//
//     final getAdmin = getAdminFromJson(jsonString);

import 'dart:convert';

List<GetAdmin> getAdminFromJson(String str) => List<GetAdmin>.from(json.decode(str).map((x) => GetAdmin.fromJson(x)));

String getAdminToJson(List<GetAdmin> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetAdmin {
  int userId;
  int orgId;
  String headId;
  String headName;
  String subheadId;
  String subheadName;
  String initial;
  String firstName;
  String middleName;
  String lastName;
  String displayName;
  String gender;
  String dob;
  dynamic email;
  String telephone;
  String mobile;
  dynamic address;
  String activeStatus;
  String role;
  String username;
  String password;
  dynamic photo;
  String isOwner;
  String otp;
  String gcm;
  String appStatus;
  String dateAdded;
  String lastSeen;
  dynamic fcm;

  GetAdmin({
    required this.userId,
    required this.orgId,
    required this.headId,
    required this.headName,
    required this.subheadId,
    required this.subheadName,
    required this.initial,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.displayName,
    required this.gender,
    required this.dob,
    required this.email,
    required this.telephone,
    required this.mobile,
    required this.address,
    required this.activeStatus,
    required this.role,
    required this.username,
    required this.password,
    required this.photo,
    required this.isOwner,
    required this.otp,
    required this.gcm,
    required this.appStatus,
    required this.dateAdded,
    required this.lastSeen,
    required this.fcm,
  });

  factory GetAdmin.fromJson(Map<String, dynamic> json) => GetAdmin(
    userId: json["UserId"],
    orgId: json["Org_ID"],
    headId: json["Head_Id"],
    headName: json["Head_Name"],
    subheadId: json["Subhead_Id"],
    subheadName: json["Subhead_Name"],
    initial: json["Initial"],
    firstName: json["First_Name"],
    middleName: json["Middle_Name"],
    lastName: json["Last_Name"],
    displayName: json["Display_Name"],
    gender: json["Gender"],
    dob: json["DOB"],
    email: json["Email"],
    telephone: json["Telephone"],
    mobile: json["Mobile"],
    address: json["Address"],
    activeStatus: json["Active_Status"],
    role: json["Role"],
    username: json["Username"],
    password: json["Password"],
    photo: json["Photo"],
    isOwner: json["Is_Owner"],
    otp: json["OTP"],
    gcm: json["GCM"],
    appStatus: json["App_Status"],
    dateAdded: json["Date_Added"],
    lastSeen: json["Last_Seen"],
    fcm: json["FCM"],
  );

  Map<String, dynamic> toJson() => {
    "UserId": userId,
    "Org_ID": orgId,
    "Head_Id": headId,
    "Head_Name": headName,
    "Subhead_Id": subheadId,
    "Subhead_Name": subheadName,
    "Initial": initial,
    "First_Name": firstName,
    "Middle_Name": middleName,
    "Last_Name": lastName,
    "Display_Name": displayName,
    "Gender": gender,
    "DOB": dob,
    "Email": email,
    "Telephone": telephone,
    "Mobile": mobile,
    "Address": address,
    "Active_Status": activeStatus,
    "Role": role,
    "Username": username,
    "Password": password,
    "Photo": photo,
    "Is_Owner": isOwner,
    "OTP": otp,
    "GCM": gcm,
    "App_Status": appStatus,
    "Date_Added": dateAdded,
    "Last_Seen": lastSeen,
    "FCM": fcm,
  };
}
