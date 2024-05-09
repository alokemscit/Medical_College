class ModelChartAccMaster {
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

  ModelChartAccMaster(
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
      this.cHARTNAME});

  ModelChartAccMaster.fromJson(Map<String, dynamic> json) {
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CID'] = this.cID;
    data['GL_ID'] = this.gLID;
    data['GL_NAME'] = this.gLNAME;
    data['GL_CODE'] = this.gLCODE;
    data['CAT_ID'] = this.cATID;
    data['CAT_NAME'] = this.cATNAME;
    data['CAT_CODE'] = this.cATCODE;
    data['SUB_ID'] = this.sUBID;
    data['SUB_NAME'] = this.sUBNAME;
    data['SUB_CODE'] = this.sUBCODE;
    data['GROUP_ID'] = this.gROUPID;
    data['GROUP_CODE'] = this.gROUPCODE;
    data['GROUP_NAME'] = this.gROUPNAME;
    data['CHART_ID'] = this.cHARTID;
    data['CHART_CODE'] = this.cHARTCODE;
    data['CHART_NAME'] = this.cHARTNAME;
    return data;
  }
}
