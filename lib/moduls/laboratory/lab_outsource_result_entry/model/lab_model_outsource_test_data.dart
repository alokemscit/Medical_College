class ModelOutSourceTestData {
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
  String? resId;
  String? unit;
  String? department;
  String? bedno;
  String? entryBy;
  String? entryByName;
  String? entryDate;
  String? verifyBy;
  String? verifyByName;
  String? verifyDate;
  String? finalizedBy;
  String? finalizedByName;
  String? finalizedDate;

  ModelOutSourceTestData(
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
      this.isFinalized,
      this.method,
      this.testName,
      this.resId,
      this.unit,
      this.department,
      this.bedno,
      this.entryBy,
      this.entryByName,
      this.entryDate,
      this.verifyBy,
      this.verifyByName,
      this.verifyDate,
      this.finalizedBy,
      this.finalizedByName,
      this.finalizedDate});

  ModelOutSourceTestData.fromJson(Map<String, dynamic> json) {
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
    method = json['method'];
    testName = json['test_name'];
    resId = json['res_id'];
    unit = json['unit'];
    department = json['department'];
    bedno = json['bedno'];
    entryBy = json['entry_by'];
    entryByName = json['entry_by_name'];
    entryDate = json['entry_date'];
    verifyBy = json['verify_by'];
    verifyByName = json['verify_by_name'];
    verifyDate = json['verify_date'];
    finalizedBy = json['finalized_by'];
    finalizedByName = json['finalized_by_name'];
    finalizedDate = json['finalized_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mr_id'] = this.mrId;
    data['dt'] = this.dt;
    data['mr_type'] = this.mrType;
    data['hcn'] = this.hcn;
    data['reg_id'] = this.regId;
    data['test_id'] = this.testId;
    data['sample_id'] = this.sampleId;
    data['pname'] = this.pname;
    data['doc_id'] = this.docId;
    data['doc_name'] = this.docName;
    data['pmob'] = this.pmob;
    data['psex'] = this.psex;
    data['age'] = this.age;
    data['is_sample_coll'] = this.isSampleColl;
    data['is_reult_enty'] = this.isReultEnty;
    data['is_verify'] = this.isVerify;
    data['is_finalized'] = this.isFinalized;
    data['method'] = this.method;
    data['test_name'] = this.testName;
    data['res_id'] = this.resId;
    data['unit'] = this.unit;
    data['department'] = this.department;
    data['bedno'] = this.bedno;
    data['entry_by'] = this.entryBy;
    data['entry_by_name'] = this.entryByName;
    data['entry_date'] = this.entryDate;
    data['verify_by'] = this.verifyBy;
    data['verify_by_name'] = this.verifyByName;
    data['verify_date'] = this.verifyDate;
    data['finalized_by'] = this.finalizedBy;
    data['finalized_by_name'] = this.finalizedByName;
    data['finalized_date'] = this.finalizedDate;
    return data;
  }
}
