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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['test_id'] = testId;
    data['type_id'] = typeId;
    data['type_name'] = typeName;
    data['grp_id'] = grpId;
    data['grp_name'] = grpName;
    data['grp_sl'] = grpSl;
    data['is_bin'] = isBin;
    data['is_note'] = isNote;
    data['note'] = note;
    data['atr_id'] = atrId;
    data['atr_name'] = atrName;
    data['atr_sl'] = atrSl;
    data['is_detected'] = isDetected;
    data['ncopy'] = ncopy;
    return data;
  }
}
