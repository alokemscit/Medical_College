class ModelGlSlLinkageMaster {
  String? gLID;
   String? gLCode;
  String? gLNAME;
  String? sLID;
  String? sLCode;
  String? sLNAME;

  ModelGlSlLinkageMaster({this.gLID, this.gLNAME, this.sLID, this.sLNAME,this.gLCode,this.sLCode});

  ModelGlSlLinkageMaster.fromJson(Map<String, dynamic> json) {
    gLID = json['GL_ID'];
    gLNAME = json['GL_NAME'];
     gLCode = json['GL_CODE'];
    sLID = json['SL_ID'];
    sLCode = json['SL_CODE'];
    sLNAME = json['SL_NAME'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['GL_ID'] = gLID;
    data['GL_NAME'] = gLNAME;
    data['SL_ID'] = sLID;
    data['SL_NAME'] = sLNAME;
    return data;
  }
}
