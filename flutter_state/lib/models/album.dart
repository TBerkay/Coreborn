class Album{
  int userId;
  int id;
  String title;

  Album(this.userId,this.id,this.title);

  Album.fromObject(dynamic o){
    this.userId = int.parse(o["userId"].toString());
    this.id = int.parse(o["id"].toString());
    this.title = o["title"].toString();
  }
  
}