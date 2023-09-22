
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rentalapp/json/user.dart';

import '../../json/loginDTO.dart';
import '../../json/token.dart';

class UserService{
  Dio dio = Dio();

  ImagePicker imagePicker = ImagePicker();

  late User user;
  String url = "http://192.168.43.109:9001/api/users";

  getOneUser(var id) async{
    try{
      var headers = {
        'Authorization': 'Bearer $id'
      };
      Response response = await dio.request("$url/", options: Options(method: 'GET',headers: headers));
      if(response.statusCode == 200){
        log("${response.data}");
        user = User.fromJson(response.data);
        return user;
      }
    }catch(e){
      log("$e");
    }
  }



  postUser(UserDto userDto) async{
    try{
      Response response = await dio.post(url, data: userDto.toJson());
      // if(response.statusCode == 200){
      //   // return response.statusMessage;
      // }
    }catch(e){
      log("$e");
    }
  }

  putUser(UserDto userDto, var id) async{
    try{
      Response response = await dio.put("$url/$id", data: userDto.toJson());
      if(response.statusCode == 200){
        return response.statusMessage;
      }
    }catch(e){
      log("$e");
    }
  }

  delUser(var id) async{
    try{
      Response response = await dio.delete("$url/$id");
    }catch(e){
      log("$e");
    }
  }

  getPicture() async{
    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
    if(file != null){
      file.readAsBytes().then((value){
        return value;
      });
      // return file.path;
    }
  }

  getUserId(LoginDto loginDto) async{
    try{
      Response response = await dio.post("$url/auth/login", data: loginDto.toJson());
      log("${response.headers}");
      if(response.statusCode == 200){
        log("${response.data}");
        return Token.fromJson(response.data);
      }
    }catch(e){
      log("error get : --> $e");
    }
  }

}