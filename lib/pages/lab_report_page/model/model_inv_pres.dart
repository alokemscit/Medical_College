class ModelInvPresWithHCN {
  String? sN;
  String? tP;
  String? dT;
  String? dOCID;
  String? dOCNAME;
  String? rGID;
  String? rGNAME;
  String? tDID;
  String? tDNAME;
  String? rID;
String? mRID;
//MR_ID
  ModelInvPresWithHCN(
      {this.sN,
      this.tP,
      this.dT,
      this.dOCID,
      this.dOCNAME,
      this.rGID,
      this.rGNAME,
      this.tDID,
      this.tDNAME,
      this.rID,
      this.mRID
      });

  ModelInvPresWithHCN.fromJson(Map<String, dynamic> json) {
    sN = json['SN'];
    tP = json['TP'];
    dT = json['DT'];
    dOCID = json['DOC_ID'];
    dOCNAME = json['DOC_NAME'];
    rGID = json['RG_ID'];
    rGNAME = json['RG_NAME'];
    tDID = json['TD_ID'];
    tDNAME = json['TD_NAME'];
    rID = json['RID'];
    mRID = json['MR_ID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['SN'] = sN;
    data['TP'] = tP;
    data['DT'] = dT;
    data['DOC_ID'] = dOCID;
    data['DOC_NAME'] = dOCNAME;
    data['RG_ID'] = rGID;
    data['RG_NAME'] = rGNAME;
    data['TD_ID'] = tDID;
    data['TD_NAME'] = tDNAME;
    data['RID'] = rID;
     data['MR_ID'] = mRID;
    return data;
  }
}
