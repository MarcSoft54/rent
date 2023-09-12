
import 'package:image_picker/image_picker.dart';

class FromData{
  String name;
  String date;
  Object? file;

  FromData({
    required this.name,
    required this.date,
    required this.file
  });

  factory FromData.fromJson(Map<String, dynamic> json){
    return FromData(
      name: json["name"],
      date: json["date"],
      file: json["file"]
    );
  }
}