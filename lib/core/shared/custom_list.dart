// ignore_for_file: non_constant_identifier_names

import '../entity/company.dart';
  List<Company> get_company_list()  {
  List<Company> list = [];
 list.add(Company(id: '1',name: "Asgar Ali Hospital",logo: "logo_agh.png"));
 list.add(Company(id: '2',name: "Fazlur Rahman Nursing & Midwifery Institute",logo: "logo_frnmi.png"));
 list.add(Company(id: '3',name: "Asgar Ali Medical College",logo: "logo_aamc.png"));
 return list;
}

