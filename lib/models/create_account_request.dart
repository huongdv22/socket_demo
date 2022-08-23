// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:socket_login_demo/models/data_request.dart';

class CreateAccoutRequest extends DataRequest {
  final String command;
  final String type;
  final String phoneOrEmail;
  final String? deviceUUID;
  final String? appId;

  CreateAccoutRequest({
    required this.command,
    required this.type,
    required this.phoneOrEmail,
    this.deviceUUID,
    this.appId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'command': command,
      'type': type,
      'phoneOrEmail': phoneOrEmail,
      'deviceUUID': deviceUUID,
      'appId': appId,
    };
  }

  List<String> get inVal => toMap().values.map((e) => e?.toString() ?? '').toList();
}
