class ModelSubledgerMaster {
  String? iD;
  String? nAME;
  String? cODE;
  String? dESCRIPTION;
  String? iSBILLBYBILL;

  ModelSubledgerMaster(
      {this.iD, this.nAME, this.cODE, this.dESCRIPTION, this.iSBILLBYBILL});

  ModelSubledgerMaster.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    nAME = json['NAME'];
    cODE = json['CODE'];
    dESCRIPTION = json['DESCRIPTION'];
    iSBILLBYBILL = json['IS_BILL_BY_BILL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = this.iD;
    data['NAME'] = this.nAME;
    data['CODE'] = this.cODE;
    data['DESCRIPTION'] = this.dESCRIPTION;
    data['IS_BILL_BY_BILL'] = this.iSBILLBYBILL;
    return data;
  }
}