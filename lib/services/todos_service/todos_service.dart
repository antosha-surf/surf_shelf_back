import 'package:collection/collection.dart';
import 'package:shelf_router/shelf_router.dart';

import 'package:surf_shelf/services/services.dart' show RoutedService;
import 'package:surf_shelf/services/todos_service/domain/domain.dart';
import 'package:surf_shelf/services/todos_service/handlers/handlers.dart';

export 'handlers/handlers.dart';

class TodosService extends RoutedService {
  final _todos = <TodoItem>[];

  /// READ.
  List<TodoItem> get todos => UnmodifiableListView(_todos);

  /// CREATE.
  void addTodo(TodoItem todo) {
    _todos.add(todo);
  }

  /// DELETE.
  bool removeTodoById(String id) {
    final todo = _todos.firstWhereOrNull((e) => e.id == id);
    if (todo != null) {
      _todos.remove(todo);
      return true;
    }

    return false;
  }

  /// UPDATE.
  void updateTodo(String id, TodoItem todo) {
    assert(todo.id == id);
    final index = _todos.indexWhere((e) => e.id == id);
    _todos[index] = todo;
  }

  @override
  void attachToRouter(Router router) {
    router.post('/todos', CreateTodoHandler(this).call);
    router.get('/todos', ReadTodosHandler(this).call);
    router.post('/todos/<todoId>', UpdateTodoHandler(this).call);
    router.delete('/todos/<todoId>', DeleteTodoHandler(this).call);
  }
}
