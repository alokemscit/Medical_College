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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['hcn'] = hcn;
    data['reg_id'] = regId;
    data['pat_name'] = patName;
    data['sex'] = sex;
    data['age'] = age;
    data['phone'] = phone;
    data['blood_group'] = bloodGroup;
    data['religion'] = religion;
    data['fname'] = fname;
    data['mname'] = mname;
    data['flood_no'] = floodNo;
    data['room_id'] = roomId;
    data['room_title'] = roomTitle;
    data['bed_no'] = bedNo;
    data['bed_title'] = bedTitle;
    data['dept_id'] = deptId;
    data['dept_name'] = deptName;
    data['unit_id'] = unitId;
    data['unit_title'] = unitTitle;
    data['doc_id'] = docId;
    data['doc_name'] = docName;
    data['hour_diff'] = hourDiff;
    data['sdm_date'] = sdmDate;
    data['sl'] = sl;
    data['current_diet'] = currentDiet;
    data['ns_id'] = nsId;
    data['ns_name'] = nsName;
    data['bed_adm_date'] = bedAdmDate;
    return data;
  }
}
