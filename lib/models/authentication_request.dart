import 'data_request.dart';

class AuthenticateRequest extends DataRequest {
  late String username;
  late String password;
  String? deviceUUID;
  String? appId;
  late String autoFlag;
  String? deviceLoginInfo;

  AuthenticateRequest.fromJson(Map<String, dynamic> json) {
    super.fromJson(json);

    username = json['username'];
    password = json['password'];
    autoFlag = json['autoFlag'] ?? 'N';

    deviceUUID = json['deviceUUID'];
    appId = json['appId'];
    deviceLoginInfo = json['deviceLoginInfo'];
  }
}

class CheckOTPRequest extends DataRequest {
  late String otp;

  CheckOTPRequest.fromJson(Map<String, dynamic> json) {
    super.fromJson(json);
    otp = json['otp'];
  }
}

class LogoutRequest extends DataRequest {
  late String loginId;
  String? deviceUUID;

  LogoutRequest.fromJson(Map<String, dynamic> json) {
    super.fromJson(json);

    loginId = json['loginId'];
    deviceUUID = json['deviceUUID'];
  }
}
