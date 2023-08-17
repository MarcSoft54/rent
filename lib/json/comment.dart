class Comment{
  var id;
  String content;
  var createBy;
  var createAt;

  Comment({
    required this.id,
    required this.content,
    required this.createBy,
    required this.createAt
});

  factory Comment.fromJson(Map<String, dynamic> json) =>
    Comment(
      id: json["id"],
      content: json["content"],
      createBy: json["createBy"],
      createAt: json["createAt"]
    ) ;

  Map<String, dynamic> toJson()=>{
    "content": content
  };

}