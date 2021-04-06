class Company{
  String name;
  String catchPhrase;
  String bs;

  Company(this.name,this.catchPhrase,this.bs);

  Company.fromObject(dynamic o){
    this.name=o["name"].toString();
    this.catchPhrase=o["catchPhrase"].toString();
    this.bs=o["bs"].toString();
  }

}