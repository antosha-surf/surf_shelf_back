import 'dart:async';

import 'package:shelf/shelf.dart';
import 'package:shelf_web_socket/shelf_web_socket.dart';
import 'package:surf_shelf/common_shelf/common_shelf.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

mixin WSConnectionMixin on HttpRequestHandler {
  late final _handler = webSocketHandler(
    (channel, _) => _onConnection(channel).ignore(),
    pingInterval: const Duration(seconds: 3),
  );

  @override
  Future<Response> handle(Request request) async {
    return _handler(request);
  }

  Future<void> _onConnection(
    WebSocketChannel socketChannel,
  ) async {
    try {
      await socketChannel.ready;
    } on Exception catch (e) {
      return await onFailedToConnectIncomingSocket(e);
    }

    final connection = WSConnection(
      socketChannel: socketChannel,
    );

    return await onNewConnection(connection);
  }

  Future<void> onNewConnection(WSConnection connection);

  Future<void> onFailedToConnectIncomingSocket(Exception e) async {
    // Handle the exception.
  }
}

class WSConnection {
  final WebSocketChannel _channel;

  final _rawStreamController = StreamController<String>.broadcast();

  bool _isClosed = false;

  bool get isClosed => _isClosed;

  Stream<String> get rawStream => _rawStreamController.stream;

  /// This future resolves when the connection is closed.
  Future<void> get done => _rawStreamController.done;
  int? get closeCode => _channel.closeCode;
  String? get closeReason => _channel.closeReason;

  WSConnection({
    required WebSocketChannel socketChannel,
  }) : _channel = socketChannel {
    socketChannel.stream.listen(
      _onRawMessage,
      onError: _onError,
      onDone: _onDone,
    );
  }

  void send(String message) {
    if (_isClosed) return;
    _channel.sink.add(message);
  }

  void close([int? closeCode, String? closeReason]) {
    _channel.sink.close(closeCode, closeReason);
    _isClosed = true;
  }

  void _onRawMessage(dynamic message) {
    if (message is! String) {
      return;
    }

    _rawStreamController.add(message);
  }

  void _onError(dynamic error) {
    _rawStreamController.addError(error);
  }

  void _onDone() {
    _rawStreamController.close();
    _isClosed = true;
  }
}
