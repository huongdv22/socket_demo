import 'dart:async';

class RequestedMessage {
  late Completer completer;
  String? data;

  RequestedMessage(
    this.completer, {
    this.data,
  });
}
