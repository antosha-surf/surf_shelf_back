import 'package:shelf/shelf.dart';

/// {@template failure.class}
/// The failure processed in the business logic layer of the application.
///
/// It is mostly returned from repository methods.
/// {@endtemplate}
class Failure<T extends Object?> implements Exception {
  /// Original error.
  final T? original;

  /// Stack trace.
  final StackTrace? trace;

  /// {@macro failure.class}
  const Failure({this.original, this.trace});

  Response toResponse() {
    return Response.internalServerError(body: 'Something went wrong');
  }
}
