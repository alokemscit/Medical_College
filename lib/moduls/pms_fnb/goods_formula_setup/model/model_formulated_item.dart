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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['FOOD_ID'] = this.fOODID;
    data['ITEM_ID'] = this.iTEMID;
    data['ITEM_NAME'] = this.iTEMNAME;
    data['UNIT_ID'] = this.uNITID;
    data['UNIT_NAME'] = this.uNITNAME;
    data['QTY'] = this.qTY;
    return data;
  }
}
