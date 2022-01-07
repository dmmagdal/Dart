import 'dart:io';

import 'package:args/args.dart';
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart' as io;

// For Google Cloud Run, set _hostname to '0.0.0.0'.
const _hostname = 'localhost';

void main(List<String> args) async {
  var parser = ArgParser()..addOption('port', abbr: 'p');
  var result = parser.parse(args);

  // For Google Cloud Run, we respect the PORT environment variable.
  var portStr = result['port'] ?? Platform.environment['PORT'] ?? '8888';
  var port = int.tryParse(portStr);

  if (port == null) {
    stdout.writeln('Could not parse port value "$portStr" into a number.');
    // 64: command line usage error.
    exitCode = 64;
    return;
  }

  var handler = const shelf.Pipeline()
    .addMiddleware(shelf.logRequests())
    .addHandler(_echoRequest);

  var server = await io.serve(handler, _hostname, port);
  print('Serving at http://${server.address.host}:${server.port}');
}

// Modify boilerplate _echoRequest response function to serve index.html.
/*
shelf.Response _echoRequest(shelf.Request request) =>
  shelf.Response.ok('Request for "${request.url}"');
*/
Future<shelf.Response> _echoRequest(shelf.Request request)  async {
  // Read index.html file as a string and return it. Be sure to alter the header
  // such that the content-type is html (content type is plain-text by default).
  final result = await File('index.html').readAsString();
  return shelf.Response.ok(result, headers: {'content-type': 'text/html'});
}
