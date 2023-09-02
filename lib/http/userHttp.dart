
import 'package:dio/dio.dart';
import 'package:rentalapp/json/user.dart';

class UserService{
  Dio dio = Dio();

  late User user;

  getOneUser(var id) async{
    try{
      Response response = await dio.get("http://localhost:9001/api/users/$id");
      if(response.statusCode == 200){
       return user = User.fromJson(response.data);
      }
    }catch(e){
      return e;
    }
  }



  postUser(UserDto userDto) async{
    try{
      Response response = await dio.post("http://localhost:9001/api/users", data: userDto.toJon());
      if(response.statusCode == 200){
        return response.statusMessage;
      }
    }catch(e){
      return e;
    }
  }

  putUser(UserDto userDto, var id) async{
    try{
      Response response = await dio.put("http://localhost:9001/api/users/$id", data: userDto.toJon());
      if(response.statusCode == 200){
        return response.statusMessage;
      }
    }catch(e){
      return e;
    }
  }

  delUser(var id) async{
    try{
      Response response = await dio.delete("http://localhost:9001/api/users/$id");
      if(response.statusCode == 200){
        return response.statusMessage;
      }
    }catch(e){
      return e;
    }
  }

}