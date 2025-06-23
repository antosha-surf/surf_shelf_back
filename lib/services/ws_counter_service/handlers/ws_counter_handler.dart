import 'package:surf_shelf/common_shelf/common_shelf.dart';
import 'package:surf_shelf/services/ws_counter_service/ws_counter_service.dart';

class WSCounterHandler extends ServiceHandler<WSCounterService>
    with WSConnectionMixin {
  WSCounterHandler(super.service);

  @override
  Future<void> onNewConnection(WSConnection connection) async {
    // Give the client some time to receive the message.
    await Future.delayed(const Duration(milliseconds: 200));

    connection.send('Hello from WSCounterHandler!');

    // Give the client some time to receive the message.
    await Future.delayed(const Duration(milliseconds: 200));

    service.addConnection(connection);
  }
}
