import 'dart:convert';

import 'package:socket_login_demo/models/data_request.dart';
import 'package:socket_login_demo/models/user_info.dart';
import 'package:socket_login_demo/services/socket_services.dart';

class CommonServices {
  final SocketServices _services;

  CommonServices() : _services = SocketServices();

  Future<UserInfo> queryUserInfo(DataRequest request) async {
    final res = await _services.sendRequest(
      'FOSqID02',
      'FOSqID02_UserInformation',
      'Q',
      ['info'],
      request,
    );

    final response = jsonDecode(res);

    return UserInfo.fromJson(<String, dynamic>{
      'name': response[0]['c0'],
      'displayName': response[0]['c2'],
      'gender': response[0]['c3'],
      'dob': response[0]['c5'],
      'otpType': response[0]['c32'],
      'phoneNumber': response[0]['c35'],
    });
  }
}
