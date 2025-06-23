import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:surf_shelf/common_shelf/http_request_handler.dart';
import 'package:surf_shelf/services/services.dart';

class ReadTodosHandler extends ServiceHandler<TodosService> {
  ReadTodosHandler(super.service);

  @override
  Future<Response> handle(Request request) async {
    return Response.ok(
      jsonEncode(
        service.todos.map((e) => e.toDto()).toList(),
      ),
    );
  }
}

enum TodoType { all, active, completed }
