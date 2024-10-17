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
    data['ID'] = iD;
    data['NAME'] = nAME;
    data['CODE'] = cODE;
    data['DESCRIPTION'] = dESCRIPTION;
    data['IS_BILL_BY_BILL'] = iSBILLBYBILL;
    return data;
  }
}