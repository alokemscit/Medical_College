import 'package:agmc/core/config/const.dart';
import 'package:agmc/core/shared/user_data.dart';
import 'package:agmc/model/model_common.dart';
import 'package:equatable/equatable.dart';

import '../../production_plan/model/model_prod_plan_list.dart';

class PlanApprovalController extends GetxController with MixInController {
  var list_type = <ModelCommon>[].obs;
  var selecTedTypeId = ''.obs;
  var list_plan_details = <ModelProdPlanList>[].obs;
  var lis_plan_master = <_planList>[].obs;

  final TextEditingController txt_fdate = TextEditingController();
  final TextEditingController txt_tdate = TextEditingController();

  var selectedplanID = ''.obs;

  void viewPlanList() async {
    dialog = CustomAwesomeDialog(context: context);
    loader = CustomBusyLoader(context: context);

    if (selecTedTypeId.value == '') {
      dialog
        ..dialogType = DialogType.warning
        ..message = 'Please select type!'
        ..show();
      return;
    }

    bool b = isValidDateRange(txt_fdate.text, txt_tdate.text);
    if (!b) {
      //loader.close();
      dialog
        ..dialogType = DialogType.warning
        ..message = 'Invalid Date Range!!'
        ..show();
      return;
    }
    loader.show();
   // print({"tag": "95", "fdate": txt_fdate.text, "tdate": txt_tdate.text});
    var x = await api.createLead([
      {"tag": "95", "fdate": txt_fdate.text, "tdate": txt_tdate.text}
    ]);
    list_plan_details.clear();
    list_plan_details.addAll(x.map((e) => ModelProdPlanList.fromJson(e)));
    //print(list_plan_details.length);  
//print(x);
    //List<_planList> list = [];
    List<_planList> list = list_plan_details
        .where((p0) => p0.sTATUS == selecTedTypeId.value)
        .map((element) => _planList(
              id: element.iD!,
              edate: element.eNTRYDATE!,
              note: element.nOTE!,
              pdate: element.pRODDATE!,
              pno: element.pLANNO!,
              status: element.sTATUS == '1'
                  ? 'Not Approved'
                  : element.sTATUS == '2'
                      ? 'Approved'
                      : 'Canceled',
            ))
        .toSet()
        .toList();

    lis_plan_master
      ..clear()
      ..addAll(list);
    loader.close();
    //print(lis_plan_master.length);
  }

  @override
  void onInit() async {
    isLoading.value = true;
    api = data_api();
    user.value = await getUserInfo();
    if (user.value.eMPID == null) {
      errorMessage.value = 'Re-loging requird!';
      isError.value = true;
      isLoading.value = false;
      return;
    }
    list_type.addAll([
      ModelCommon(id: "1", name: "Pending"),
      ModelCommon(id: "2", name: "Approved"),
      ModelCommon(id: "0", name: "Canceled")
    ]);
    isLoading.value = false;
    super.onInit();
  }
}

class _planList extends Equatable {
  final String id;
  final String pno;
  final String edate;
  final String pdate;
  final String? note;
  final String status;

  _planList({
    required this.id,
    required this.pno,
    required this.edate,
    required this.pdate,
    required this.note,
    required this.status,
  });

  @override
  List<Object?> get props => [id, pno, edate, pdate, note, status];
}
