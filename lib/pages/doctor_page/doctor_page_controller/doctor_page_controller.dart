// ignore_for_file: non_constant_identifier_names

import 'package:asgar_ali_hospital/constant/const.dart';
import 'package:asgar_ali_hospital/data/data_api.dart';
import 'package:asgar_ali_hospital/data/data_docror_image.dart';
 
import 'package:asgar_ali_hospital/pages/doctor_page/doctor_page_controller/model/model_doctor_unit.dart';
import 'package:asgar_ali_hospital/pages/main_home_page/model/model_doctor_master.dart';
import 'package:get/get.dart';

class DoctorPageController extends GetxController {
  late BuildContext context;
  late data_api api;
  var list_docunit = <ModelDoctorUnit>[].obs;
  var isLoading = false.obs;
  var selectedUnit = ''.obs;
  var list_doctor_master = <ModelDoctorMaster>[].obs;
  var list_doctor_master_temp = <ModelDoctorMaster>[].obs;
  final TextEditingController txt_search = TextEditingController();
  late ModelDoctorMaster doctorMaster;

  void search() {
    selectedUnit.value = '';
    var t = list_doctor_master.where((p0) =>
        p0.dOCTORNAME!.toUpperCase().contains(txt_search.text.toUpperCase()) ||
        p0.uNIT!.toUpperCase().contains(txt_search.text.toUpperCase()));
    list_doctor_master_temp.clear();
    list_doctor_master_temp.addAll(t);
  }

  void unitClick() {
    if (selectedUnit.value == '0') {
      list_doctor_master_temp.clear();
      list_doctor_master_temp.addAll(list_doctor_master);
      return;
    }
    var t = list_doctor_master.where((p0) => p0.uNINTID == selectedUnit.value);
    list_doctor_master_temp.clear();
    list_doctor_master_temp.addAll(t);
  }

  @override
  void onInit() async {
    api = data_api();
    try {
      isLoading.value = true;
      var x = await api.createLead([
        {"tag": "57"}
      ]);
      list_docunit.addAll(x.map((e) => ModelDoctorUnit.fromJson(e)));
      list_docunit.insert(0, ModelDoctorUnit(NITID: "0", NITTITLE: "All"));
      x = await api.createLead([
        {"tag": "63"}
      ]);
      var img = await getDoctorImageList();
     // print(x);
      var t = x.map((e) => ModelDoctorMaster.fromJson(e)).toList();

      for (var item1 in t) {
        var image = img.firstWhere((item2) => item2.id == item1.dOCID,
            orElse: () => DoctorImage(
                id: item1.dOCID,
                image:
                    "https://web.asgaralihospital.com/assets/img/media-user.png"));
        item1.iMAGE = image.image!;
        list_doctor_master.add(item1);
      }
      list_doctor_master_temp.addAll(list_doctor_master);

         
         



      isLoading.value = false;
    
    
    } catch (e) {
      isLoading.value = false;
    }
    super.onInit();
  }
}
