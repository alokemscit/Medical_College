class ModelMealItemMaster {
  String? id;
  String? dietTypeid;
  String? mealTypeid;
  String? mealTypename;
  String? name;

  ModelMealItemMaster(
      {this.id,
      this.dietTypeid,
      this.mealTypeid,
      this.mealTypename,
      this.name});

  ModelMealItemMaster.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dietTypeid = json['diet_typeid'];
    mealTypeid = json['meal_typeid'];
    mealTypename = json['meal_typename'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['diet_typeid'] = this.dietTypeid;
    data['meal_typeid'] = this.mealTypeid;
    data['meal_typename'] = this.mealTypename;
    data['name'] = this.name;
    return data;
  }
}
