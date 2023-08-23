class Article{
  var id;
  String typeArticle = '';
  String country = '';
  double priceArticle = 0;
  String city = '';
  String mapUrl = '';
  List<String> pictureUrl;
  String videoUrl = '';
  String description = '';
  int room = 0;
  int shower = 0;
  int parking  = 0;
  int kitchen = 0;
  int livingRoom = 0;

  Article({
    required this.id,
    required this.typeArticle,//
    required this.country,
    required this.city,
    required this.mapUrl,
    required this.pictureUrl,//
    required this.videoUrl,//*
    required this.description,//
    required this.room, //
    required this.shower, //
    required this.parking, //
    required this.kitchen, //
    required this.livingRoom //
  });

  factory Article.fromJson(Map<String, dynamic> json){
    return Article(
      id: json["id"],
      typeArticle: json["typeArticle"],
      country: json["country"],
      city: json["city"],
      mapUrl: json["mapUrl"],
      pictureUrl: json["pictureUrl"],
      videoUrl: json["videoUrl"],
      description: json["description"],
      room: json["room"],
      shower: json["shower"],
      parking: json["parking"],
      kitchen: json["kitchen"],
      livingRoom: json["livingRoom"]
    );
  }



}

class ArticleDto{

  String typeArticle = '';
  String country = '';
  double priceArticle = 0;
  String city = '';
  String mapUrl = '';
  List<String> pictureUrl;
  String videoUrl = '';
  String description = '';
  int room = 0;
  int shower = 0;
  int parking  = 0;
  int kitchen = 0;
  int livingRoom = 0;

  ArticleDto(
      this.typeArticle, this.country,
      this.priceArticle, this.city,
      this.mapUrl, this.pictureUrl,
      this.videoUrl, this.description,
      this.room, this.shower, this.parking,
      this.kitchen, this.livingRoom
      );
  Map<String, dynamic> toJson() =>{
    "typeArticle": typeArticle,
    "country": country,
    "priceArticle": priceArticle,
    "city": city,
    "mapUrl": mapUrl,
    "pictureUrl": pictureUrl,
    "videoUrl": videoUrl,
    "description": description,
    "room": room,
    "shower": shower,
    "parking": parking,
    "kitchen": kitchen,
    "livingRoom": livingRoom
  };
}
