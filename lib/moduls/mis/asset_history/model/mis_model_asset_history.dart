class ModelMisAssetHistory {
  String? iTEMID;
  String? iTEMNAME;
  String? bATCHNO;
  String? gROUPNAME;
  String? mAJORGROUP;
  String? cOMPANYNAME;
  String? uNITNAME;
  String? gRNNO;
  String? cHALANDATE;
  String? cHALANNO;
  String? gRNDATE;
  String? sUPPLIERNAME;
  String? group_id;
  String? major_group_id;

  ModelMisAssetHistory(
      {this.iTEMID,
      this.iTEMNAME,
      this.bATCHNO,
      this.gROUPNAME,
      this.mAJORGROUP,
      this.cOMPANYNAME,
      this.uNITNAME,
      this.gRNNO,
      this.cHALANDATE,
      this.cHALANNO,
      this.gRNDATE,
      this.sUPPLIERNAME,
      this.group_id,
      this.major_group_id});

  ModelMisAssetHistory.fromJson(Map<String, dynamic> json) {
    iTEMID = json['ITEM_ID'];
    iTEMNAME = json['ITEM_NAME'];
    bATCHNO = json['BATCH_NO'];
    gROUPNAME = json['GROUP_NAME'];
    mAJORGROUP = json['MAJOR_GROUP'];
    cOMPANYNAME = json['COMPANY_NAME'];
    uNITNAME = json['UNIT_NAME'];
    gRNNO = json['GRN_NO'];
    cHALANDATE = json['CHALAN_DATE'];
    cHALANNO = json['CHALAN_NO'];
    gRNDATE = json['GRN_DATE'];
    sUPPLIERNAME = json['SUPPLIER_NAME'];
    group_id = json['GRP_ID'].toString();
    major_group_id = json['MAJOR_GRP_ID'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ITEM_ID'] = iTEMID;
    data['ITEM_NAME'] = iTEMNAME;
    data['BATCH_NO'] = bATCHNO;
    data['GROUP_NAME'] = gROUPNAME;
    data['MAJOR_GROUP'] = mAJORGROUP;
    data['COMPANY_NAME'] = cOMPANYNAME;
    data['UNIT_NAME'] = uNITNAME;
    data['GRN_NO'] = gRNNO;
    data['CHALAN_DATE'] = cHALANDATE;
    data['CHALAN_NO'] = cHALANNO;
    data['GRN_DATE'] = gRNDATE;
    data['SUPPLIER_NAME'] = sUPPLIERNAME;
    return data;
  }
}
