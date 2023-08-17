class Ranking{
  Map<String, dynamic> id;
  var likes;
  var dislike;

  Ranking({required this.id,
  required this.likes,
  required this.dislike});

  factory Ranking.fromJson(Map<String, dynamic> json){
    return Ranking(
      id: json["id"],
      likes: json["likes"],
      dislike: json["dislike"]
    );
  }

  Map<String, dynamic> toJson()=>{
    "likes": likes,
    "dislike": dislike
  };

}
