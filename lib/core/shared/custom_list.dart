// ignore_for_file: non_constant_identifier_names

import 'package:agmc/model/model_common.dart';
 

import '../entity/company.dart';

List<Company> get_company_list() {
  List<Company> list = [];
  list.add(Company(id: '1', name: "Asgar Ali Hospital", logo: "logo_agh.png",address: '111/1/A, Distillery Road, Gandaria, Dhaka-1204, Bangladesh'));
  list.add(Company(
      id: '2',
      name: "Fazlur Rahman Nursing & Midwifery Institute",
      logo: "logo_frnmi.png",address: '111/1/A, Distillery Road, Gandaria, Dhaka-1204, Bangladesh'));
  list.add(Company(
      id: '3', name: "Asgar Ali Medical College", logo: "logo_aamc_last.png",address: '111/1/A, Distillery Road, Gandaria, Dhaka-1204, Bangladesh'));
  return list;
}

Future<List<ModelCommon>> get_month_List() async {
  List<dynamic> list = [
    {"id": 1, "name": "January"},
    {"id": 2, "name": "February"},
    {"id": 3, "name": "March"},
    {"id": 4, "name": "April"},
    {"id": 5, "name": "May"},
    {"id": 6, "name": "June"},
    {"id": 7, "name": "July"},
    {"id": 8, "name": "August"},
    {"id": 9, "name": "September"},
    {"id": 10, "name": "October"},
    {"id": 11, "name": "November"},
    {"id": 12, "name": "December"}
  ];
  return list.map((e) => ModelCommon.fromJson(e)).toList();
}

Future<List<ModelCommon>> get_year_List() async {
  List<ModelCommon> list = [];
  var dt = DateTime.now().year;
  for (var i = dt; i > 2022; i--) {
    list.add(ModelCommon(id: i.toString(), name: i.toString()));
    print(i);
  }
  return list;
}
