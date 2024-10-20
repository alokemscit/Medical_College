class ModelDoctorMobMaster {
  String? docId;
  String? deptId;
  String? deptName;
  String? docName;
  String? desig;
  String? special;
  String? imagePath;
  String? des;

  ModelDoctorMobMaster(
      {this.docId,
      this.deptId,
      this.deptName,
      this.docName,
      this.desig,
      this.special,
      this.imagePath,
      this.des});

  ModelDoctorMobMaster.fromJson(Map<String, dynamic> json) {
    docId = json['doc_id'];
    deptId = json['dept_id'];
    deptName = json['dept_name'];
    docName = json['doc_name'];
    desig = json['desig'];
    special = json['special'];
    imagePath = json['image_path'];
    des = json['des'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['doc_id'] = docId;
    data['dept_id'] = deptId;
    data['dept_name'] = deptName;
    data['doc_name'] = docName;
    data['desig'] = desig;
    data['special'] = special;
    data['image_path'] = imagePath;
    data['des'] = des;
    return data;
  }
}
