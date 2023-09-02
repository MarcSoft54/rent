
import 'package:dio/dio.dart';
import 'package:rentalapp/json/article.dart';

class ArticleService{

  Dio dio = Dio();

  var listArticle;

  late Article article;

  putArticle(var id, var userId, ArticleDto articleDto) async{
    try{
      Response response = await dio.put("http://localhost:9001/api/articles/$id?userId=$userId", data: articleDto.toJson());
      if(response.statusCode == 200){
        return response.data;
      }
    }catch(e){
      return e;
    }
  }

  delArticle(var id)async{
    try{
      Response response = await dio.delete("http://localhost:9001/api/articles/$id");
      if(response.statusCode == 200){
        return response.data;
      }
    }catch(e){
      return e;
    }
  }

  getAllArticle() async{
    try{
      Response response = await dio.get("http://localhost:9001/api/articles");
      if(response.statusCode == 200){
        var list = response.data;
        for (var i =0; i<response.data.lenght; i++){
          article = list[i];
          listArticle.add(Article.fromJson(article as Map<String, dynamic>));
        }
        return listArticle;
      }
    }catch(e){
      return e;
    }
  }

  postArticle(ArticleDto articleDto, var userId) async{
    try{
      Response response = await dio.post("http://localhost:9001/api/articles/$userId", data: articleDto.toJson());
      if(response.statusCode == 200){
        return response.data;
      }
    }catch(e){
      return e;
    }
  }

  searchArticle({String name = "", double price = 300}) async{
    try{
      Response response = await dio.get("http://localhost:9001/api/articles?kw=$name&price=$price");
      if(response.statusCode == 200){
        return response.data;
      }
    }catch (e){
      return e;
    }
  }

}