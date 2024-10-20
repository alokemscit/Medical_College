class ModelLedgerOpeningBalance {
  String? iD;
  String? cODE;
  String? pID;
  String? nAME;
  double? cR;
  double? dR;

  ModelLedgerOpeningBalance(
      {this.iD, this.cODE, this.pID, this.nAME, this.cR, this.dR});

  ModelLedgerOpeningBalance.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    cODE = json['CODE'];
    pID = json['PID'];
    nAME = json['NAME'];
    cR = json['CR'];
    dR = json['DR'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['CODE'] = cODE;
    data['PID'] = pID;
    data['NAME'] = nAME;
    data['CR'] = cR;
    data['DR'] = dR;
    return data;
  }
}
