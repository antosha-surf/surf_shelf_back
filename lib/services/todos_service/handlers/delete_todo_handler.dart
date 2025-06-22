import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:surf_shelf/common_shelf/http_request_handler.dart';
import 'package:surf_shelf/services/todos_service/todos_service.dart';

class DeleteTodoHandler extends ServiceHandler<TodosService> {
  DeleteTodoHandler(super.service);

  @override
  Future<Response> handle(Request request) async {
    final todoId = request.params['todoId']!;

    final didDelete = service.removeTodoById(todoId);

    if (!didDelete) {
      return Response.notFound('Todo not found');
    }

    return Response.ok(null);
  }
}
