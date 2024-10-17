class ModelEntStudent {
  String? id;
  String? stId;
  String? roll;
  String? mob;
  String? name;
  String? ses;
  String? isfree;
  double? omt;
  String? ses_id;
  String? quota_id;
  String? quota_name;

  ModelEntStudent(
      {this.id,
      this.stId,
      this.roll,
      this.mob,
      this.name,
      this.ses,
      this.omt,
      this.isfree,
      this.ses_id,this.quota_id,this.quota_name});

  ModelEntStudent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    stId = json['st_id'];
    roll = json['roll'];
    mob = json['mob'];
    name = json['name'];
    ses = json['ses'];
    omt = json['omt'];
    isfree = json['is_free'];
    ses_id = json["ses_id"].toString();
     quota_id = json["quota_id"].toString();
     quota_name = json["quota_name"];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['st_id'] = this.stId;
  //   data['roll'] = this.roll;
  //   data['mob'] = this.mob;
  //   data['name'] = this.name;
  //   data['ses'] = this.ses;
  //   data['omt'] = this.omt;
  //   return data;
  // }
}
