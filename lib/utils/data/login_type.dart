enum LOGIN_TYPE {
  P, E, I, A, L, F, G, APL, O
}
extension LoginType on LOGIN_TYPE {
  static const types = {
    LOGIN_TYPE.P: 'phone',
    LOGIN_TYPE.E: 'email',
    LOGIN_TYPE.I: 'Identity',
    LOGIN_TYPE.A: 'Account Trading',
    LOGIN_TYPE.L: 'LoginID',
    LOGIN_TYPE.F: 'FaceBook',
    LOGIN_TYPE.G: 'Gmail',
    LOGIN_TYPE.APL: 'Apple',
    LOGIN_TYPE.O: 'Other',
  };

  String? get type => types[this];
}