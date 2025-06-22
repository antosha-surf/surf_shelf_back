import 'package:surf_shelf/services/todos_service/data/entities/todo_item_dto.dart';

class TodoItem {
  final String id;
  final String title;
  final String description;
  final bool isCompleted;

  const TodoItem({
    required this.id,
    required this.title,
    required this.description,
    required this.isCompleted,
  });

  factory TodoItem.fromDto(TodoItemDto dto) {
    return TodoItem(
      id: dto.id ?? '',
      title: dto.title,
      description: dto.description,
      isCompleted: dto.isCompleted,
    );
  }

  TodoItemDto toDto() {
    return TodoItemDto(
      id: id,
      title: title,
      description: description,
      isCompleted: isCompleted,
    );
  }

  TodoItem copyWith({
    String? id,
    String? title,
    String? description,
    bool? isCompleted,
  }) {
    return TodoItem(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  String toString() {
    return 'TodoItem(id: $id, title: $title, description: $description, isCompleted: $isCompleted)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TodoItem &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, title, description, isCompleted);
}
