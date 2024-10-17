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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ITEM_ID'] = iTEMID;
    data['NAME'] = nAME;
    data['UNAME'] = uNAME;
    return data;
  }
}
