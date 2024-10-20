class ModelDietAssignedApprovedNs {
  String? assignId;
  String? nsId;
  String? nsName;
  String? appBy;
  String? appDate;
  String? appByName;

  ModelDietAssignedApprovedNs(
      {this.assignId,
      this.nsId,
      this.nsName,
      this.appBy,
      this.appDate,
      this.appByName});

  ModelDietAssignedApprovedNs.fromJson(Map<String, dynamic> json) {
    assignId = json['assign_id'];
    nsId = json['ns_id'];
    nsName = json['ns_name'];
    appBy = json['app_by'];
    appDate = json['app_date'];
    appByName = json['app_by_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['assign_id'] = this.assignId;
    data['ns_id'] = this.nsId;
    data['ns_name'] = this.nsName;
    data['app_by'] = this.appBy;
    data['app_date'] = this.appDate;
    data['app_by_name'] = this.appByName;
    return data;
  }
}
