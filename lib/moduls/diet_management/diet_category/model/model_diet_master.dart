class ModelDietMaster {
  String? id;
  String? typeId;
  String? typeName;
  String? name;

  ModelDietMaster({this.id, this.typeId, this.typeName, this.name});

  ModelDietMaster.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    typeId = json['type_id'];
    typeName = json['type_name'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type_id'] = this.typeId;
    data['type_name'] = this.typeName;
    data['name'] = this.name;
    return data;
  }
}
