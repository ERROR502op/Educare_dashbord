// To parse this JSON data, do
//
//     final staffattendance = staffattendanceFromJson(jsonString);

import 'dart:convert';

List<Staffattendance> staffattendanceFromJson(String str) => List<Staffattendance>.from(json.decode(str).map((x) => Staffattendance.fromJson(x)));

String staffattendanceToJson(List<Staffattendance> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Staffattendance {
  int userId;
  int id;
  Name name;
  BranchName branchName;
  BranchId branchId;
  String date;
  String timeLog;
  String dateConvert;

  Staffattendance({
    required this.userId,
    required this.id,
    required this.name,
    required this.branchName,
    required this.branchId,
    required this.date,
    required this.timeLog,
    required this.dateConvert,
  });

  factory Staffattendance.fromJson(Map<String, dynamic> json) => Staffattendance(
    userId: json["User_Id"],
    id: json["Id"],
    name: nameValues.map[json["Name"]]!,
    branchName: branchNameValues.map[json["Branch_Name"]]!,
    branchId: branchIdValues.map[json["Branch_Id"]]!,
    date: json["Date"],
    timeLog: json["TimeLog"],
    dateConvert: json["Date_Convert"],
  );

  Map<String, dynamic> toJson() => {
    "User_Id": userId,
    "Id": id,
    "Name": nameValues.reverse[name],
    "Branch_Name": branchNameValues.reverse[branchName],
    "Branch_Id": branchIdValues.reverse[branchId],
    "Date": date,
    "TimeLog": timeLog,
    "Date_Convert": dateConvert,
  };
}

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

enum Name {
  CHANDA
}

final nameValues = EnumValues({
  "CHANDA .": Name.CHANDA
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
