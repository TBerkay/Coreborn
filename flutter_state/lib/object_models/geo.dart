class Geo{
  String lat;
  String lng;

  Geo(this.lat,this.lng);

  Geo.fromObject(dynamic o){
    this.lat = o["lat"].toString();
    this.lng = o["lng"].toString();
  }
}