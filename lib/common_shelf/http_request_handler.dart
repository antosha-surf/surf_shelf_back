import 'package:shelf/shelf.dart';
import 'package:surf_shelf/common/common.dart';

import '../services/services.dart' show RoutedService;

abstract class HttpRequestHandler {
  late final Handler _result;
  final List<Middleware>? _middlewares;

  HttpRequestHandler({
    List<Middleware>? middlewares,
  }) : _middlewares = middlewares {
    var pipeline = Pipeline();

    if (_middlewares != null) {
      for (final middleware in _middlewares) {
        pipeline = pipeline.addMiddleware(middleware);
      }
    }

    _result = pipeline.addHandler(_handle);
  }

  Future<Response> handle(Request request);

  Future<Response> _handle(Request request) async {
    try {
      // todo logging everywhere, including catch clauses
      return await handle(request);
    } on Failure catch (f) {
      return f.toResponse();
    } on HijackException catch (_) {
      rethrow;
    } catch (e) {
      final onExceptionResult = await onException(e);
      if (onExceptionResult != null) return onExceptionResult;
      return Failure().toResponse();
    }
  }

  Future<Response?> onException(Object e) => Future.value(null);

  Future<Response> call(Request request) async {
    return _result(request);
  }
}

abstract class ServiceHandler<ServiceSubtype extends RoutedService>
    extends HttpRequestHandler {
  final ServiceSubtype service;

  ServiceHandler(this.service);
}
