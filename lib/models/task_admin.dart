class TaskAdmin {
  final String title;
  final String description;

  TaskAdmin({required this.title, required this.description});

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
    };
  }

  factory TaskAdmin.fromJson(Map<String, dynamic> json) {
    return TaskAdmin(
      title: json['title'],
      description: json['description'],
    );
  }
}