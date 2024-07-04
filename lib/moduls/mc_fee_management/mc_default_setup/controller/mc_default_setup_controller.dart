import 'package:agmc/core/config/const.dart';
import 'package:agmc/core/shared/user_data.dart';

import '../../../../model/model_common.dart';
import '../../../../model/model_status.dart';

class McDefaultSetupController extends GetxController with MixInController {
  var list_payment_type = <ModelCommon>[].obs;
  var list_fee_master_main = <_ModelFeeMaster>[].obs;
  var list_fee_master_temp = <_ModelFeeTemp>[].obs;
  var selectedFeeTypeID = ''.obs;

  void save() async {
    loader = CustomBusyLoader(context: context);
    loader.show();
    dialog = CustomAwesomeDialog(context: context);
    var s = '';
    list_fee_master_temp.forEach((f) {
      s +=
          "${f.id}^${(f.amount == null || f.amount == '') ? "0" : f.amount}^${(f.isChk == false) ? "0" : "1"};";
    });
    try {
      // print({"tag": "132", "p_typeid": selectedFeeTypeID.value, "p_str": s});
      var x = await api.createLead([
        {"tag": "132", "p_typeid": selectedFeeTypeID.value, "p_str": s}
      ]);
      loader.close();
      ModelStatus st = await getStatusWithDialog(x, dialog);
      if (st.status == '1') {
        dialog
          ..dialogType = DialogType.success
          ..message = st.msg!
          ..show();

        list_fee_master_temp.forEach((f) {
          list_fee_master_main.removeWhere((t) => t.id == f.id);
          list_fee_master_main.add(_ModelFeeMaster(
              id: f.id,
              name: f.name,
              typeId: f.typeId,
              typeName: f.typeName,
              ischk: f.isChk == true ? "1" : "0",
              amount: f.amount));
        });
      }
    } catch (e) {
      loader.close();
      dialog
        ..dialogType = DialogType.error
        ..message = e.toString()
        ..show();
    }
    // print(s);
  }

  void updateCheck(_ModelFeeTemp x, bool b) {
    list_fee_master_temp.where((f) => f.id == x.id).first.isChk = b;
    list_fee_master_temp.refresh();
  }

  void load() {
    list_fee_master_temp.clear();
    var t =
        list_fee_master_main.where((f) => f.typeId == selectedFeeTypeID.value);
    t.forEach((t) {
      list_fee_master_temp.add(_ModelFeeTemp(
          id: t.id,
          name: t.name,
          typeId: t.typeId,
          typeName: t.typeName,
          amount: t.amount,
          amt: CustomTextBox(
              borderColor: Colors.transparent,
              enabledBorderColor: Colors.transparent,
              caption: "",
              textInputType: TextInputType.number,
              textAlign: TextAlign.end,
              controller: TextEditingController(
                  text: (t.amount == null || t.amount == "0") ? "" : t.amount),
              onChange: (v) {
                list_fee_master_temp.where((e) => e.id == t.id).first.amount =
                    v;
                list_fee_master_temp.refresh();
              }),
          isChk: t.ischk == '0' ? false : true));
    });
  }

  @override
  void onInit() async {
    api = data_api();
    isLoading.value = true;
    list_payment_type.add(ModelCommon(id: '1', name: "Income"));
    list_payment_type.add(ModelCommon(id: '2', name: "Expense"));
    user.value = await getUserInfo();
    if (user.value.eMPID == null) {
      isLoading.value = false;
      isError.value = true;
      errorMessage.value = 'Re-login required!';
      return;
    }
    try {
      var x = await api.createLead([
        {"tag": "131","p_cid":user.value.comID}
      ]);
      if (x != [] ||
          x.map((e) => ModelStatus.fromJson(e)).first.status != '3') {
        list_fee_master_main.addAll(x.map((e) => _ModelFeeMaster.fromJson(e)));
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      isError.value = true;
      errorMessage.value = e.toString();
    }
    super.onInit();
  }
}

class _ModelFeeMaster {
  String? id;
  String? name;
  String? typeId;
  String? typeName;
  String? amount;
  String? ischk;

  _ModelFeeMaster(
      {this.id,
      this.name,
      this.typeId,
      this.typeName,
      this.amount,
      this.ischk});

  _ModelFeeMaster.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    typeId = json['type_id'];
    typeName = json['type_name'];
    amount = json['amount'];
    ischk = json['ischk'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['type_id'] = this.typeId;
    data['type_name'] = this.typeName;
    data['amount'] = this.amount;
    data['ischk'] = this.ischk;
    return data;
  }
}

class _ModelFeeTemp {
  String? id;
  String? name;
  String? typeId;
  String? typeName;
  String? amount;
  CustomTextBox? amt;
  bool? isChk;
  _ModelFeeTemp(
      {this.id,
      this.name,
      this.typeId,
      this.typeName,
      this.amt,
      this.isChk,
      this.amount});
}
