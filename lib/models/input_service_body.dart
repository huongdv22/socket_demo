class InputServiceBody {
  final dynamic cltVersion;
  final dynamic clientSeq;
  final dynamic secCode;
  final dynamic workerName;
  final dynamic serviceName;
  final dynamic timeOut;
  final dynamic mwLoginID;
  final dynamic mwLoginPswd;
  final dynamic appLoginID;
  final dynamic appLoginPswd;
  final dynamic clientSentTime;
  final dynamic lang;
  final dynamic mdmTp;
  final dynamic inVal;
  final dynamic totInVal;
  final dynamic aprStat;
  final dynamic operation;
  final dynamic custMgnBrch;
  final dynamic custMgnAgc;
  final dynamic brkMgnBrch;
  final dynamic brkMgnAgc;
  final dynamic loginBrch;
  final dynamic loginAgnc;
  final dynamic aprSeq;
  final dynamic makerDt;
  final dynamic aprIP;
  final dynamic aprID;
  final dynamic aprAmt;
  final dynamic ipPrivate;
  final dynamic otp;
  final dynamic acntNo;
  final dynamic subNo;
  final dynamic bankCd;
  final dynamic pcName;
  final dynamic sessionID;

  InputServiceBody({
    this.cltVersion = '3.0.0',
    this.clientSeq,
    this.secCode = "888",
    this.workerName,
    this.serviceName,
    this.timeOut = 15,
    this.mwLoginID = "MKTAppiOS",
    this.mwLoginPswd = '"3-*+(+L0(+3*D*3*M+(,7.7/G/,,I05/,-?"',
    this.appLoginID,
    this.appLoginPswd,
    this.clientSentTime = "0",
    this.lang = "VI",
    this.mdmTp = '11',
    this.inVal,
    this.totInVal,
    this.aprStat = "N",
    this.operation,
    this.custMgnBrch = "",
    this.custMgnAgc = "",
    this.brkMgnBrch = "",
    this.brkMgnAgc = "",
    this.loginBrch = "",
    this.loginAgnc = "",
    this.aprSeq,
    this.makerDt,
    this.aprIP = "",
    this.aprID = "",
    this.aprAmt = "",
    this.ipPrivate = "192.168.1.1",
    this.otp,
    this.acntNo = '',
    this.subNo = '',
    this.bankCd = '',
    this.pcName = '',
    this.sessionID,
  });

  Map toJson() => {
        'CltVersion': cltVersion,
        'ClientSeq': clientSeq,
        'SecCode': secCode,
        'WorkerName': workerName,
        'ServiceName': serviceName,
        'TimeOut': timeOut,
        'MWLoginID': mwLoginID,
        'MWLoginPswd': mwLoginPswd,
        'AppLoginID': appLoginID ?? '',
        'AppLoginPswd': appLoginPswd ?? '',
        'ClientSentTime': clientSentTime,
        'Lang': lang,
        'MdmTp': mdmTp,
        'InVal': inVal,
        'TotInVal': totInVal,
        'AprStat': aprStat,
        'Operation': operation,
        'CustMgnBrch': custMgnBrch,
        'CustMgnAgc': custMgnAgc,
        'BrkMgnBrch': brkMgnBrch,
        'BrkMgnAgc': brkMgnAgc,
        'LoginBrch': loginBrch,
        'LoginAgnc': loginAgnc,
        'AprSeq': aprSeq,
        'MakerDt': makerDt,
        'AprIP': aprIP,
        'AprID': aprID,
        'AprAmt': aprAmt,
        'IPPrivate': ipPrivate,
        'Otp': otp,
        'AcntNo': acntNo,
        'SubNo': subNo,
        'BankCd': bankCd,
        'PCName': pcName,
        'SessionID': sessionID
      };
}
