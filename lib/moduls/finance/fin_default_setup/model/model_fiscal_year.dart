class ModelFiscalYearMaster {
  String? iD;
  String? sDATE;
  String? tDATE;
  String? sTATUS;

  ModelFiscalYearMaster({this.iD, this.sDATE, this.tDATE, this.sTATUS});

  ModelFiscalYearMaster.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    sDATE = json['SDATE'];
    tDATE = json['TDATE'];
    sTATUS = json['STATUS'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['SDATE'] = this.sDATE;
    data['TDATE'] = this.tDATE;
    data['STATUS'] = this.sTATUS;
    return data;
  }
}
