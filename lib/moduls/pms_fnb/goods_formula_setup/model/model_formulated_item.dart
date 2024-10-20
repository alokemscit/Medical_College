class ModelFormulatedItem {
  String? fOODID;
  String? iTEMID;
  String? iTEMNAME;
  String? uNITID;
  String? uNITNAME;
  double? qTY;

  ModelFormulatedItem(
      {this.fOODID,
      this.iTEMID,
      this.iTEMNAME,
      this.uNITID,
      this.uNITNAME,
      this.qTY});

  ModelFormulatedItem.fromJson(Map<String, dynamic> json) {
    fOODID = json['FOOD_ID'];
    iTEMID = json['ITEM_ID'];
    iTEMNAME = json['ITEM_NAME'];
    uNITID = json['UNIT_ID'];
    uNITNAME = json['UNIT_NAME'];
    qTY = json['QTY'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['FOOD_ID'] = fOODID;
    data['ITEM_ID'] = iTEMID;
    data['ITEM_NAME'] = iTEMNAME;
    data['UNIT_ID'] = uNITID;
    data['UNIT_NAME'] = uNITNAME;
    data['QTY'] = qTY;
    return data;
  }
}
