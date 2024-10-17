import 'package:agmc/core/config/const.dart';
import 'package:agmc/core/config/fun_excel.dart';

import '../../../../core/shared/user_data.dart';
import '../model/model_ledger_opening_balance.dart';

class GlOpeningBalanceController extends GetxController with MixInController {
  final TextEditingController txt_till_date = TextEditingController();

  var list_lg_opening_bal = <ModelLedgerOpeningBalance>[].obs;
  var list_lg_opening_bal_temp = <ModelLedgerOpeningBalance>[].obs;

  List<Map<String, TextEditingController>> controllers_txt = [];

  void updateCr(String id, double? cr) {
    if (cr == '' || cr == null) {
      cr = 0;
    }
    for (var e in list_lg_opening_bal_temp) {
      if (e.iD == id) {
        e.cR = cr;
      }
    }
  }

  void updateDr(String id, double? dr) {
    if (dr == '' || dr == null) {
      dr = 0;
    }
    for (var e in list_lg_opening_bal_temp) {
      if (e.iD == id) {
        e.dR = dr;
      }
    }
  }

  void test() {
    List<Map<String, dynamic>> jsonData = [];
   for (int i = 0; i < list_lg_opening_bal_temp.length; i++) {
  ModelLedgerOpeningBalance row = list_lg_opening_bal_temp[i];
  jsonData.add(row.toJson());
}
   // print(jsonData);
    //var x = list_lg_opening_bal_temp.toJson();
    //print(x);
    exportJsonToExcel(jsonData);

    //for (var e in list_lg_opening_bal_temp) {
    //print(e.iD! + e.nAME! + '  ' + e.dR!.toString());
    //}
  }

  @override
  void onInit() async {
    super.onInit();
    api = data_api();
    isError.value = false;
    isLoading.value = true;
    user.value = await getUserInfo();

    try {
      var x = await api.createLead([
        {"tag": "87", "p_cid": user.value.comID}
      ]);
      // print(x);
      list_lg_opening_bal
          .addAll(x.map((e) => ModelLedgerOpeningBalance.fromJson(e)));
      list_lg_opening_bal_temp.addAll(list_lg_opening_bal);

      for (var e in list_lg_opening_bal_temp) {
        controllers_txt.add({
          "dr": TextEditingController(text: e.dR!.toString()),
          "cr": TextEditingController(text: e.cR!.toString())
        });
      }
      // print(x);
      isLoading.value = false;
    } catch (e) {
      isError.value = true;
      isLoading.value = false;
      errorMessage.value = e.toString();
    }
  }

  @override
  void dispose() {
    // Dispose all text controllers
    //controllers_txt.clear();
    for (var controller in controllers_txt) {
      controller['dr']!.dispose();
      controller['cr']!.dispose();
    }
    controllers_txt.clear();
    list_lg_opening_bal.clear();
    list_lg_opening_bal_temp.clear();
    super.dispose();
  }
}
