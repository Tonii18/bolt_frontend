class TaskAdmin {
  final String id;
  final String title;
  final String description;
  final String state;

  TaskAdmin({required this.id, required this.title, required this.description, required this.state});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'state': state,
    };
  }

  factory TaskAdmin.fromJson(Map<String, dynamic> json) {
    return TaskAdmin(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      state: json['state'],
    );
  }
}