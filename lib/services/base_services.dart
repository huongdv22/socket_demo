import 'package:socket_io_client/socket_io_client.dart';

var clientSeq = 0;
int getClientSeq() {
  clientSeq++;
  return clientSeq;
}

class BaseServices {
  late Socket socket;

  BaseServices(String path) {
    socket = io(
      'wss://fos.altisss.vn:443',
      {
        'transports': ['websocket'],
        'rejectUnauthorized': false,
        'path': path,
      },
    );

    socket.onConnect((data) {
      print('connect: $data');
    });
    socket.onConnectError((data) {
      print('connect error: $data');
    });
    socket.onReconnectAttempt((data) {
      print('reconnect: $data');
    });
    socket.onDisconnect((data) {
      print('disconnect: $data');
    });
  }

  disconnect() {
    socket.disconnect();
  }
}
