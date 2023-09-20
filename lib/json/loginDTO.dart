
class LoginDto{
  String email;
  String password;

  LoginDto(this.email, this.password);

  Map<String, dynamic> toJson() =>
      {
        "email":email,
        "password":password
      };
}