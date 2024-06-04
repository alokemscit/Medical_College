class ModelRawMaterialsList {
  String? iTEMID;
  String? nAME;
  String? uNAME;

  ModelRawMaterialsList({this.iTEMID, this.nAME, this.uNAME});

  ModelRawMaterialsList.fromJson(Map<String, dynamic> json) {
    iTEMID = json['ITEM_ID'];
    nAME = json['NAME'];
    uNAME = json['UNAME'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ITEM_ID'] = this.iTEMID;
    data['NAME'] = this.nAME;
    data['UNAME'] = this.uNAME;
    return data;
  }
}
