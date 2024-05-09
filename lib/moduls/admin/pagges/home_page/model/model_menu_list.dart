class ModelModuleList {
  String? id;
  String? name;
  String? img;
  String? desc;
  ModelModuleList({this.id, this.name, this.img, this.desc});
}

Future<List<ModelModuleList>> get_module() async {
  List<ModelModuleList> list = [];
  list.add(ModelModuleList(
      id: "1283", name: "Human Resource Management", desc: "HR module manages staff, including  employee enrollment, roaster, and attendance records", img: "hrm"));
      list.add(ModelModuleList(
      id: "198", name: "Accounting & Finance", desc: "This Module involve managing financial transactions, reporting, analysis, and strategic planning", img: "billing"));
  list.add(ModelModuleList(
      id: "1301", name: "Production Management System (FnB)", desc: "This Module is specifically designed to optimize the production processes within the FnB Departmet", img: "housekeeping"));
  
  
  return list;
}

