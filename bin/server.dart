import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

// Configure routes.
final _router = Router()
  ..get('/', _rootHandler)
  ..get('/echo/<message>', _echoHandler);

Response _rootHandler(Request req) {
  return Response.ok('Hello, Wodadefsegjrld!\n');
}

Response _echoHandler(Request request) {
  final message = request.params['message'];
  return Response.ok('$message\n');
}

void main(List<String> args) async {
  final handler = Pipeline().addMiddleware(logRequests()).addHandler(_router);
  var env = Platform.environment;

  var port = env.entries.firstWhere((element) => element.key == 'PORT',
      orElse: () => MapEntry('PORT', '8080'));
  final server = await serve(logRequests().addHandler(handler), '0.0.0.0', int.parse(port.value));
  print('Server listening on port ${server.port}');
}
