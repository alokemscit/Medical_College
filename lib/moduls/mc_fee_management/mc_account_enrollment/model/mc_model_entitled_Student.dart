
class ModelEntStudent {
  String? id;
  String? stId;
  String? roll;
  String? mob;
  String? name;
  String? ses;
  int? omt;

  ModelEntStudent(
      {this.id, this.stId, this.roll, this.mob, this.name, this.ses, this.omt});

  ModelEntStudent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    stId = json['st_id'];
    roll = json['roll'];
    mob = json['mob'];
    name = json['name'];
    ses = json['ses'];
    omt = json['omt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['st_id'] = this.stId;
    data['roll'] = this.roll;
    data['mob'] = this.mob;
    data['name'] = this.name;
    data['ses'] = this.ses;
    data['omt'] = this.omt;
    return data;
  }
}
