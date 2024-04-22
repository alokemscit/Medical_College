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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['CODE'] = this.cODE;
    data['PID'] = this.pID;
    data['NAME'] = this.nAME;
    data['CR'] = this.cR;
    data['DR'] = this.dR;
    return data;
  }
}
