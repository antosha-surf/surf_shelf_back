import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:surf_shelf/common_shelf/http_request_handler.dart';
import 'package:surf_shelf/services/todos_service/data/data.dart';
import 'package:surf_shelf/services/todos_service/domain/domain.dart';
import 'package:surf_shelf/services/todos_service/todos_service.dart';
import 'package:uuid/uuid.dart';

class CreateTodoHandler extends ServiceHandler<TodosService> {
  CreateTodoHandler(super.service);

  @override
  Future<Response> handle(Request request) async {
    // Simulate slow response.
    await Future.delayed(const Duration(seconds: 2));

    final createTodoDto = CreateTodoDto.fromJson(
      jsonDecode(
        await request.readAsString(),
      ),
    );

    final id = const Uuid().v4();

    service.addTodo(
      TodoItem(
        id: id,
        title: createTodoDto.title,
        description: createTodoDto.description,
        isCompleted: false,
      ),
    );

    return Response.ok(id);
  }
}
