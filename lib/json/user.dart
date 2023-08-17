class User{

  var id;
  String username = '';
  String surname = '';
  String email = '';
  String sex = '';
  int phoneNumber = 0;
  String country = '';
  String password='';

  User({required this.id,
    required this.username,
    required this.surname,
    required this.email,
    required this.sex,
    required this.country,
    required this.phoneNumber});

  factory User.fromJson(Map<String, dynamic> json){
    return User(
        id: json["id"],
        username: json["userName"],
        surname: json["surName"],
        email: json["email"],
        sex: json["sex"],
        phoneNumber: json["phoneNumber"],
        country: json["country"]
    );
  }


}


class UserDto{
  String username = '';
  String surname = '';
  String email = '';
  String sex = '';
  int phoneNumber = 0;
  String country = '';
  String password='';

  UserDto(this.username, this.surname, this.email,this.password, this.sex, this.phoneNumber,
      this.country);

  Map<String, dynamic> toJon() =>
      {
        "userName": username,
        "surName": surname,
        "email": email,
        "passWord": password,
        "sex": sex,
        "phoneNumber": phoneNumber,
        "country": country
      };
}