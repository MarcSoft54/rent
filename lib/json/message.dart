class Message{
  var id;
  String content;
  var createAt;
  var createBy;

  Message({
    required this.id,
    required this.content,
    required this.createAt,
    required this.createBy
  });

  factory Message.fromJson(Map<String, dynamic> json){
    return Message(
      id: json["id"],
      content: json["content"],
      createAt: json["createAt"],
      createBy: json["createBy"]
    );
  }

  Map<String, dynamic> toJson()=>{
    "content": content
  };

}
