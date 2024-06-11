class ModelNsPatientList {
  String? hcn;
  String? regId;
  String? patName;
  String? sex;
  String? age;
  String? phone;
  String? bloodGroup;
  String? religion;
  String? fname;
  String? mname;
  String? floodNo;
  String? roomId;
  String? roomTitle;
  String? bedNo;
  String? bedTitle;
  String? deptId;
  String? deptName;
  String? unitId;
  String? unitTitle;
  String? docId;
  String? docName;
  String? hourDiff;
  String? sdmDate;
  String? sl;
  String? currentDiet;
  String? nsId;
  String? nsName;
  String? bedAdmDate;

  ModelNsPatientList(
      {this.hcn,
      this.regId,
      this.patName,
      this.sex,
      this.age,
      this.phone,
      this.bloodGroup,
      this.religion,
      this.fname,
      this.mname,
      this.floodNo,
      this.roomId,
      this.roomTitle,
      this.bedNo,
      this.bedTitle,
      this.deptId,
      this.deptName,
      this.unitId,
      this.unitTitle,
      this.docId,
      this.docName,
      this.hourDiff,
      this.sdmDate,
      this.sl,
      this.currentDiet,
      this.nsId,
      this.nsName,
      this.bedAdmDate});

  ModelNsPatientList.fromJson(Map<String, dynamic> json) {
    hcn = json['hcn'];
    regId = json['reg_id'];
    patName = json['pat_name'];
    sex = json['sex'];
    age = json['age'];
    phone = json['phone'];
    bloodGroup = json['blood_group'];
    religion = json['religion'];
    fname = json['fname'];
    mname = json['mname'];
    floodNo = json['flood_no'];
    roomId = json['room_id'];
    roomTitle = json['room_title'];
    bedNo = json['bed_no'];
    bedTitle = json['bed_title'];
    deptId = json['dept_id'];
    deptName = json['dept_name'];
    unitId = json['unit_id'];
    unitTitle = json['unit_title'];
    docId = json['doc_id'];
    docName = json['doc_name'];
    hourDiff = json['hour_diff'];
    sdmDate = json['sdm_date'];
    sl = json['sl'];
    currentDiet = json['current_diet'];
    nsId = json['ns_id'];
    nsName = json['ns_name'];
    bedAdmDate = json['bed_adm_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hcn'] = this.hcn;
    data['reg_id'] = this.regId;
    data['pat_name'] = this.patName;
    data['sex'] = this.sex;
    data['age'] = this.age;
    data['phone'] = this.phone;
    data['blood_group'] = this.bloodGroup;
    data['religion'] = this.religion;
    data['fname'] = this.fname;
    data['mname'] = this.mname;
    data['flood_no'] = this.floodNo;
    data['room_id'] = this.roomId;
    data['room_title'] = this.roomTitle;
    data['bed_no'] = this.bedNo;
    data['bed_title'] = this.bedTitle;
    data['dept_id'] = this.deptId;
    data['dept_name'] = this.deptName;
    data['unit_id'] = this.unitId;
    data['unit_title'] = this.unitTitle;
    data['doc_id'] = this.docId;
    data['doc_name'] = this.docName;
    data['hour_diff'] = this.hourDiff;
    data['sdm_date'] = this.sdmDate;
    data['sl'] = this.sl;
    data['current_diet'] = this.currentDiet;
    data['ns_id'] = this.nsId;
    data['ns_name'] = this.nsName;
    data['bed_adm_date'] = this.bedAdmDate;
    return data;
  }
}
