class Comment{
  int postId;
  int id;
  String name;
  String email;
  String body;

  Comment(this.postId,this.id,this.name,this.email,this.body);

  Comment.fromObject(dynamic o){
    this.postId = int.parse(o["postId"].toString());
    this.id = int.parse(o["id"].toString());
    this.name = o["name"].toString();
    this.email = o["email"].toString();
    this.body = o["body"].toString();
  }
  
}