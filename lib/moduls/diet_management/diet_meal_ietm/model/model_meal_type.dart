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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['diet_typeid'] = this.dietTypeid;
    data['diet_typename'] = this.dietTypename;
    data['name'] = this.name;
    return data;
  }
}
