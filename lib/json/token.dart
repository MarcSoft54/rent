
class Token{
  final String username;
  final String accessToken;

  Token({required this.username, required this.accessToken});
  factory Token.fromJson(Map<String, dynamic> json){
    return Token(
      username: json["username"],
      accessToken: json["accessToken"]
    );
  }

}
