import 'dart:convert';

import 'package:dio/dio.dart';

class Ad {
  String id;
  String title;
  String description;
  num price;
  String category;
  String measure;
  int phone;
  List<String> images;
  List<MultipartFile> imagesFiles = [];
  bool isBoosted;
  double latitude;
  double longitude;
  Ad();

  Ad.fromMap(Map<String, dynamic> data) {
    id = data["id"] as String;
    title = data["title"] as String;
    description = data["description"] as String;
    price = data["price"] as num;
    category = data["category"] as String;
    measure = data["measure"] as String;
    phone = data["phone"] as int;
    images = data["images"].map((image) => image["url"]).toList().cast<String>()
        as List<String>;
    isBoosted = data["isBoosted"] as bool;
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = {
      "data": jsonEncode({
        "title": title,
        "description": description,
        "price": price,
        "category": category,
        "measure": measure,
        "phone": phone,
        "geolocation": {
          "type": "Point",
          "coordinates": [longitude, latitude],
        },
      }),
      "files.images": imagesFiles,
    };
    return map;
  }
}
