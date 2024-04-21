class User {
  User({
    required this.message,
    required this.user,
  });

  final String? message;
  final UserClass? user;

  factory User.fromJson(Map<String, dynamic> json){
    return User(
      message: json["message"],
      user: json["user"] == null ? null : UserClass.fromJson(json["user"]),
    );
  }

}

class UserClass {
  UserClass({
    required this.id,
    required this.username,
    required this.email,
    required this.phone,
    required this.password,
    required this.v,
  });

  final String? id;
  final String? username;
  final String? email;
  final int? phone;
  final String? password;
  final int? v;

  factory UserClass.fromJson(Map<String, dynamic> json){
    return UserClass(
      id: json["_id"],
      username: json["username"],
      email: json["email"],
      phone: json["phone"],
      password: json["password"],
      v: json["__v"],
    );
  }

}
