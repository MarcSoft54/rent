
import 'package:dio/dio.dart';

class MessageService{
  Dio dio = Dio();

  getMessage(var userId) async {
    try{
      Response response = await dio.get("http://localhost:9001/api/messages/$userId");
      if(response.statusCode == 200){
        return response.data;
      }
    }catch(e){
      return e;
    }
  }

}