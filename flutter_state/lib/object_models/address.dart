import 'package:flutter_state/object_models/geo.dart';

class Address{
  String street;
  String suite;
  String city;
  String zipcode;
  Geo geo;

  Address(this.street,this.suite,this.city,this.zipcode,this.geo);

  Address.fromObject(dynamic o){
    this.street = o["street"].toString();
    this.suite = o["suite"].toString();
    this.city = o["city"].toString();
    this.zipcode = o["zipcode"].toString();
    this.geo = Geo.fromObject(o["geo"]);
  }

}