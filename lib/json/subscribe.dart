class Subscribe{
  var id;
  var createAt;
  var numberSubscribe;
  Map<String, dynamic> user;

  Subscribe({
    required this.id,
    required this.createAt,
    required this.numberSubscribe,
    required this.user
});

  factory Subscribe.fromJson(Map<String, dynamic> json){
    return Subscribe(
      id: json["id"],
      createAt: json["createAt"],
      numberSubscribe: json["numberSubscribe"],
      user: json["user"]
    );
  }

  Map<String, dynamic> toJson() =>{
    "id": id,
    "numberSubscribe":numberSubscribe
  };


}
