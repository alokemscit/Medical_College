class ModelMrrDetailsList {
  String? mrId;
  String? dt;
  String? mrType;
  String? hcn;
  String? regId;
  String? testId;
  String? sampleId;
  String? pname;
  String? docId;
  String? docName;
  String? pmob;
  String? psex;
  String? age;
  String? isSampleColl;
  String? isReultEnty;
  String? isVerify;
  String? isFinalized;
  String? method;
  String? testName;

  ModelMrrDetailsList(
      {this.mrId,
      this.dt,
      this.mrType,
      this.hcn,
      this.regId,
      this.testId,
      this.sampleId,
      this.pname,
      this.docId,
      this.docName,
      this.pmob,
      this.psex,
      this.age,
      this.isSampleColl,
      this.isReultEnty,
      this.isVerify,
      this.isFinalized,this.method,this.testName});

  ModelMrrDetailsList.fromJson(Map<String, dynamic> json) {
    mrId = json['mr_id'];
    dt = json['dt'];
    mrType = json['mr_type'];
    hcn = json['hcn'];
    regId = json['reg_id'];
    testId = json['test_id'];
    sampleId = json['sample_id'];
    pname = json['pname'];
    docId = json['doc_id'];
    docName = json['doc_name'];
    pmob = json['pmob'];
    psex = json['psex'];
    age = json['age'];
    isSampleColl = json['is_sample_coll'];
    isReultEnty = json['is_reult_enty'];
    isVerify = json['is_verify'];
    isFinalized = json['is_finalized'];
method=isFinalized = json['method'];
testName= json['test_name'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['mr_id'] = this.mrId;
  //   data['dt'] = this.dt;
  //   data['mr_type'] = this.mrType;
  //   data['hcn'] = this.hcn;
  //   data['reg_id'] = this.regId;
  //   data['test_id'] = this.testId;
  //   data['sample_id'] = this.sampleId;
  //   data['pname'] = this.pname;
  //   data['doc_id'] = this.docId;
  //   data['doc_name'] = this.docName;
  //   data['pmob'] = this.pmob;
  //   data['psex'] = this.psex;
  //   data['age'] = this.age;
  //   data['is_sample_coll'] = this.isSampleColl;
  //   data['is_reult_enty'] = this.isReultEnty;
  //   data['is_verify'] = this.isVerify;
  //   data['is_finalized'] = this.isFinalized;
  //   return data;
  // }
}
