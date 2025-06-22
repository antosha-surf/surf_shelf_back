import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:surf_shelf/common_shelf/http_request_handler.dart';
import 'package:surf_shelf/services/todos_service/data/data.dart';
import 'package:surf_shelf/services/todos_service/domain/domain.dart';
import 'package:surf_shelf/services/todos_service/todos_service.dart';

class UpdateTodoHandler extends ServiceHandler<TodosService> {
  UpdateTodoHandler(super.service);

  @override
  Future<Response> handle(Request request) async {
    // Simulate slow response.
    await Future.delayed(const Duration(seconds: 2));

    final todoId = request.params['todoId']!;

    final todoIndex = service.todos.indexWhere((e) => e.id == todoId);

    if (todoIndex == -1) {
      return Response.notFound('Todo not found');
    }

    final todo = TodoItem.fromDto(
      TodoItemDto.fromJson(
        jsonDecode(await request.readAsString()),
      ),
    );

    service.updateTodo(todoId, todo.copyWith(id: todoId));

    return Response.ok(null);
  }
}
