class ModelDietAssignedData {
  String? regId;
  String? note;
  String? dietId;
  String? menuId;
  String? itemId;
  String? sl;
  String? itemName;
  String? menuName;

  ModelDietAssignedData(
      {this.regId,
      this.note,
      this.dietId,
      this.menuId,
      this.itemId,
      this.sl,
      this.itemName,
      this.menuName});

  ModelDietAssignedData.fromJson(Map<String, dynamic> json) {
    regId = json['reg_id'];
    note = json['note'];
    dietId = json['diet_id'];
    menuId = json['menu_id'];
    itemId = json['item_id'];
    sl = json['sl'];
    itemName = json['item_name'];
    menuName = json['menu_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reg_id'] = this.regId;
    data['note'] = this.note;
    data['diet_id'] = this.dietId;
    data['menu_id'] = this.menuId;
    data['item_id'] = this.itemId;
    data['sl'] = this.sl;
    return data;
  }
}
