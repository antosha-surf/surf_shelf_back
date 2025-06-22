import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:surf_shelf/common_shelf/http_request_handler.dart';
import 'package:surf_shelf/services/services.dart';

class ReadTodosHandler extends ServiceHandler<TodosService> {
  ReadTodosHandler(super.service);

  @override
  Future<Response> handle(Request request) async {
    // Simulate slow response.
    await Future.delayed(const Duration(seconds: 2));

    final typeParam = request.url.queryParameters['type'];

    final type = TodoType.values.firstWhere(
      (e) => e.name == typeParam,
      orElse: () => TodoType.all,
    );

    final todos = switch (type) {
      TodoType.all => service.todos,
      TodoType.active => service.todos.where((e) => !e.isCompleted).toList(),
      TodoType.completed => service.todos.where((e) => e.isCompleted).toList(),
    };

    return Response.ok(
      jsonEncode(
        todos.map((e) => e.toDto()).toList(),
      ),
    );
  }
}

enum TodoType { all, active, completed }
