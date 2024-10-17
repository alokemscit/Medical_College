class ModelFeesMasterMC {
  String? id;
  String? name;
  String? typeId;
  String? typeName;
  String? amount;
  String? catID;
   String? type;
  ModelFeesMasterMC(
      {this.id,
      this.name,
      this.typeId,
      this.typeName,
      this.amount,
      this.catID,this.type});

  ModelFeesMasterMC.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    typeId = json['type_id'];
    typeName = json['type_name'];
    amount = json['amount'];
    catID = json['cat_id'];
    type = json['type'].toString();
  }

   
}