class ModelDoctorUnit {
  String? NITID;
  String? NITTITLE;

  ModelDoctorUnit({this.NITID, this.NITTITLE});

  ModelDoctorUnit.fromJson(Map<String, dynamic> json) {
    NITID = json['UNIT_ID'].toString();
    NITTITLE = json['UNIT_TITLE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['UNIT_ID'] = NITID;
    data['UNIT_TITLE'] = NITTITLE;
    return data;
  }
}
