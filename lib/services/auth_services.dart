import 'dart:convert';
import 'dart:developer';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:socket_login_demo/core/app_constants.dart';
import 'package:socket_login_demo/models/account_model.dart';
import 'package:socket_login_demo/models/authentication_request.dart';
import 'package:socket_login_demo/models/create_account_request.dart';
import 'package:socket_login_demo/models/data_request.dart';
import 'package:socket_login_demo/models/user_info.dart';
import 'package:socket_login_demo/services/socket_services.dart';
import 'package:socket_login_demo/utils/data/otp_type.dart';
import 'package:socket_login_demo/utils/data/password_utils.dart';
import 'package:socket_login_demo/utils/helpers/system_utils.dart';

class AuthServices {
  final SocketServices _services;

  AuthServices()
      : _services = SocketServices(),
        _googleSignIn = GoogleSignIn();

  final GoogleSignIn _googleSignIn;

  Future<AccountModel> authenticate(AuthenticateRequest request) async {
    String encryptedPassword = PasswordUtils.encryptString(request.password);
    final res = await _services.sendRequest(
        'FOSxID02',
        'FOSxID02_Login',
        'U',
        ['login', request.username, encryptedPassword, '', '', 'N', ''],
        request);
    final response = jsonDecode(res);

    final String accounts = response[0]['c12'];
    final List<AccountResponse> accountList = [];
    for (final acc in accounts.split('|')) {
      List<String> account = [];
      acc.split(',').forEach((element) => account.add(element));
      accountList.add(AccountResponse.fromList(account));
    }

    final id = response[0]['c1'];
    final sessionId = response[0]['c0'];
    final needChangePassword = (response[0]['messageCode'] == '010010');

    final newRequest = DataRequest.fromJson(<String, dynamic>{
      'headers': {
        'platform': request.headers?.platform,
        'publicip': request.headers?.publicip,
        'accept-language': request.headers?.acceptLanguage,
        'token': {
          'ud': {
            'u': id,
            'sid': sessionId,
          }
        }
      }
    });

    var userInfo;
    try {
      userInfo = await queryUserInfo(newRequest);
      inspect(userInfo);
    } catch (e) {
      print(e);
    }

    final otpType = response[0]['c6'];
    var trustDevice = false;

    if (otpType == OTP_TYPE.SMART_OTP.type && request.deviceUUID != null) {
      try {
        await _services.sendRequest('FOSxID01', 'FOSxID01_OTPManagement', 'I',
            ['check_device', request.deviceUUID], newRequest);
        trustDevice = true;
      } catch (e) {
        print(e);
      }
    }

    var otp = otpType == OTP_TYPE.NO_OTP.type
        ? null
        : {
            'service':
                otpType == OTP_TYPE.SMART_OTP.type ? 'aaa' : AppConst.clusterId,
            'uri': otpType == OTP_TYPE.SMART_OTP.type
                ? '/api/v1/verifySmartOtp'
                : '/api/v1/checkOTP',
          };

    Map<String, dynamic> json = <String, dynamic>{
      'id': id,
      'sessionId': sessionId,
      'otp': otp,
      'otpType': otpType,
      'loginType': response[0]['c11'],
      'otpIndex': response[0]['c14'],
      'otpTimeout': num.parse(response[0]['c15']),
      'accountList': accountList,
      'authenFlag': response[0]['c9'],
      'userInfo': userInfo,
      'tradingDate': response[0]['c16'],
      'systemDate': response[0]['c17'],
      'nextWorkingDate': response[0]['c18'],
      'singleSession': response[0]['c8'],
      'trustDevice': trustDevice,
      'needChangePassword': needChangePassword,
    };
    return AccountModel.fromJson(json);
  }

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

  loginGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        throw 'Vui lòng chọn tài khoản.';
      } else {
        final googleAuth = await googleUser.authentication;
        SystemUtils.debugLog(
            "signUpWithGoogle idToken", googleAuth.idToken ?? '');
        SystemUtils.debugLog(
            "signUpWithGoogle accessToken", googleAuth.accessToken ?? '');
        final request = CreateAccoutRequest(
          command: 'open_auth',
          type: 'email',
          phoneOrEmail: googleUser.email,
          appId: googleAuth.idToken,
        );
        await _socialLogin(request);
      }
    } catch (e) {
      SystemUtils.debugLog('signUpWithGoogle', e.toString());
      rethrow;
    }
  }

  _socialLogin(CreateAccoutRequest request) async {
    final res = await _services.sendRequest(
      'FOSxID01',
      'FOSxID01_Management',
      'I',
      request.inVal,
      request,
    );
    final response = jsonDecode(res);
    inspect(response);
  }

  logout() async {
    _googleSignIn.signOut();
  }
}
