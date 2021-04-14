class UserSerializer {
  User user;

  UserSerializer({this.user});

  UserSerializer.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}

class User {
  String sId;
  String name;
  String password;
  String domiciality;
  String age;
  int iV;

  User(
      {this.sId,
      this.name,
      this.password,
      this.domiciality,
      this.age,
      this.iV});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    password = json['password'];
    domiciality = json['domiciality'];
    age = json['age'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['password'] = this.password;
    data['domiciality'] = this.domiciality;
    data['age'] = this.age;
    data['__v'] = this.iV;
    return data;
  }
}
