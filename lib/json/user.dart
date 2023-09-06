class User{

  var id;
  String username = '';
  String userPicture = '';
  String email = '';
  String sex = '';
  int phoneNumber = 0;
  String country = '';
  String password='';

  User({required this.id,
    required this.username,
    required this.userPicture,
    required this.email,
    required this.sex,
    required this.country,
    required this.phoneNumber});

  factory User.fromJson(Map<String, dynamic> json){
    return User(
        id: json["id"],
        username: json["userName"],
        userPicture: json["userPicture"],
        email: json["email"],
        sex: json["sex"],
        phoneNumber: json["phoneNumber"],
        country: json["country"]
    );
  }


}


class UserDto{
  String username = '';
  String userPicture = '';
  String email = '';
  String sex = '';
  int phoneNumber = 0;
  String country = '';
  String password='';

  UserDto(this.username, this.userPicture , this.email,this.password, this.sex, this.phoneNumber,
      this.country);

  Map<String, dynamic> toJson() =>
      {
        "userName": username,
        "userPicture": userPicture,
        "email": email,
        "passWord": password,
        "sex": sex,
        "phoneNumber": phoneNumber,
        "country": country
      };
}