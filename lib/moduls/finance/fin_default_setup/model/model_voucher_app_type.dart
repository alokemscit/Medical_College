class ModelVoucherAppTypeMaster {
  String? iD;
  String? nAME;

  ModelVoucherAppTypeMaster({this.iD, this.nAME});

  ModelVoucherAppTypeMaster.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    nAME = json['NAME'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['NAME'] = nAME;
    return data;
  }
}
