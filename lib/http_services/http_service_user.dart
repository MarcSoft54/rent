import 'package:dio/dio.dart';
final dio = Dio();


Future<Map<String, dynamic>?> httpGetAllUser()async{
  try{
    Response response = await dio.get("http://localhost:9001/api/users");
    if(response.statusCode == 200){
      return response.data;
    }
  }catch(e){
    print(e);
  }
  return null;
}

Future<Map<String, dynamic>?> httpGetUser(var id) async{
  try{
    Response response = await dio.get("http://localhost:9001/api/users", data: id);
    if(response.statusCode == 200){
      return response.data;
    }
  }catch(e){
    print(e);
  }
  return null;
}
