class UserProject {
  final String id;
  final String name;
  final String email;

  UserProject({required this.id, required this.name, required this.email});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }

  factory UserProject.fromJson(Map<String, dynamic> json) {
    return UserProject(
      id: json['id'].toString(),
      name: json['name'],
      email: json['email'],
    );
  }
}