// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:agmc/core/config/const.dart';
import 'package:agmc/core/shared/user_data.dart';
import 'package:equatable/equatable.dart';

import '../../../../model/model_common.dart';
import '../../../../model/model_status.dart';
import '../model/mc_model_fees_master.dart';

class McDefaultSetupController extends GetxController with MixInController {
  // var list_payment_type = <ModelCommon>[].obs;
  var list_fee_master_main = <ModelFeesMasterMC>[].obs;
  var list_fee_master_temp = <_ModelFeeTemp>[].obs;
  var selectedFeeTypeID = ''.obs;
  var list_tab = <ModelCommon>[].obs;
  var _list_head = <_head>[].obs;
  var isRegular = true.obs;
  var selectedTabIndex = '1'.obs;

  var gTotal = ''.obs;

  String getTotal() {
    double d = 0.00;
    for (var f in list_fee_master_temp) {
      d += double.parse(f.amt!.text == '' ? '0' : f.amt!.text);
    }
    gTotal.value = d.toString();
    return d.toString();
  }

  void save() async {
    loader = CustomBusyLoader(context: context);
    loader.show();
    dialog = CustomAwesomeDialog(context: context);
    var s = '';
    for (var f in list_fee_master_temp) {
      if (f.amt!.text != '') s += "${f.id}^${f.amt!.text};";
    }
    // print(s);
    // loader.close();

    try {
      // p_catid, p_str ,p_cid
      // print({
      //   "tag": "3",
      //   "p_catid": selectedTabIndex.value,
      //   "p_str": s,
      //   "p_cid": user.value.comID
      // });
      var x = await api.createLead([
        {
          "tag": "3",
          "p_catid": selectedTabIndex.value,
          "p_str": s,
          "p_cid": user.value.comID,
          "p_type": isRegular.value ? "1" : "0"
        }
      ], 'getdata_mc');
      loader.close();
      ModelStatus st = await getStatusWithDialog(x, dialog);
      if (st.status == '1') {
        dialog
          ..dialogType = DialogType.success
          ..message = st.msg!
          ..show()
          ..onTap = () async {
            loader.show();
            try {
              var x = await api.createLead([
                {"tag": "2", "p_cid": user.value.comID}
              ], 'getdata_mc');
              loader.close();
              if (checkJson(x)) {
               
                list_fee_master_main.addAll(x
                    .map((e) => ModelFeesMasterMC.fromJson(e))
                    .where((f) => f.typeId == '1'));
              }
            } catch (e) {
              loader.close();
              dialog
                ..dialogType = DialogType.error
                ..message = e.toString()
                ..show();
            }
          };
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
    //list_fee_master_temp.where((f) => f.id == x.id).first.isChk = b;
    // list_fee_master_temp.refresh();
  }

  void LoadFeeConfig(String catID) {
    selectedTabIndex.value = catID;
    list_fee_master_temp.clear();
    for (var f in _list_head) {
      list_fee_master_temp.add(_ModelFeeTemp(
          id: f.id,
          name: f.name,
          amt: TextEditingController(
              text: _getAmt(f.id!, selectedTabIndex.value,
                  isRegular.value ? "1" : "0"))));
    }
    getTotal();
  }

  @override
  void onInit() async {
    api = data_api();
    isLoading.value = true;
    // list_payment_type.add(ModelCommon(id: '1', name: "Income"));
    // list_payment_type.add(ModelCommon(id: '2', name: "Expense"));
    user.value = await getUserInfo();
    if (user.value.eMPID == null) {
      isLoading.value = false;
      isError.value = true;
      errorMessage.value = 'Re-login required!';
      return;
    }
    try {
      var x = await api.createLead([
        {"tag": "2", "p_cid": user.value.comID}
      ], 'getdata_mc');
      if (checkJson(x)) {
        // print(x);
        list_fee_master_main.addAll(x
            .map((e) => ModelFeesMasterMC.fromJson(e))
            .where((f) => f.typeId == '1'));
        var y = list_fee_master_main.map((f) => _head(id: f.id, name: f.name));
        _list_head.addAll(y.toSet());
        for (var f in _list_head) {
          list_fee_master_temp.add(_ModelFeeTemp(
              id: f.id,
              name: f.name,
              amt: TextEditingController(
                  text: _getAmt(f.id!, selectedTabIndex.value,
                      isRegular.value ? "1" : "0"))));
        }
        getTotal();
      }
      x = await api.createLead([
        {"tag": "1", "p_cid": user.value.comID}
      ], 'getdata_mc');
      if (checkJson(x)) {
        list_tab.addAll(x.map((e) => ModelCommon.fromJson(e)));
      }

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      isError.value = true;
      errorMessage.value = e.toString();
    }

    super.onInit();
  }

  String _getAmt(String id, String catID, String type) {
    var y = list_fee_master_main.where((e) =>
        e.typeId == '1' && e.catID == catID && e.id == id && e.type == type);
    return y.isEmpty
        ? ''
        : y.first.amount == '0'
            ? ''
            : y.first.amount!;
  }
}

// class _ModelFeeMaster {
//   String? id;
//   String? name;
//   String? typeId;
//   String? typeName;
//   String? amount;
//   String? catID;

//   _ModelFeeMaster(
//       {this.id,
//       this.name,
//       this.typeId,
//       this.typeName,
//       this.amount,
//       this.catID});

//   _ModelFeeMaster.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     typeId = json['type_id'];
//     typeName = json['type_name'];
//     amount = json['amount'];
//     catID = json['cat_id'];
//   }

//   // Map<String, dynamic> toJson() {
//   //   final Map<String, dynamic> data = new Map<String, dynamic>();
//   //   data['id'] = this.id;
//   //   data['name'] = this.name;
//   //   data['type_id'] = this.typeId;
//   //   data['type_name'] = this.typeName;
//   //   data['amount'] = this.amount;
//   //   data['ischk'] = this.ischk;
//   //   return data;
//   // }
// }

class _head extends Equatable {
  String? id;
  String? name;
  _head({
    this.id,
    this.name,
  });
  @override
  List<Object?> get props => [id, name];
}

class _ModelFeeTemp {
  String? id;
  String? name;

  TextEditingController? amt;

  _ModelFeeTemp({this.id, this.name, this.amt});
}

class _TabList {
  String? id;
  String? name;
  _TabList({
    this.name,
  });
}
