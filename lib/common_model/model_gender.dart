class ModelGenderMaster {
  String? iD;
  String? nAME;

  ModelGenderMaster({this.iD, this.nAME});

  ModelGenderMaster.fromJson(Map<String, dynamic> json) {
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
