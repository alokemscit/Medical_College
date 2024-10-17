import 'package:asgar_ali_hospital/common_model/model_status.dart';
import 'package:asgar_ali_hospital/constant/const.dart';
import 'package:asgar_ali_hospital/custom_widget/custom_awesome_dialog.dart';
import 'package:asgar_ali_hospital/custom_widget/custom_bysy_loader.dart';
import 'package:asgar_ali_hospital/custom_widget/pdf_viewer.dart';
import 'package:asgar_ali_hospital/data/data_api.dart';
import 'package:asgar_ali_hospital/data/data_static_user.dart';
import 'package:asgar_ali_hospital/pages/lab_report_page/model/model_inv_pres.dart';
import 'package:asgar_ali_hospital/pages/lab_report_page/model/model_mob_hcn.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PrescriptionPageController extends GetxController {
  late BuildContext context;
  late data_api api;
  late CustomAwesomeDialog dialog;
  late CustomBusyLoader loader;
  var isLoading = false.obs;
  var isLoadingInv = false.obs;
  var list_pat_with_hcn = <ModelPatWithHCN>[].obs;
  var list_inv_pres_with_hcn = <ModelInvPresWithHCN>[].obs;
  var selectedHCN = ''.obs;






void viewPrescription(ModelInvPresWithHCN e) async {
    loader = CustomBusyLoader(context: context);
    dialog = CustomAwesomeDialog(context: context);
    try {
      loader.show();
      api.createLead([
        {"pid": e.rID, "did": e.dOCID}
      ], "get_pdf_prescription").then((value) {
        loader.close();

        if (value != []) {
          //print(value);
          ModelStatus s = value.map((e) => ModelStatus.fromJson_2(e)).first;
          //print(s.msg);
          if (s.status != "1") {
            dialog
              ..dialogType = DialogType.error
              ..message = s.msg!
              ..show();
            return;
          }
          String urls =
              "https://web.asgaralihospital.com/OtherProject/PatientReport/pub/${s.msg!}.pdf";

          Navigator.push(
            context,
            MaterialPageRoute<dynamic>(
              builder: (_) => PDFViewerFromUrl(
                url: urls,
              ),
            ),
          );
        }
      });
    } catch (e) {
      loader.close();
      dialog
        ..dialogType = DialogType.error
        ..message = e.toString()
        ..show();
    }
  }










  void loadPrescription() async {
    loader = CustomBusyLoader(context: context);
    dialog = CustomAwesomeDialog(context: context);
    try {
      isLoadingInv.value = true;
      // list_inv_list.clear();
      list_inv_pres_with_hcn.clear();
      // loader.show();
      var x = await api.createLead([
        {"tag": "13", "hcn": selectedHCN.value}
      ]);
      // print(x);
      list_inv_pres_with_hcn.addAll(x
          .map((e) => ModelInvPresWithHCN.fromJson(e))
          .where((element) => element.tP == 'prs'));

      list_inv_pres_with_hcn.sort((a, b) => DateFormat("dd/MM/yyyy")
          .parse(b.dT!)
          .compareTo(DateFormat("dd/MM/yyyy").parse(a.dT!)));

    
      isLoadingInv.value = false;
    } catch (e) {
      //loader.close();
      isLoadingInv.value = false;
      dialog
        ..dialogType = DialogType.error
        ..message = e.toString()
        ..show();
    }
  }

  @override
  void onInit() async {
    super.onInit();
    api = data_api();
    try {
      isLoading.value = true;
      var x = await api.createLead([
        {"tag": "14", "mob": DataStaticUser.mob}
      ]);
      list_pat_with_hcn.addAll(x.map((e) => ModelPatWithHCN.fromJson(e)));
      // selectedHCN.value = DataStaticUser.hcn;
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
    }
  }
}
