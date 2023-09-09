// To parse this JSON data, do
//
//     final getMedium = getMediumFromJson(jsonString);

import 'dart:convert';

List<GetMedium> getMediumFromJson(String str) => List<GetMedium>.from(json.decode(str).map((x) => GetMedium.fromJson(x)));

String getMediumToJson(List<GetMedium> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetMedium {
  String medium;
  int headId;
  String headAddress;

  GetMedium({
    required this.medium,
    required this.headId,
    required this.headAddress,
  });

  factory GetMedium.fromJson(Map<String, dynamic> json) => GetMedium(
    medium: json["Medium"],
    headId: json["Head_Id"],
    headAddress: json["Head_Address"],
  );
  Map<String, dynamic> toJson() => {
    "Medium": medium,
    "Head_Id": headId,
    "Head_Address": headAddress,
  };
}
