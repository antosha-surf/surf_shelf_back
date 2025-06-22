class TodoItemDto {
  final String? id;
  final String title;
  final String description;
  final bool isCompleted;

  const TodoItemDto({
    required this.id,
    required this.title,
    required this.description,
    required this.isCompleted,
  });

  TodoItemDto.fromJson(Map<String, dynamic> json)
    : id = json['id'] as String?,
      title = json['title'] as String,
      description = json['description'] as String,
      isCompleted = json['is_completed'] as bool;

  Map<String, dynamic> toJson() {
    return {
      'id': id!,
      'title': title,
      'description': description,
      'is_completed': isCompleted,
    };
  }
}
