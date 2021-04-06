import 'package:flutter_state/object_models/address.dart';
import 'package:flutter_state/object_models/company.dart';

class User{
  int id;
  String name;
  String username;
  String email;
  Address address;
  String phone;
  String website;
  Company company;

  User(this.id,this.name,this.username,this.email,this.address,this.phone,this.website,this.company);

  User.fromObject(dynamic o){
    this.id=int.parse(o["id"].toString());
    this.name = o["name"].toString();
    this.username = o["username"].toString();
    this.email = o["email"].toString();
    this.address=Address.fromObject(o["address"]);
    this.phone = o["phone"].toString();
    this.website = o["website"].toString();
    this.company = Company.fromObject(o["company"]);
  }

}