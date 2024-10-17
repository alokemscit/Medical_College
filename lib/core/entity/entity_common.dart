class EntityCommon {
   String? id;
   String? name;
  EntityCommon({ this.id,  this.name});

   EntityCommon.fromJson(Map<String, dynamic> json) {
    id = json['ID'];
    name = json['NAME'];
  }
}
