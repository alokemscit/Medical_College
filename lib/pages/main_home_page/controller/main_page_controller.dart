import 'package:asgar_ali_hospital/constant/const.dart';
import 'package:asgar_ali_hospital/data/data_api.dart';
import 'package:asgar_ali_hospital/pages/doctor_page/doctor_page_controller/model/model_doctor_unit.dart';
import 'package:get/get.dart';

class MainPageController extends GetxController {
  late data_api api;
  late BuildContext context;
  var list_docunit = <ModelDoctorUnit>[].obs;

 

  

  @override
  void onInit() async {
     
    api = data_api();
    try {
      var x = await api.createLead([
        {"tag": "57"}
      ]);

      list_docunit.addAll(x.map((e) => ModelDoctorUnit.fromJson(e)));

    



      print(x);
    } catch (e) {
      print(e);
    }
    super.onInit();
  }
}
