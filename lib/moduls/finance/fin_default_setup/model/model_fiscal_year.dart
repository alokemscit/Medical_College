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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['SDATE'] = sDATE;
    data['TDATE'] = tDATE;
    data['STATUS'] = sTATUS;
    return data;
  }
}
