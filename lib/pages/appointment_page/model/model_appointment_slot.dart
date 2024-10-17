class ModelAppiontmentSlot {
  String? iD;
  String? aPPOINTMENTDATE;
  String? dOCTORID;
  String? aPPOINTMENTTIME;
  String? dAYS;
  String? mONTHS;
  String? mONTHNAME;
  String? yEARS;

  ModelAppiontmentSlot(
      {this.iD,
      this.aPPOINTMENTDATE,
      this.dOCTORID,
      this.aPPOINTMENTTIME,
      this.dAYS,
      this.mONTHS,
      this.mONTHNAME,
      this.yEARS});

  ModelAppiontmentSlot.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    aPPOINTMENTDATE = json['APPOINTMENT_DATE'];
    dOCTORID = json['DOCTOR_ID'];
    aPPOINTMENTTIME = json['APPOINTMENT_TIME'];
    dAYS = json['DAYS'];
    mONTHS = json['MONTHS'];
    mONTHNAME = json['MONTH_NAME'];
    yEARS = json['YEARS'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['APPOINTMENT_DATE'] = aPPOINTMENTDATE;
    data['DOCTOR_ID'] = dOCTORID;
    data['APPOINTMENT_TIME'] = aPPOINTMENTTIME;
    data['DAYS'] = dAYS;
    data['MONTHS'] = mONTHS;
    data['MONTH_NAME'] = mONTHNAME;
    data['YEARS'] = yEARS;
    return data;
  }
}
