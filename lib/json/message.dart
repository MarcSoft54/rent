class Message{
  var id;
  String content;
  var createAt;
  var createBy;
  var createTo;

  Message({
    required this.id,
    required this.content,
    required this.createAt,
    required this.createBy,
    required this.createTo
  });

  factory Message.fromJson(Map<String, dynamic> json){
    return Message(
        id: json["id"],
        content: json["content"],
        createAt: json["createAt"],
        createBy: json["createBy"],
        createTo: json["createTo"]
    );
  }
}

class MessageDto{
  String content;
  var createTo;
  MessageDto(this.content, this.createTo);

  Map<String, dynamic> toJson()=>{
    "content": content,
    "createTo": createTo
  };
}
