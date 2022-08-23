// ignore_for_file: unnecessary_this

import 'dart:convert';

class DataRequest {
  Headers? headers;

  DataRequest({this.headers});

  DataRequest.fromJson(Map<String, dynamic> json) {
    headers =
        json['headers'] != null ? Headers.fromJson(json['headers']) : null;
  }

  void fromJson(Map<String, dynamic> json) {
    headers =
        json['headers'] != null ? Headers.fromJson(json['headers']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (this.headers != null) data['headers'] = this.headers!.toJson();
    return data;
  }
}

class Headers {
  String? lang;
  String? platform;
  String? publicip;
  String? acceptLanguage;
  Token? token;

  Headers({this.lang, this.platform, this.publicip, this.token});

  Headers.fromJson(Map<String, dynamic> json) {
    lang = json['lang'];
    platform = json['platform'];
    publicip = json['publicip'];
    acceptLanguage = json['accept-language'];
    token = json['token'] != null ? Token.fromJson(json['token']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['lang'] = this.lang;
    data['platform'] = this.platform;
    data['publicip'] = this.publicip;
    data['accept-language'] = this.acceptLanguage;
    if (this.token != null) data['token'] = this.token!.toJson();
    return data;
  }
}

class Token {
  List<int>? sgIds;
  List<int>? rIds;
  UserData? ud;
  Otp? otp;
  bool? a;
  String? pl;
  String? loginUUID;
  int? iat;
  int? exp;

  Token(
      {this.sgIds,
      this.rIds,
      this.ud,
      this.otp,
      this.a,
      this.pl,
      this.loginUUID,
      this.iat,
      this.exp});

  Token.fromJson(Map<String, dynamic> json) {
    sgIds = json['sgIds']?.cast<int>();
    rIds = json['rIds']?.cast<int>();
    ud = json['ud'] != null ? UserData.fromJson(json['ud']) : null;
    otp = json['otp'] != null ? Otp.fromJson(json['otp']) : null;
    a = json['a'];
    pl = json['pl'];
    loginUUID = json['loginUUID'];
    iat = json['iat'];
    exp = json['exp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['sgIds'] = this.sgIds;
    data['rIds'] = this.rIds;
    if (this.ud != null) {
      data['ud'] = this.ud!.toJson();
    }
    if (this.otp != null) {
      data['otp'] = this.otp!.toJson();
    }
    data['a'] = this.a;
    data['pl'] = this.pl;
    data['loginUUID'] = this.loginUUID;
    data['iat'] = this.iat;
    data['exp'] = this.exp;
    return data;
  }
}

class UserData {
  String? u;
  String? sid;
  int? i;
  ExtraData? ex;

  UserData({this.u, this.sid, this.i, this.ex});

  UserData.fromJson(Map<String, dynamic> json) {
    u = json['u'];
    sid = json['sid'];
    i = json['i'];
    ex = json['ex'] != null ? ExtraData.fromJson(json['ex']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['u'] = this.u;
    data['sid'] = this.sid;
    data['i'] = this.i;
    if (this.ex != null) {
      data['ex'] = this.ex!.toJson();
    }
    return data;
  }
}

class ExtraData {
  String? id;
  String? br;
  String? mgnDpt;
  String? dpt;
  String? agc;
  List<Map<String, dynamic>>? acc;
  String? lgId;
  String? flg;
  String? tpl;
  String? lvl;
  String? ut;

  ExtraData(
      {this.id,
      this.br,
      this.mgnDpt,
      this.dpt,
      this.agc,
      this.acc,
      this.lgId,
      this.flg,
      this.tpl,
      this.lvl,
      this.ut});

  ExtraData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    br = json['br'];
    mgnDpt = json['mgnDpt'];
    dpt = json['dpt'];
    agc = json['agc'];
    if (json['acc'] != null) {
      json['acc'].forEach((value) {
        acc!.add(jsonDecode(value));
      });
    }
    lgId = json['lgId'];
    flg = json['flg'];
    tpl = json['tpl'];
    lvl = json['lvl'];
    ut = json['ut'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = this.id;
    data['br'] = this.br;
    data['mgnDpt'] = this.mgnDpt;
    data['dpt'] = this.dpt;
    data['agc'] = this.agc;
    data['acc'] = this.acc;
    data['lgId'] = this.lgId;
    data['flg'] = this.flg;
    data['tpl'] = this.tpl;
    data['lvl'] = this.lvl;
    data['ut'] = this.ut;
    return data;
  }
}

class Otp {
  String? service;
  String? uri;
  String? otpType;
  int? exp;

  Otp({this.service, this.uri, this.otpType, this.exp});

  Otp.fromJson(Map<String, dynamic> json) {
    service = json['service'];
    uri = json['uri'];
    otpType = json['otpType'];
    exp = json['exp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['service'] = this.service;
    data['uri'] = this.uri;
    data['otpType'] = this.otpType;
    data['exp'] = this.exp;
    return data;
  }
}
