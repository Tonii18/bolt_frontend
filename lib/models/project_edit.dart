class ProjectEdit {
  final String id;
  final String name;
  final String description;

  ProjectEdit({
    required this.id,
    required this.name,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
    };
  }

  factory ProjectEdit.fromJson(Map<String, dynamic> json) {
    return ProjectEdit(
      id: json['id'].toString(),
      name: json['name'],
      description: json['description'],
    );
  }
}