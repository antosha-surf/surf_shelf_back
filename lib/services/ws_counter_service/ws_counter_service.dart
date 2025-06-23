import 'dart:async';

import 'package:shelf_router/shelf_router.dart';
import 'package:surf_shelf/common_shelf/common_shelf.dart';
import 'package:surf_shelf/services/services.dart';
import 'package:surf_shelf/services/ws_counter_service/handlers/handlers.dart';

class WSCounterService extends RoutedService {
  final _activeConnections = <WSConnection>[];

  late int _initialTimestamp;
  Timer? _timer;

  @override
  void init() {
    _initialTimestamp = DateTime.now().millisecondsSinceEpoch;

    _timer = Timer.periodic(const Duration(milliseconds: 250), (timer) {
      final delta = DateTime.now().millisecondsSinceEpoch - _initialTimestamp;

      for (var connection in _activeConnections) {
        connection.send('This service has been running for $delta ms');
      }
    });
  }

  void addConnection(WSConnection connection) {
    _activeConnections.add(connection);
    connection.done.whenComplete(
      () => _activeConnections.remove(connection),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _activeConnections.map((e) => e.close());
  }

  @override
  void attachToRouter(Router router) {
    router.get('/ws_counter', WSCounterHandler(this).call);
  }
}
