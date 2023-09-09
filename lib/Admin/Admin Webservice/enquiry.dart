// To parse this JSON data, do
//
//     final enquiry = enquiryFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Enquiry> enquiryFromJson(String str) => List<Enquiry>.from(json.decode(str).map((x) => Enquiry.fromJson(x)));

String enquiryToJson(List<Enquiry> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Enquiry {
  String name;
  String status;
  String lastFollowup;
  String nextFollowup;
  String latestRemarks;

  Enquiry({
    required this.name,
    required this.status,
    required this.lastFollowup,
    required this.nextFollowup,
    required this.latestRemarks,
  });

  factory Enquiry.fromJson(Map<String, dynamic> json) => Enquiry(
    name: json["Name"],
    status: json["Status"],
    lastFollowup: json["LastFollowup"],
    nextFollowup: json["NextFollowup"],
    latestRemarks: json["Latest_Remarks"],
  );

  Map<String, dynamic> toJson() => {
    "Name": name,
    "Status": status,
    "LastFollowup": lastFollowup,
    "NextFollowup": nextFollowup,
    "Latest_Remarks": latestRemarks,
  };
}
