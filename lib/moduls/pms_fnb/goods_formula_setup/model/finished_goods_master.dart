class ModelFinishedGoodsList {
  String? fOODID;
  String? fOODNAME;
  double? rATE;
  int? sUBPLLAMOUNT;
  int? vAT;
  int? dISC;
  int? qTY;

  ModelFinishedGoodsList(
      {this.fOODID,
      this.fOODNAME,
      this.rATE,
      this.sUBPLLAMOUNT,
      this.vAT,
      this.dISC,
      this.qTY});

  ModelFinishedGoodsList.fromJson(Map<String, dynamic> json) {
    fOODID = json['FOOD_ID'];
    fOODNAME = json['FOOD_NAME'];
    rATE = json['RATE'];
    sUBPLLAMOUNT = json['SUBPLL_AMOUNT'];
    vAT = json['VAT'];
    dISC = json['DISC'];
    qTY = json['QTY'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['FOOD_ID'] = this.fOODID;
  //   data['FOOD_NAME'] = this.fOODNAME;
  //   data['RATE'] = this.rATE;
  //   data['SUBPLL_AMOUNT'] = this.sUBPLLAMOUNT;
  //   data['VAT'] = this.vAT;
  //   data['DISC'] = this.dISC;
  //   data['QTY'] = this.qTY;
  //   return data;
  // }
}
