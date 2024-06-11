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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['doc_id'] = this.docId;
    data['dept_id'] = this.deptId;
    data['dept_name'] = this.deptName;
    data['doc_name'] = this.docName;
    data['desig'] = this.desig;
    data['special'] = this.special;
    data['image_path'] = this.imagePath;
    data['des'] = this.des;
    return data;
  }
}
