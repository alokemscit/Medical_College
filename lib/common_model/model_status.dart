
class ModelStatus {
  String? status;
  String? msg;
  String? id;
  String? extra;

  ModelStatus({
    this.status,
    this.msg,
    this.id,
    this.extra,
  });

  ModelStatus.fromJson(Map<String, dynamic> json) {
    status = json['STATUS'].toString();
    msg = json['MSG'];
    id = json['ID'].toString();
    extra = json['EXTRA'].toString();
  }

  ModelStatus.fromJson_2(Map<String, dynamic> json) {
    status = json['status'].toString();
    msg = json['msg'];
    id = json['id'].toString();
    extra = json['extra'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['STATUS'] = status;
    data['MSG'] = msg;
    data['ID'] = id;
     data['EXTRA'] = extra;
    return data;
  }
}
