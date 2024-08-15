class ModelResultData {
  String? testId;
  String? typeId;
  String? typeName;
  String? grpId;
  String? grpName;
  String? grpSl;
  String? isBin;
  String? isNote;
  String? note;
  String? atrId;
  String? atrName;
  String? atrSl;
  String? isDetected;
  String? ncopy;

  ModelResultData(
      {this.testId,
      this.typeId,
      this.typeName,
      this.grpId,
      this.grpName,
      this.grpSl,
      this.isBin,
      this.isNote,
      this.note,
      this.atrId,
      this.atrName,
      this.atrSl,
      this.isDetected,
      this.ncopy});

  ModelResultData.fromJson(Map<String, dynamic> json) {
    testId = json['test_id'];
    typeId = json['type_id'];
    typeName = json['type_name'];
    grpId = json['grp_id'];
    grpName = json['grp_name'];
    grpSl = json['grp_sl'];
    isBin = json['is_bin'];
    isNote = json['is_note'];
    note = json['note'];
    atrId = json['atr_id'];
    atrName = json['atr_name'];
    atrSl = json['atr_sl'];
    isDetected = json['is_detected'];
    ncopy = json['ncopy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['test_id'] = this.testId;
    data['type_id'] = this.typeId;
    data['type_name'] = this.typeName;
    data['grp_id'] = this.grpId;
    data['grp_name'] = this.grpName;
    data['grp_sl'] = this.grpSl;
    data['is_bin'] = this.isBin;
    data['is_note'] = this.isNote;
    data['note'] = this.note;
    data['atr_id'] = this.atrId;
    data['atr_name'] = this.atrName;
    data['atr_sl'] = this.atrSl;
    data['is_detected'] = this.isDetected;
    data['ncopy'] = this.ncopy;
    return data;
  }
}
