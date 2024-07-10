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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pr_id'] = this.prId;
    data['id'] = this.id;
    data['name'] = this.name;
    data['bin'] = this.bin;
    data['note'] = this.note;
    return data;
  }
}
