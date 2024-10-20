class ModelPathResis {
  String? prId;
  String? id;
  String? name;
  String? bin;
  String? note;

  ModelPathResis({this.prId, this.id, this.name, this.bin, this.note});

  ModelPathResis.fromJson(Map<String, dynamic> json) {
    prId = json['pr_id'];
    id = json['id'];
    name = json['name'];
    bin = json['bin'];
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pr_id'] = prId;
    data['id'] = id;
    data['name'] = name;
    data['bin'] = bin;
    data['note'] = note;
    return data;
  }
}
