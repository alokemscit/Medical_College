// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:agmc/core/config/const.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

import '../../../../core/shared/user_data.dart';
import '../../../../model/model_common.dart';
import '../../diet_approval/model/model_diet_approved_ns.dart';
import '../../diet_assign/model/model_diet_item_summary.dart';
import '../../shared/diet_common_function.dart';

class DietKotFinalizationController extends GetxController
    with MixInController {
  var selectedDiettypeID = ''.obs;
  var selectedWeekID = ''.obs;
  var selectedTimeID = ''.obs;
  var selectedTabID = ''.obs;

  final TextEditingController txt_date = TextEditingController();
  var list_diet_type = <ModelCommon>[].obs;
  var list_week = <ModelCommon>[].obs;
  var list_time = <ModelCommon>[].obs;
  var list_diet_approved_ns = <ModelDietAssignedApprovedNs>[].obs;
  var list_ns = <ModelCommon>[].obs;
  var list_diet_summ = <ModelDietAssignedSummaryData>[].obs;

  var list_menu_sort = <_m>[].obs;

  void loadData() async {
    loader = CustomBusyLoader(context: context);

    dialog = CustomAwesomeDialog(context: context);
    list_diet_approved_ns.clear();
    list_diet_summ.clear();
    list_menu_sort.clear();
    if (txt_date.text == '' ||
        selectedTimeID.value == '' ||
        selectedDiettypeID.value == '') {
      return;
    }

    try {
      loader.show();
      var y = (DateFormat('dd/MM/yyyy').parse(txt_date.text).weekday % 7 + 1)
          .toString();

      await mLoadModel_All(
          api,
          [
            {
              "tag": "22",
              "p_date": txt_date.text,
              "p_day_id": y,
              "p_time_id": selectedTimeID.value,
              "p_diet_type_id": selectedDiettypeID.value,
              "p_ns_id": "0",
            }
          ],
          list_diet_approved_ns,
          (e) => ModelDietAssignedApprovedNs.fromJson(e),
          'getdata_ipd');

      await mLoadModel_All(
          api,
          [
            {
              "tag": "21",
              "p_date": txt_date.text,
              "p_day_id": y,
              "p_time_id": selectedTimeID.value,
              "p_diet_type_id": selectedDiettypeID.value,
              "ns_id": "0"
            }
          ],
          list_diet_summ,
          (e) => ModelDietAssignedSummaryData.fromJson(e),
          'getdata_ipd');
      List<_m> list = [];
      list_diet_approved_ns.forEach((f) {
        list_diet_summ.where((e) => e.nsId == f.nsId).forEach((a) {
          list.add(_m(nsid: a.nsId,nsname: a.nsName,menuId: a.menuId,menuName: a.menuName));
        });
      });
      list_menu_sort.addAll(list.toSet().toList());

      loader.close();
    } catch (e) {
      loader.close();
      dialog
        ..dialogType = DialogType.error
        ..message = e.toString()
        ..show();
    }
  }

  @override
  void onInit() async {
    isLoading.value = true;
    api = data_api();
    user.value = await getUserInfo();
    if (!await isValidLoginUser(this)) return;
    try {
      font.value = await CustomLoadFont(appFontPathRoboto);

      await Diet_Get_DietType(api, list_diet_type);

      await Diet_Get_DietWeek(api, list_week);

      await Diet_Get_DietTime(api, list_time);

      //await Diet_Get_NurseStation(api, lis_nurse_station);

      // await mLoadModel_All(
      //     api,
      //     [
      //       {"tag": "20"}
      //     ],
      //     list_ns,
      //     (e) => ModelCommon.fromJson(e),
      //     'getdata_ipd');
      isLoading.value = false;
    } catch (e) {
      CustomInitError(this, e.toString());
    }
    super.onInit();
  }
}

class _m extends Equatable{
  String? nsid;
  String? nsname;
  String? menuId;
  String? menuName;
  _m({
    this.nsid,
    this.nsname,
    this.menuId,
    this.menuName,
  });
  
  @override
 
  List<Object?> get props => [nsid,nsname,menuId,menuName];
}
