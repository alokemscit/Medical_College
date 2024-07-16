class ModelTestConfig {
  String? testId;
  String? typeId;
  String? typeName;
  String? grpId;
  String? grpName;
  String? atrId;
  String? atrName;
  String? grpSl;
  String? artSl;
  String? isBin;
String? isNote;
  ModelTestConfig(
      {this.testId,
      this.typeId,
      this.typeName,
      this.grpId,
      this.grpName,
      this.atrId,
      this.atrName,
      this.grpSl,
      this.artSl,this.isBin,this.isNote});

  ModelTestConfig.fromJson(Map<String, dynamic> json) {
    testId = json['test_id'];
    typeId = json['type_id'];
    typeName = json['type_name'];
    grpId = json['grp_id'];
    grpName = json['grp_name'];
    atrId = json['atr_id'];
    atrName = json['atr_name'];
    grpSl = json['grp_sl'];
    artSl = json['art_sl'];
    isBin=json['is_bin'];
    isNote=json['is_note'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['test_id'] = this.testId;
  //   data['type_id'] = this.typeId;
  //   data['type_name'] = this.typeName;
  //   data['grp_id'] = this.grpId;
  //   data['grp_name'] = this.grpName;
  //   data['atr_id'] = this.atrId;
  //   data['atr_name'] = this.atrName;
  //   data['grp_sl'] = this.grpSl;
  //   data['art_sl'] = this.artSl;
  //   return data;
  // }
}
