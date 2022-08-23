enum ACCOUNT_TYPE {
  CASH_ACCOUNT, MARGIN, BOND_ACCOUNT, DERIVATIVES
}
extension AccountType on ACCOUNT_TYPE {
  static const types = {
    ACCOUNT_TYPE.CASH_ACCOUNT: 1,
    ACCOUNT_TYPE.MARGIN: 2,
    ACCOUNT_TYPE.BOND_ACCOUNT: 3,
    ACCOUNT_TYPE.DERIVATIVES: 4,
  };

  int? get type => types[this];
}