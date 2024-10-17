class ModelTransDataAllMC {
  String? id;
  String? stNo;
  String? stName;
  String? roll;
  String? stId;
  String? feeTypeId;
  String? feeTypeBname;
  String? trnsDetails;
  String? tillDate;
  String? trnsNo;
  double? dr;
  double? cr;
  String? trnsDate;
  String? sesName;

  ModelTransDataAllMC(
      {this.id,
      this.stNo,
      this.stName,
      this.roll,
      this.stId,
      this.feeTypeId,
      this.feeTypeBname,
      this.trnsDetails,
      this.tillDate,
      this.trnsNo,
      this.dr,
      this.cr,
      this.trnsDate,
      this.sesName});

  ModelTransDataAllMC.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    stNo = json['st_no'];
    stName = json['st_name'];
    roll = json['roll'];
    stId = json['st_id'];
    feeTypeId = json['fee_type_id'];
    feeTypeBname = json['fee_type_bname'];
    trnsDetails = json['trns_details'];
    tillDate = json['till_date'];
    trnsNo = json['trns_no'];
    dr = json['dr'];
    cr = json['cr'];
    trnsDate = json['trns_date'];
    sesName = json['ses_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['st_no'] = stNo;
    data['st_name'] = stName;
    data['roll'] = roll;
    data['st_id'] = stId;
    data['fee_type_id'] = feeTypeId;
    data['fee_type_bname'] = feeTypeBname;
    data['trns_details'] = trnsDetails;
    data['till_date'] = tillDate;
    data['trns_no'] = trnsNo;
    data['dr'] = dr;
    data['cr'] = cr;
    data['trns_date'] = trnsDate;
     data['ses_name'] = sesName;
    return data;
  }
}
