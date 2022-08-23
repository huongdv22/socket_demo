

import 'package:socket_login_demo/models/user_info.dart';
import 'package:socket_login_demo/utils/data/account_type.dart';
import 'package:socket_login_demo/utils/data/enum_utils.dart';
import 'package:socket_login_demo/utils/data/login_type.dart';
import 'package:socket_login_demo/utils/data/otp_type.dart';

import 'data_request.dart';

class AccountModel {
  late String id;
  late String sessionId;
  late Otp otp;
  String? otpType;
  String? otpIndex;
  LOGIN_TYPE? loginType;
  int? otpTimeout;
  late List<AccountResponse> accountList;
  late UserInfo userInfo;
  late String authenFlag;
  late String tradingDate;
  late String systemDate;
  late String nextWorkingDate;
  late String singleSession;
  late bool trustDevice;
  late bool needChangePassword;

  AccountModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sessionId = json['sessionId'];
    otp = Otp.fromJson(json['otp']);
    otpType = json['otpType']; 
    otpIndex = json['otpIndex']; 
    loginType = EnumUtils.enumFromString(LOGIN_TYPE.values, json['loginType']); 
    otpTimeout = json['otpTimeout']; 
    accountList = json['accountList'];  
    userInfo = (json['userInfo'].runtimeType == UserInfo) ? json['userInfo'] : null;   
    authenFlag = json['authenFlag'];
    tradingDate = json['tradingDate'];   
    systemDate = json['systemDate'];     
    nextWorkingDate = json['nextWorkingDate'];   
    singleSession = json['singleSession'];   
    trustDevice = json['trustDevice'];   
    needChangePassword = json['needChangePassword'];   
  }
}

class AccountResponse {
  late String accountNumber;
  late String subNumber;
  late String accountName;
  late ACCOUNT_TYPE accountType;
  late bool owner;
  late String secCode;
  late String productCode;

  AccountResponse.fromJson(Map<String, dynamic> json) {
    accountNumber = json['accountNumber'];
    subNumber = json['subNumber'];
    accountName = json['accountName'];
    accountType = ACCOUNT_TYPE.values.firstWhere((e) => e.type == int.parse(json['accountType']));
    owner = json['owner'];
    secCode = json['secCode'];
    productCode = json['productCode'];
  }

  AccountResponse.fromList(List<String> list) {
    if (list.length != 7) return;
    accountNumber = list[0];
    subNumber = list[1];
    accountName = list[2];
    accountType = ACCOUNT_TYPE.values.firstWhere((e) => e.type == int.parse(list[3])); // Gán theo giá trị
    owner = list[4] == 'Y' ? true : false;
    secCode = list[5];
    productCode = list[6];
  }
}

class LogoutResponse {
  late String loginId;
  String? deviceUUID;

  LogoutResponse.fromJson(Map<String, dynamic> json) {
    loginId = json['loginId'];
    deviceUUID = json['deviceUUID'];
  }
}

class ResendOTPResponse {
  late String id;
  late OTP_TYPE otpType;
  late int otpTimeout;
  late String otpIndex;

  ResendOTPResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    otpType = OTP_TYPE.values.firstWhere((e) => e.type == json['otpType']);
    otpTimeout = json['otpTimeout'];
    otpIndex = json['otpIndex'];
  }
}
