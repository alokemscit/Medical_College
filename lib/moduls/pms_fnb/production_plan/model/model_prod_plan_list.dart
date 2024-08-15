class ModelProdPlanList {
  String? iD;
  double? aPPQTY;
  String? fOODID;
  String? fOODNAME;
  String? uNITNAME;
  double? qTY;
  String? pLANNO;
  String? pRODDATE;
  String? eNTRYDATE;
  String? eNTRYBY;
  String? eNTRYBYNAME;
  String? nOTE;
  String? aPPBYNAME;
  String? aPPBY;
  String? aPPDATE;
  String? sTATUS;

  ModelProdPlanList(
      {this.iD,
      this.aPPQTY,
      this.fOODID,
      this.fOODNAME,
      this.uNITNAME,
      this.qTY,
      this.pLANNO,
      this.pRODDATE,
      this.eNTRYDATE,
      this.eNTRYBY,
      this.eNTRYBYNAME,
      this.nOTE,
      this.aPPBYNAME,
      this.aPPBY,
      this.aPPDATE,
      this.sTATUS});

  ModelProdPlanList.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    aPPQTY = json['APP_QTY'];
    fOODID = json['FOOD_ID'];
    fOODNAME = json['FOOD_NAME'];
    uNITNAME = json['UNIT_NAME'];
    qTY = json['QTY'];
    pLANNO = json['PLAN_NO'];
    pRODDATE = json['PROD_DATE'];
    eNTRYDATE = json['ENTRY_DATE'];
    eNTRYBY = json['ENTRY_BY'];
    eNTRYBYNAME = json['ENTRY_BY_NAME'];
    nOTE = json['NOTE'];
    aPPBYNAME = json['APP_BY_NAME'];
    aPPBY = json['APP_BY'];
    aPPDATE = json['APP_DATE'];
    sTATUS = json['STATUS'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['APP_QTY'] = this.aPPQTY;
    data['FOOD_ID'] = this.fOODID;
    data['FOOD_NAME'] = this.fOODNAME;
    data['UNIT_NAME'] = this.uNITNAME;
    data['QTY'] = this.qTY;
    data['PLAN_NO'] = this.pLANNO;
    data['PROD_DATE'] = this.pRODDATE;
    data['ENTRY_DATE'] = this.eNTRYDATE;
    data['ENTRY_BY'] = this.eNTRYBY;
    data['ENTRY_BY_NAME'] = this.eNTRYBYNAME;
    data['NOTE'] = this.nOTE;
    data['APP_BY_NAME'] = this.aPPBYNAME;
    data['APP_BY'] = this.aPPBY;
    data['APP_DATE'] = this.aPPDATE;
    data['STATUS'] = this.sTATUS;
    return data;
  }
}
