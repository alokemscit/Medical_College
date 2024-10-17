// ignore_for_file: non_constant_identifier_names

import 'package:asgar_ali_hospital/constant/const.dart';
import 'package:asgar_ali_hospital/data/data_api.dart';
import 'package:asgar_ali_hospital/data/data_static_user.dart';
import 'package:asgar_ali_hospital/pages/login_page/auth_provider/auth-provider.dart';
import 'package:asgar_ali_hospital/pages/login_page/login_page.dart';
import 'package:asgar_ali_hospital/pages/main_home_page/controller/main_home_page_controller.dart';
import 'package:asgar_ali_hospital/pages/main_home_page/model/model_doctor_master.dart';

import 'package:get/get.dart';

import '../../../common_model/model_mysql_doctor.dart';

class HomePageController extends GetxController {
  var isLoading = false.obs;
  late data_api api;
  late BuildContext context;

  var currentIndex = 0.obs;
   var list_doctor_mysql=<ModelMySqlDoctor>[].obs;

  void viewAll() {
    MainHomePagaeController c = Get.find<MainHomePagaeController>();
    c.currentIndex.value = 1;
  }

  var list_doctor_master = <ModelDoctorMaster>[].obs;

  List<String> imgList = [
    "assets/images/slide1.webp",
    "assets/images/slide2.webp",
    "assets/images/slide3.webp",
  ];

  @override
  void onInit() async {
    isLoading.value = true;
    api = data_api();
    try {
      var x = await api.createLead([
        {"tag": "63"}
      ]);

      list_doctor_master.addAll(x.map((e) => ModelDoctorMaster.fromJson(e)));
      isLoading.value = false;
      print('doctor call from oracle');
      if(DataStaticUser.doc_list==[]){
      var y= await api.get_mysql_doctor();
      DataStaticUser.doc_list=y.map((e) => ModelMySqlDoctor.fromJson(e)).toList();
      }
      
    //print(y);
      // print(x);
    } catch (e) {
      isLoading.value = false;
    }
    super.onInit();
  }

  void logoClick() {
    if (DataStaticUser.hcn == '') {
      Get.to(() => const LoginPage());
    } else {
      CustomCupertinoAlertWithYesNo(context, const Text("Alert"),
          const Text("Are you sure to Log Out?"), () {}, () {
        AuthProvider().logout();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      });
    }
  }
}
