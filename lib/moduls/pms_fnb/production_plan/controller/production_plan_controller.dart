import 'package:agmc/core/config/const.dart';

import 'package:agmc/core/shared/user_data.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';

import '../../../../model/model_status.dart';
import '../../goods_formula_setup/model/model_finished_goods_master.dart';
import '../model/model_prod_plan_list.dart';

class ProductionPlanController extends GetxController with MixInController {
  var list_item = <ModelFinishedGoodsList>[].obs;
  var list_item_temp = <ModelFinishedGoodsList>[].obs;
  var isSearch = false.obs;

  var list_temp_entry_item = <_item>[].obs;

  final TextEditingController txt_qty = TextEditingController();
  final TextEditingController txt_search_rawMaterials = TextEditingController();
  final TextEditingController txt_note = TextEditingController();
  final TextEditingController txt_production_date = TextEditingController();
  final TextEditingController txt_fdate = TextEditingController();
  final TextEditingController txt_tdate = TextEditingController();

  var selectedGoodsId = ''.obs;
  final FocusNode focusNode1 = FocusNode();

  var list_plan_details = <ModelProdPlanList>[].obs;
  var lis_plan_master = <_planList>[].obs;

  void viewPlanList() async {
    dialog = CustomAwesomeDialog(context: context);
    loader = CustomBusyLoader(context: context);
   
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
    var x = await api.createLead([
      {"tag": "95", "fdate": txt_fdate.text, "tdate": txt_tdate.text}
    ]);
    list_plan_details.clear();
    list_plan_details.addAll(x.map((e) => ModelProdPlanList.fromJson(e)));

    //List<_planList> list = [];
    List<_planList> list = list_plan_details
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

  void saveData() async {
    dialog = CustomAwesomeDialog(context: context);
    if (list_temp_entry_item.isEmpty) {
      dialog
        ..dialogType = DialogType.warning
        ..message = 'No Food item found for production plan!'
        ..show();
      return;
    }
    var s = '';
    list_temp_entry_item.forEach((element) {
      s += '${element.id},${element.qty};';
    });

    // print({
    //   "tag": "94",
    //   "p_id": "0",
    //   "p_empid": user.value.eMPID,
    //   "p_note": txt_note.text,
    //   "p_date": txt_production_date.text,
    //   "p_string": s
    // });

    var x = await api.createLead([
      {
        "tag": "94",
        "p_id": "0",
        "p_empid": user.value.eMPID,
        "p_note": txt_note.text,
        "p_date": txt_production_date.text,
        "p_string": s
      }
    ]);
    ModelStatus st = await getStatusWithDialog(x, dialog);
    if (st.status == '1') {
      dialog
        ..dialogType = DialogType.success
        ..message = '${st.msg!} Plan No: ${st.extra!}'
        ..show()
        ..onTap = () {
          list_temp_entry_item.clear();
        };
    }
  }

  void addItem() {
    dialog = CustomAwesomeDialog(context: context);
    if (selectedGoodsId.value.isEmpty) {
      dialog
        ..dialogType = DialogType.warning
        ..message = 'Please Select Goods Name'
        ..show();
      return;
    }
    if (txt_qty.text.isEmpty) {
      dialog
        ..dialogType = DialogType.warning
        ..message = 'Goods quantity required!'
        ..show();
      return;
    }

    if (list_temp_entry_item
        .where((p0) => p0.id == selectedGoodsId.value)
        .isNotEmpty) {
      dialog
        ..dialogType = DialogType.warning
        ..message = 'This Goods already exists!'
        ..show();
      return;
    }

    list_temp_entry_item.add(_item(
        id: selectedGoodsId.value,
        name: list_item
            .where((p0) => p0.fOODID == selectedGoodsId.value)
            .first
            .fOODNAME!,
        unit: 'unit',
        qty: txt_qty.text));

    selectedGoodsId.value = '';
    txt_qty.text = '';
    serarchGoods();
  }

  void deleteItem(String id) {
    list_temp_entry_item.removeWhere((element) => element.id == id);
  }

  void serarchGoods() {
    list_item_temp.clear();
    list_item_temp.addAll(list_item.where((p0) => p0.fOODNAME!
        .toUpperCase()
        .contains(txt_search_rawMaterials.text.toUpperCase())));
  }

  @override
  void onInit() async {
    //await super.init();
    isLoading.value = true;
    api = data_api();
    user.value = await getUserInfo();
    if (user.value.eMPID == null) {
      isError.value = true;
      isLoading.value = false;
      errorMessage.value = 'Re-Login Required';
      return;
    }

    try {
      var x = await api.createLead([
        {"tag": "90"}
      ]);
      list_item.addAll(x.map((e) => ModelFinishedGoodsList.fromJson(e)));
      list_item_temp.addAll(list_item);

      isLoading.value = false;
    } catch (e) {
      isError.value = true;
      isLoading.value = false;
      errorMessage.value = e.toString();
    }
    super.onInit();
  }

  @override
  void onClose() {
    // txt_note.dispose();
    // txt_production_date.dispose();
    // txt_qty.dispose();
    txt_search_rawMaterials.dispose();
    list_item.close();
    list_item_temp.close();
    list_temp_entry_item.close();
    // txt_tdate.dispose();
    // txt_tdate.dispose();

    super.onClose();
  }
}

class _item {
  final String id;
  final String name;
  final String unit;
  final String qty;
  _item(
      {required this.id,
      required this.name,
      required this.unit,
      required this.qty});
}

class _planList extends Equatable {
  final String id;
  final String pno;
  final String edate;
  final String pdate;
  final String note;
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
