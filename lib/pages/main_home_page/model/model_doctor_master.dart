class ModelDoctorMaster {
  String? dOCID;
  String? dOCTORNAME;
  String? uNIT;
  String? dEGREE1;
  String? dEGREE2;
  String? dEGREE3;
  String? uNINTID;
  String? iSONLINE;
 
 String? iMAGE;

  ModelDoctorMaster({this.dOCID, this.dOCTORNAME, this.uNIT});

  ModelDoctorMaster.fromJson(Map<String, dynamic> json) {
    dOCID = json['DOC_ID'];
    dOCTORNAME = json['DOCTORNAME'];
    uNIT = json['UNIT'];
    dEGREE1 = json['DEGREE1'];
    dEGREE2 = json['DEGREE2'];
    dEGREE3 = json['DEGREE3'];
    uNINTID = json['UNIT_ID'];
    iSONLINE = json['ISONLINE'].toString();
    
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['DOC_ID'] = this.dOCID;
  //   data['DOCTORNAME'] = this.dOCTORNAME;
  //   data['UNIT'] = this.uNIT;
  //   return data;
  // }
}
