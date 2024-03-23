class ModelGlCCLinkageMaster {
  String? gLID;
   String? gLCode;
  String? gLNAME;
  String? cCID;
  String? cCCode;
  String? cCNAME;

  ModelGlCCLinkageMaster({this.gLID, this.gLNAME, this.cCID, this.cCNAME,this.gLCode,this.cCCode});

  ModelGlCCLinkageMaster.fromJson(Map<String, dynamic> json) {
    gLID = json['GL_ID'];
    gLNAME = json['GL_NAME'];
     gLCode = json['GL_CODE'];
    cCID = json['CC_ID'];
    cCCode = json['CC_CODE'];
    cCNAME = json['CC_NAME'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['GL_ID'] = this.gLID;
    data['GL_NAME'] = this.gLNAME;
    data['CC_ID'] = this.cCID;
    data['CC_NAME'] = this.cCNAME;
    return data;
  }
}
