class ModelPackageMaster {
  String? id;
  String? name;
  String? des;
  double? rate;
  double? accRate;
  String? sl;

  ModelPackageMaster(
      {this.id, this.name, this.des, this.rate, this.accRate, this.sl});

  ModelPackageMaster.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    des = json['des'];
    rate = json['rate'];
    accRate = json['acc_rate'];
    sl = json['sl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['des'] = des;
    data['rate'] = rate;
    data['acc_rate'] = accRate;
    data['sl'] = sl;
    return data;
  }
}
