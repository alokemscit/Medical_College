class ModelPlanConfiguedData {
  String? dietTypeId;
  String? dayId;
  String? timeId;
  String? mealId;
  String? menuId;
  String? itemId;
  String? sl;

  ModelPlanConfiguedData(
      {this.dietTypeId,
      this.dayId,
      this.timeId,
      this.mealId,
      this.menuId,
      this.itemId,
      this.sl});

  ModelPlanConfiguedData.fromJson(Map<String, dynamic> json) {
    dietTypeId = json['diet_type_id'];
    dayId = json['day_id'];
    timeId = json['time_id'];
    mealId = json['meal_id'];
    menuId = json['menu_id'];
    itemId = json['item_id'];
    sl = json['sl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['diet_type_id'] = this.dietTypeId;
    data['day_id'] = this.dayId;
    data['time_id'] = this.timeId;
    data['meal_id'] = this.mealId;
    data['menu_id'] = this.menuId;
    data['item_id'] = this.itemId;
    return data;
  }
}
