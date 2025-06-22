class CreateTodoDto {
  final String title;
  final String description;

  const CreateTodoDto({
    required this.title,
    required this.description,
  });

  CreateTodoDto.fromJson(Map<String, dynamic> json)
    : title = json['title'] as String,
      description = json['description'] as String;

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
    };
  }
}
