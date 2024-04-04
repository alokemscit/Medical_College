  

class ModelVoucherView {
  String? iD;
  String? vNO;
  String? vDATE;
  String? vTYPE;
  String? lNAME;
  String? vAMOUNT;
  String? sTATUS;
  String? iSPOSTED;

  ModelVoucherView(
      {this.iD,
      this.vNO,
      this.vDATE,
      this.vTYPE,
      this.lNAME,
      this.vAMOUNT,
      this.sTATUS,
      this.iSPOSTED});

  ModelVoucherView.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    vNO = json['VNO'];
    vDATE = json['VDATE'];
    vTYPE = json['VTYPE'];
    lNAME = json['LNAME'];
    vAMOUNT = json['VAMOUNT'].toString();
    sTATUS = json['STATUS'];
    iSPOSTED = json['ISPOSTED'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['VNO'] = this.vNO;
    data['VDATE'] = this.vDATE;
    data['VTYPE'] = this.vTYPE;
    data['LNAME'] = this.lNAME;
    data['VAMOUNT'] = this.vAMOUNT;
    data['STATUS'] = this.sTATUS;
    data['ISPOSTED'] = this.iSPOSTED;
    return data;
  }
}
