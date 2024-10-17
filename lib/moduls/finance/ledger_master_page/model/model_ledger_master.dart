class ModelLedgerMaster {
  String? pARENTID;
  String? iD;
  String? nAME;
  String? iSPARENT;
  String? sL;
  String? cODE;
  String? isCC;
   String? isSL;

  ModelLedgerMaster(
      {this.pARENTID, this.iD, this.nAME, this.iSPARENT, this.sL, this.cODE,this.isCC,this.isSL});

  ModelLedgerMaster.fromJson(Map<String, dynamic> json) {
    pARENTID = json['PARENTID'];
    iD = json['ID'];
    nAME = json['NAME'];
    iSPARENT = json['ISPARENT'];
    sL = json['SL'];
    cODE = json['CODE'];
    isCC = json['IS_CC'];
    isSL = json['IS_SL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['PARENTID'] = pARENTID;
    data['ID'] = iD;
    data['NAME'] = nAME;
    data['ISPARENT'] = iSPARENT;
    data['SL'] = sL;
    data['CODE'] = cODE;
     data['IS_CC'] = isCC;
      data['IS_SL'] = isSL;
    return data;
  }
}
