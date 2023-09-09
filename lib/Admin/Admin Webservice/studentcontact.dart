// To parse this JSON data, do
//
//     final studentcontact = studentcontactFromJson(jsonString);

import 'dart:convert';

List<Studentcontact> studentcontactFromJson(String str) => List<Studentcontact>.from(json.decode(str).map((x) => Studentcontact.fromJson(x)));

String studentcontactToJson(List<Studentcontact> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Studentcontact {
  int id;
  String firstName;
  String fatherMobile;
  String lastName;
  String batchId;

  Studentcontact({
    required this.id,
    required this.firstName,
    required this.fatherMobile,
    required this.lastName,
    required this.batchId,
  });

  factory Studentcontact.fromJson(Map<String, dynamic> json) => Studentcontact(
    id: json["ID"],
    firstName: json["First_Name"],
    fatherMobile: json["Father_Mobile"],
    lastName: json["Last_Name"],
    batchId: json["Batch_ID"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "First_Name": firstName,
    "Father_Mobile": fatherMobile,
    "Last_Name": lastName,
    "Batch_ID": batchId,
  };
}
