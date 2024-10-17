 

class ModelTrailLedger {
  String? cID;
  String? gLID;
  String? gLNAME;
  String? gLCODE;
  String? cATID;
  String? cATNAME;
  String? cATCODE;
  String? sUBID;
  String? sUBNAME;
  String? sUBCODE;
  String? gROUPID;
  String? gROUPCODE;
  String? gROUPNAME;
  String? cHARTID;
  String? cHARTCODE;
  String? cHARTNAME;
  double ? oDR;
  double? oCR;
  double? tRDR;
  double? tRCR;
  double? cDR;
  double? cCR;

  ModelTrailLedger(
      {this.cID,
      this.gLID,
      this.gLNAME,
      this.gLCODE,
      this.cATID,
      this.cATNAME,
      this.cATCODE,
      this.sUBID,
      this.sUBNAME,
      this.sUBCODE,
      this.gROUPID,
      this.gROUPCODE,
      this.gROUPNAME,
      this.cHARTID,
      this.cHARTCODE,
      this.cHARTNAME,
      this.oDR,
      this.oCR,
      this.tRDR,
      this.tRCR,
      this.cDR,
      this.cCR});

  ModelTrailLedger.fromJson(Map<String, dynamic> json) {
    cID = json['CID'];
    gLID = json['GL_ID'];
    gLNAME = json['GL_NAME'];
    gLCODE = json['GL_CODE'];
    cATID = json['CAT_ID'];
    cATNAME = json['CAT_NAME'];
    cATCODE = json['CAT_CODE'];
    sUBID = json['SUB_ID'];
    sUBNAME = json['SUB_NAME'];
    sUBCODE = json['SUB_CODE'];
    gROUPID = json['GROUP_ID'];
    gROUPCODE = json['GROUP_CODE'];
    gROUPNAME = json['GROUP_NAME'];
    cHARTID = json['CHART_ID'];
    cHARTCODE = json['CHART_CODE'];
    cHARTNAME = json['CHART_NAME'];
    oDR = json['O_DR'];
    oCR = json['O_CR'];
    tRDR = json['TR_DR'];
    tRCR = json['TR_CR'];
    cDR = json['C_DR'];
    cCR = json['C_CR'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['CID'] = cID;
    data['GL_ID'] = gLID;
    data['GL_NAME'] = gLNAME;
    data['GL_CODE'] = gLCODE;
    data['CAT_ID'] = cATID;
    data['CAT_NAME'] = cATNAME;
    data['CAT_CODE'] = cATCODE;
    data['SUB_ID'] = sUBID;
    data['SUB_NAME'] = sUBNAME;
    data['SUB_CODE'] = sUBCODE;
    data['GROUP_ID'] = gROUPID;
    data['GROUP_CODE'] = gROUPCODE;
    data['GROUP_NAME'] = gROUPNAME;
    data['CHART_ID'] = cHARTID;
    data['CHART_CODE'] = cHARTCODE;
    data['CHART_NAME'] = cHARTNAME;
    data['O_DR'] = oDR;
    data['O_CR'] = oCR;
    data['TR_DR'] = tRDR;
    data['TR_CR'] = tRCR;
    data['C_DR'] = cDR;
    data['C_CR'] = cCR;
    return data;
  }
}
