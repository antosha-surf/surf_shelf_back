import 'dart:async';

import 'package:shelf_router/shelf_router.dart';

export 'todos_service/todos_service.dart';

abstract class Service {
  FutureOr<void> init() {}

  FutureOr<void> dispose() {}
}

abstract class RoutedService extends Service {
  void attachToRouter(Router router);
}
