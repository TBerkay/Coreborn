class Post{
  int userId;
  int id;
  String title;
  String body;

  Post(this.userId,this.id,this.title,this.body);

  Post.fromObject(dynamic o){
    this.userId = int.parse(o["userId"].toString());
    this.id = int.parse(o["id"].toString());
    this.title = o["title"].toString();
    this.body = o["body"].toString();
  }

}