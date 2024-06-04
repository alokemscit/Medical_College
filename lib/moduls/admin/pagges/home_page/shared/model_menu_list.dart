import 'package:agmc/core/shared/user_data.dart';
import 'package:agmc/moduls/admin/pagges/login_page/model/user_model.dart';

class ModelModuleList {
  String? id;
  String? name;
  String? img;
  String? desc;
  ModelModuleList({this.id, this.name, this.img, this.desc});
}

Future<List<ModelModuleList>> get_module() async {
  User_Model user=await getUserInfo();

  List<ModelModuleList> list = [];
  list.add(ModelModuleList(
      id: "1283",
      name: "Human Resource Management",
      desc:
          "HR module manages staff, including  employee enrollment, roaster, and attendance records",
      img: "hrm"));
  list.add(ModelModuleList(
      id: "198",
      name: "Accounting & Finance",
      desc:
          "This Module involve managing financial transactions, reporting, analysis, and strategic planning",
      img: "billing"));

  list.add(ModelModuleList(
      id: "1301",
      name: "Production Management System (FnB)",
      desc:
          "This Module is specifically designed to optimize the production processes within the FnB Departmet",
      img: "housekeeping"));

      if(user.comID=='1'){
        list.add(ModelModuleList(
      id: "1313",
      name: "Diet Management System",
      desc:
          "This Module is help to manage Patients dietary",
      img: "diet"));

list.add(ModelModuleList(
      id: "1323",
      name: "App Dashboard",
      desc:
          "This Module is help to manage Doctor profile for mobile App",
      img: "doctor"));

      }

  return list;
}
