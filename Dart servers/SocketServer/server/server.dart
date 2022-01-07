import 'dart:io';
import 'dart:typed_data';


void main() async {
    // Bind the socket server to an address and port.
    final server = await ServerSocket.bind(InternetAddress.anyIPv4, 4567);

    // Listen for the client connections to the server.
    server.listen((client) {
      handleConnection(client);
    });
}


void handleConnection(Socket client) {
  print('Connection from'
    ' ${client.remoteAddress.address}:${client.remotePort}');

  // Listen for events from the client.
  client.listen(
    // Handle data from the client.
    (Uint8List data) async {
      await Future.delayed(Duration(seconds: 1));
      final message = String.fromCharCodes(data);
      if (message == "Knock, knock.") {
        client.write("Who's there?");
      } else if (message.length < 10) {
        client.write('${message} who?');
      } else {
        client.write("Very funny.");
        client.close();
      }
    },

    // Handle errors.
    onError: (error) {
      print(error);
      client.close();
    },

    // Handle the client closing the connection.
    onDone: () {
      print('Client left');
      client.close();
    },
  );
}
