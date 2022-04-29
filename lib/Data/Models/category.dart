import 'dart:ui';
import 'package:flutter/material.dart';
class Category{
  late String  image , id ;
  late Color color ;
  late DateTime date;
  Map<String , String> name = {
    "en" : "",
    "ar" : "",
  };

  // ignore: non_constant_identifier_names
  Category({required this.image, required this.id , required this.color , required this.date , required this.name});

  toJson(){
    return {
      "image" : image,
      "id" : id,
      "color" : "${color}",
      "date" : date,
      "name_en" :name["en"],
      "name_ar" : name["ar"],
    };
  }
  Category.fromJason(data){
    print("Parsing");
    color = Color(int.parse(data.get('color').split('(0x')[1].split(')')[0], radix: 16));
    image = data.get("image");
    id = data.get("id");
    date = DateTime.now();
    name["en"] = data.get("name_en");
    name["ar"] = data.get("name_ar");
  }
}