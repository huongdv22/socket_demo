enum OTP_TYPE {
  NO_OTP,
  SMS_EMAIL_OTP,
  MATRIX_OTP,
  MANUAL_OTP,
  STATIC_OTP,
  SMART_OTP,
}

extension OtpType on OTP_TYPE {
  static const types = {
    OTP_TYPE.NO_OTP: '0',
    OTP_TYPE.SMS_EMAIL_OTP: '1',
    OTP_TYPE.MATRIX_OTP: '2',
    OTP_TYPE.MANUAL_OTP: '3',
    OTP_TYPE.STATIC_OTP: '4',
    OTP_TYPE.SMART_OTP: '5',
  };

  String? get type => types[this];
}
