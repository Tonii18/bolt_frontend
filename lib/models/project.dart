class Project {

  final String? id;
  final String name;
  final String description;
  final DateTime creationDate;

  Project({this.id, required this.name, required this.description, required this.creationDate});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'creationDate': creationDate.toIso8601String(),
    };
  }
  
}