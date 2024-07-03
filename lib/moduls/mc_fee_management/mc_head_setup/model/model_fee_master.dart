class ModelFeeMaster {
  String? id;
  String? name;
  String? typeId;
  String? typeName;

  ModelFeeMaster({this.id, this.name, this.typeId, this.typeName});

  ModelFeeMaster.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    typeId = json['type_id'];
    typeName = json['type_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['type_id'] = this.typeId;
    data['type_name'] = this.typeName;
    return data;
  }
}