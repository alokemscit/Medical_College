class ModelCostcenterMaster {
  String? iD;
  String? nAME;
  String? cODE;
  String? dESCRIPTION;

  ModelCostcenterMaster({this.iD, this.nAME, this.cODE, this.dESCRIPTION});

  ModelCostcenterMaster.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    nAME = json['NAME'];
    cODE = json['CODE'];
    dESCRIPTION = json['DESCRIPTION'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['NAME'] = nAME;
    data['CODE'] = cODE;
    data['DESCRIPTION'] = dESCRIPTION;
    return data;
  }
}
