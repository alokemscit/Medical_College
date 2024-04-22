class ModelVoucherApprover {
  String? iD;
  String? aID;
  String? aNAME;
  String? eMPID;
  String? eNAME;
  String? sTATUS;

  ModelVoucherApprover(
      {this.iD, this.aID, this.aNAME, this.eMPID, this.eNAME, this.sTATUS});

  ModelVoucherApprover.fromJson(Map<String, dynamic> json) {
     iD = json['ID'];
    aID = json['AID'];
    aNAME = json['ANAME'];
    eMPID = json['EMP_ID'];
    eNAME = json['ENAME'];
    sTATUS = json['STATUS'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['AID'] = this.aID;
  //   data['ANAME'] = this.aNAME;
  //   data['EMP_ID'] = this.eMPID;
  //   data['ENAME'] = this.eNAME;
  //   data['STATUS'] = this.sTATUS;
  //   return data;
  // }
}
