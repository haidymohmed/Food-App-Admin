import 'dart:ui';

class UserDetails{
  late String email ;
  String? pass , name , phone , id ;
  UserDetails({this.name, this.phone, this.id, required this.email, this.pass});
  toJson(){
    return {
      "name" :  name,
      "phone" : phone,
      "id" : id,
      "email" : email,
    };
  }
  fromJason(data){
    name = data["name"];
    phone = data["phone"];
    email = data["email"];
    id = data["id"];
  }
}