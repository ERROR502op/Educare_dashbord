// To parse this JSON data, do
//
//     final getBannerImg = getBannerImgFromJson(jsonString);

import 'dart:convert';

List<GetBannerImg> getBannerImgFromJson(String str) => List<GetBannerImg>.from(json.decode(str).map((x) => GetBannerImg.fromJson(x)));

String getBannerImgToJson(List<GetBannerImg> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetBannerImg {
  int id;
  String title;
  String description;
  String image;
  String url;
  String imageUrl;

  GetBannerImg({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.url,
    required this.imageUrl,
  });

  factory GetBannerImg.fromJson(Map<String, dynamic> json) => GetBannerImg(
    id: json["ID"],
    title: json["Title"],
    description: json["Description"],
    image: json["Image"],
    url: json["Url"],
    imageUrl: json["ImageUrl"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "Title": title,
    "Description": description,
    "Image": image,
    "Url": url,
    "ImageUrl": imageUrl,
  };
}
