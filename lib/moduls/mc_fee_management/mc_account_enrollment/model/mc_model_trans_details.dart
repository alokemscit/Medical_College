class MadelTransactionDetails {
  String? collBy;
  String? collByName;
  String? stId;
  String? stNo;
  String? stName;
  String? stRoll;
  String? sesName;
  String? headtypeId;
  String? headtypeName;
  String? trnsNo;
  String? trnsNote;
  String? entryDate;
  String? collDate;
  double? amt;
  String? colltype;

  MadelTransactionDetails(
      {this.collBy,
      this.collByName,
      this.stId,
      this.stNo,
      this.stName,
      this.stRoll,
      this.sesName,
      this.headtypeId,
      this.headtypeName,
      this.trnsNo,
      this.trnsNote,
      this.entryDate,
      this.collDate,
      this.amt,
      this.colltype});

  MadelTransactionDetails.fromJson(Map<String, dynamic> json) {
    collBy = json['coll_by'];
    collByName = json['coll_by_name'];
    stId = json['st_id'];
    stNo = json['st_no'];
    stName = json['st_name'];
    stRoll = json['st_roll'];
    sesName = json['ses_name'];
    headtypeId = json['headtype_id'];
    headtypeName = json['headtype_name'];
    trnsNo = json['trns_no'];
    trnsNote = json['trns_note'];
    entryDate = json['entry_date'];
    collDate = json['coll_date'];
    amt = json['amt'];
    colltype = json['colltype'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['coll_by'] = collBy;
    data['coll_by_name'] = collByName;
    data['st_id'] = stId;
    data['st_no'] = stNo;
    data['st_name'] = stName;
    data['st_roll'] = stRoll;
    data['ses_name'] = sesName;
    data['headtype_id'] = headtypeId;
    data['headtype_name'] = headtypeName;
    data['trns_no'] = trnsNo;
    data['trns_note'] = trnsNote;
    data['entry_date'] = entryDate;
    data['coll_date'] = collDate;
    data['amt'] = amt;
    data['colltype'] = colltype;
    return data;
  }
}
