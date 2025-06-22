import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:surf_shelf/services/services.dart';

void main(List<String> arguments) async {
  final router = Router();

  final services = <Service>[
    TodosService(),
    //
    // ... add your services here ...
    //
  ];

  for (final service in services) {
    await service.init();
    if (service is RoutedService) {
      service.attachToRouter(router);
    }
  }

  final server = await shelf_io.serve(
    Pipeline().addHandler(router.call),
    '0.0.0.0',
    42069,
  );

  // Enable content compression
  server.autoCompress = true;

  print('Serving http://${server.address.host}:${server.port}');
}
