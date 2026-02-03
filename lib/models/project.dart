class Project {
  final String id;
  final String name;
  final String description;
  final DateTime creationDate;

  Project({required this.id, required this.name, required this.description, required this.creationDate});

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'].toString(),
      name: json['name'],
      description: json['description'],
      creationDate: DateTime.parse(json['creationDate']),
    );
  }
}
