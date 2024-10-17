class ModelVoucherType {
  String? iD;
  String? nAME;
  String? sNAME;

  ModelVoucherType({this.iD, this.nAME,this.sNAME});

  ModelVoucherType.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    nAME = json['NAME'];
    sNAME = json['SNAME'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['ID'] = this.iD;
  //   data['NAME'] = this.nAME;
  //   return data;
  // }
}
