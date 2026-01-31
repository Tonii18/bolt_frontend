class Project {

  final String name;
  final String description;
  final DateTime creationDate;

  Project({required this.name, required this.description, required this.creationDate});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'creationDate': creationDate.toIso8601String(),
    };
  }
  
}