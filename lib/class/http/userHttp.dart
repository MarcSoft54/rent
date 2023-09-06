
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rentalapp/json/user.dart';

import '../../json/token.dart';

class UserService{
  Dio dio = Dio();

  ImagePicker imagePicker = ImagePicker();

  late User user;

  getOneUser(var id) async{
    try{
      Response response = await dio.get("http://localhost:9001/api/users/1");
      if(response.statusCode == 200){
        log("${response.headers["set-cookie"]}");
       return user = User.fromJson(response.data);
      }
    }catch(e){
      log("$e");
    }
  }



  postUser(UserDto userDto) async{
    try{
      Response response = await dio.post("http://localhost:9001/api/users", data: userDto.toJson());
      // if(response.statusCode == 200){
      //   // return response.statusMessage;
      // }
    }catch(e){
      log("$e");
    }
  }

  putUser(UserDto userDto, var id) async{
    try{
      Response response = await dio.put("http://localhost:9001/api/users/$id", data: userDto.toJson());
      if(response.statusCode == 200){
        return response.statusMessage;
      }
    }catch(e){
      log("$e");
    }
  }

  delUser(var id) async{
    try{
      Response response = await dio.delete("http://localhost:9001/api/users/$id");
    }catch(e){
      log("$e");
    }
  }

  getPicture() async{
    var file = await imagePicker.pickImage(source: ImageSource.gallery);
    if(file != null){
      return file.path;
    }
  }

  getUserId(String email, String password) async{
    try{
      Response response = await dio.get("http://localhost:9001/api/users/login?email=$email&password=$password");
      log("${response.headers}");
      if(response.statusCode == 200){

        return Token.fromJson(response.data);
      }
    }catch(e){
      log("error $e");
    }
  }

}