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

  
  Map<String, dynamic> toJson() {
    final data = {
      "name": name,
      "email": email,
    };

    if (id != null) {
      data["id"] = id!;
    }

    return data;
  }
}
