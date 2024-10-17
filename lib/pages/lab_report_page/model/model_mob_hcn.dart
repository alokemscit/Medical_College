class ModelPatWithHCN {
  String? hCN;
  String? pATNAME;
  String? iD;

  ModelPatWithHCN({this.hCN, this.pATNAME,this.iD});

  ModelPatWithHCN.fromJson(Map<String, dynamic> json) {
    hCN = json['HCN'];
    pATNAME = json['PAT_NAME'];
    iD = json['ID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['HCN'] = hCN;
    data['PAT_NAME'] = pATNAME;
     data['ID'] = iD;
    return data;
  }
}
