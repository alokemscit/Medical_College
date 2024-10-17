class ModelMealTypeMaster {
  String? id;
  String? dietTypeid;
  String? dietTypename;
  String? name;

  ModelMealTypeMaster({this.id, this.dietTypeid, this.dietTypename, this.name});

  ModelMealTypeMaster.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dietTypeid = json['diet_typeid'];
    dietTypename = json['diet_typename'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['diet_typeid'] = dietTypeid;
    data['diet_typename'] = dietTypename;
    data['name'] = name;
    return data;
  }
}
