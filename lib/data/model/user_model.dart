class UserModel {
  String id;
  String name;
  String email;
  int createdAt;

  UserModel(
      {required this.id,
      required this.name,
      required this.email,
      required this.createdAt});

  UserModel.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          name: json['name'],
          email: json['email'],
          createdAt: json['created_at'],
        );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'created_at': createdAt,
    };
  }
}
