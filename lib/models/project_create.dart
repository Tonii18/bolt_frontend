class ProjectCreate {

  final String? id;
  final String name;
  final String description;
  final DateTime creationDate;

  ProjectCreate({
    this.id,
    required this.name,
    required this.description,
    required this.creationDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'creationDate': creationDate.toIso8601String(),
    };
  }

  factory ProjectCreate.fromJson(Map<String, dynamic> json) {
    return ProjectCreate(
      id: json['id']?.toString(),
      name: json['name'],
      description: json['description'],
      creationDate: DateTime.parse(json['creationDate']),
    );
  }
}
