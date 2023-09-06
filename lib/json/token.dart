
class Token{
  var id;

  Token({required this.id});
  factory Token.fromJson(Map<String, dynamic> json){
    return Token(id: json["id"]);
  }

}
