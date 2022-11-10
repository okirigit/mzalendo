class UserObj {
  //Constructor
  String id = '';
  String name = '';
  String email = '';
  String phone = '';

  UserObj.fromJson(Map json) {
    id = json['_id'];
    name = json['fname'] + " " + json['lname'];
    email = json['email'];
    phone = json['phone'];
  }
}