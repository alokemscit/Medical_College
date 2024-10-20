class ModelDietAssignedSummaryData {
  String? nsId;
  String? nsName;
  String? menuId;
  String? menuName;
  String? itemId;
  String? itemName;
  double? cnt;

  ModelDietAssignedSummaryData(
      {this.nsId,
      this.nsName,
      this.menuId,
      this.menuName,
      this.itemId,
      this.itemName,
      this.cnt});

  ModelDietAssignedSummaryData.fromJson(Map<String, dynamic> json) {
    nsId = json['ns_id'];
    nsName = json['ns_name'];
    menuId = json['menu_id'];
    menuName = json['menu_name'];
    itemId = json['item_id'];
    itemName = json['item_name'];
    cnt = json['cnt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ns_id'] = this.nsId;
    data['ns_name'] = this.nsName;
    data['menu_id'] = this.menuId;
    data['menu_name'] = this.menuName;
    data['item_id'] = this.itemId;
    data['item_name'] = this.itemName;
    data['cnt'] = this.cnt;
    return data;
  }
}
