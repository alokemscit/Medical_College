class ModelMySqlDoctor {
  String? docid;
  String? designation;
  String? speciality;
  String? image;
  String? details;

  ModelMySqlDoctor(
      {this.docid,
      this.designation,
      this.speciality,
      this.image,
      this.details});

  ModelMySqlDoctor.fromJson(Map<String, dynamic> json) {
    docid = json['docid'].toString();
    designation = json['designation'];
    speciality = json['speciality'];
    image = json['image'];
    details = json['details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['docid'] = docid;
    data['designation'] = designation;
    data['speciality'] = speciality;
    data['image'] = image;
    data['details'] = details;
    return data;
  }
}