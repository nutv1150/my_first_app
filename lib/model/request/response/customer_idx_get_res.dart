// To parse this JSON data, do
//
//     final cusIdxGetRes = cusIdxGetResFromJson(jsonString);

import 'dart:convert';

CustomerIdxGetRes CustomerIdxGetResFromJson(String str) =>
    CustomerIdxGetRes.fromJson(json.decode(str));

String CustomerIdxGetResToJson(CustomerIdxGetRes data) =>
    json.encode(data.toJson());

class CustomerIdxGetRes {
  int idx;
  String fullname;
  String phone;
  String email;
  String image;

  CustomerIdxGetRes({
    required this.idx,
    required this.fullname,
    required this.phone,
    required this.email,
    required this.image,
  });

  factory CustomerIdxGetRes.fromJson(Map<String, dynamic> json) =>
      CustomerIdxGetRes(
        idx: json["idx"],
        fullname: json["fullname"],
        phone: json["phone"],
        email: json["email"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
    "idx": idx,
    "fullname": fullname,
    "phone": phone,
    "email": email,
    "image": image,
  };
}
