class ModelPatitentUser {
  String? hCN;
  String? pATNAME;
  String? fNAME;
  String? mNAME;
  String? sPOUSENAME;
  String? gUARDIANNAME;
  String? dOB;
  String? sEX;
  String? rELIGION;
  String? bLOODGRP;
  String? mARITALSTATUS;
  String? nID;
  String? eMAIL;
  String? cELLPHONE;
  String? hOMEPHONE;
  String? hOVIARRD;
  String? pOSTCODE;
  String? tHANACODE;
  String? dISTRICTCODE;
  String? cOUNTRY;
  String? eCONTPERSON;
  String? eADDRESS;
  String? eCELLPHONE;
  String? eRELWITHPAT;
  String? cORPORATEID;
  String? iMAGE;

  ModelPatitentUser(
      {this.hCN,
      this.pATNAME,
      this.fNAME,
      this.mNAME,
      this.sPOUSENAME,
      this.gUARDIANNAME,
      this.dOB,
      this.sEX,
      this.rELIGION,
      this.bLOODGRP,
      this.mARITALSTATUS,
      this.nID,
      this.eMAIL,
      this.cELLPHONE,
      this.hOMEPHONE,
      this.hOVIARRD,
      this.pOSTCODE,
      this.tHANACODE,
      this.dISTRICTCODE,
      this.cOUNTRY,
      this.eCONTPERSON,
      this.eADDRESS,
      this.eCELLPHONE,
      this.eRELWITHPAT,
      this.cORPORATEID,
      this.iMAGE});

  ModelPatitentUser.fromJson(Map<String, dynamic> json) {
    hCN = json['HCN'];
    pATNAME = json['PAT_NAME'];
    fNAME = json['FNAME'];
    mNAME = json['MNAME'];
    sPOUSENAME = json['SPOUSE_NAME'];
    gUARDIANNAME = json['GUARDIAN_NAME'];
    dOB = json['DOB'];
    sEX = json['SEX'];
    rELIGION = json['RELIGION'];
    bLOODGRP = json['BLOOD_GRP'];
    mARITALSTATUS = json['MARITAL_STATUS'];
    nID = json['NID'];
    eMAIL = json['EMAIL'];
    cELLPHONE = json['CELL_PHONE'];
    hOMEPHONE = json['HOME_PHONE'];
    hOVIARRD = json['HO_VI_AR_RD'];
    pOSTCODE = json['POST_CODE'];
    tHANACODE = json['THANA_CODE'];
    dISTRICTCODE = json['DISTRICT_CODE'];
    cOUNTRY = json['COUNTRY'];
    eCONTPERSON = json['E_CONT_PERSON'];
    eADDRESS = json['E_ADDRESS'];
    eCELLPHONE = json['E_CELL_PHONE'];
    eRELWITHPAT = json['E_REL_WITH_PAT'];
    cORPORATEID = json['CORPORATE_ID'];
    iMAGE = json['IMAGE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['HCN'] = hCN;
    data['PAT_NAME'] = pATNAME;
    data['FNAME'] = fNAME;
    data['MNAME'] = mNAME;
    data['SPOUSE_NAME'] = sPOUSENAME;
    data['GUARDIAN_NAME'] = gUARDIANNAME;
    data['DOB'] = dOB;
    data['SEX'] = sEX;
    data['RELIGION'] = rELIGION;
    data['BLOOD_GRP'] = bLOODGRP;
    data['MARITAL_STATUS'] = mARITALSTATUS;
    data['NID'] = nID;
    data['EMAIL'] = eMAIL;
    data['CELL_PHONE'] = cELLPHONE;
    data['HOME_PHONE'] = hOMEPHONE;
    data['HO_VI_AR_RD'] = hOVIARRD;
    data['POST_CODE'] = pOSTCODE;
    data['THANA_CODE'] = tHANACODE;
    data['DISTRICT_CODE'] = dISTRICTCODE;
    data['COUNTRY'] = cOUNTRY;
    data['E_CONT_PERSON'] = eCONTPERSON;
    data['E_ADDRESS'] = eADDRESS;
    data['E_CELL_PHONE'] = eCELLPHONE;
    data['E_REL_WITH_PAT'] = eRELWITHPAT;
    data['CORPORATE_ID'] = cORPORATEID;
    data['IMAGE'] = iMAGE;
    return data;
  }
}
