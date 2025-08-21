class User {
  final String? id;
  final String name;
  final String email;

  User({this.id, required this.name, required this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"] ?? "0",
      name: json["name"] ?? "",
      email: json["email"] ?? "",
    );
  }
  
  Map<String, dynamic> toJson() => {"id": id, "name": name, "email": email};
}
