// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_function_literals_in_foreach_calls, must_be_immutable, prefer_const_constructors_in_immutables, unused_element

import 'package:agmc/core/config/const.dart';
import 'package:agmc/model/model_status.dart';
import 'package:equatable/equatable.dart';

 

import '../../../../core/shared/user_data.dart';

import '../../../../model/model_common.dart';

import '../../mc_account_enrollment/model/mc_model_entitled_Student.dart';
import '../../mc_account_enrollment/model/mc_model_trans_details.dart';
import '../../mc_account_enrollment/model/model_transaction_summery.dart';
import '../../mc_default_setup/model/mc_model_fees_master.dart';
import '../shared_widget/mv_transaction_report.dart';

class McFeeCollectionController extends GetxController with MixInController {
  var list_session = <_session>[].obs;

  var list_ent_student_master = <ModelEntStudent>[].obs;
  var list_ent_student_temp = <ModelEntStudent>[].obs;
  var cmb_sessionID = ''.obs;
  var selectedRow = ''.obs;

  // var isShowPopup = false.obs;
  var selectedStudent = ModelEntStudent().obs;
  final TextEditingController txt_st_id = TextEditingController();
  final TextEditingController txt_search = TextEditingController();
  final TextEditingController txt_date = TextEditingController();
  final TextEditingController txt_remarks = TextEditingController();
  final TextEditingController txt_fdate = TextEditingController();
  final TextEditingController txt_tdate = TextEditingController();
   

  var list_fee_master_main = <ModelFeesMasterMC>[].obs;
  var list_fee_master_temp = <_ModelFeeTemp>[].obs;
  var selectedFeeTypeID = ''.obs;
  var list_tab = <ModelCommon>[].obs;
  var _list_head = <_head>[].obs;
  var gTotal = ''.obs;
  var selectedTabIndex = '1'.obs;

  var list_trans_summery = <MadelTransactionSummery>[].obs;
  var list_trans_details = <MadelTransactionDetails>[].obs;

  var list_outstanding = <_ModelOutStanding>[].obs;

  void saveCollection() async {
    loader = CustomBusyLoader(context: context);

    dialog = CustomAwesomeDialog(context: context);
    double d = 0.00;
    list_fee_master_temp.forEach((f) {
      d += double.parse(f.amt!.text == '' ? '0' : f.amt!.text);
    });
    if (isCheckCondition(d <= 0, dialog, 'No transaction amount found')) return;

    String s = '';
    double d_coll = 0.00;
    list_fee_master_temp.forEach((f) {
      d_coll = double.parse(f.amt!.text == '' ? '0' : f.amt!.text);
      if (d_coll > 0) {
        s += '${f.id!},${d_coll.toString()};';
      }
    });

    ModelStatus st = await commonSaveUpdate(
        api,
        loader,
        dialog,
        [
          {
            "tag": "10",
            "p_cid": user.value.comID,
            "st_id": selectedStudent.value.id,
            "p_str": s,
            "p_till_date": txt_date.text,
            "p_rem": txt_remarks.text,
            "p_eid": user.value.eMPID,
            "fee_typeid": selectedTabIndex.value
          }
        ],
        'getdata_mc');
    if (st.status == '1') {
      selectTab("1");
      dialog
        ..dialogType = DialogType.success
        ..message = st.msg!
        ..show()
        ..onTap = () async {
          viewReport(st.id!);
        };
    }

    //p_cid in int,st_id in int, p_str in varchar2,p_till_date in varchar2,p_rem in varchar2, p_eid in varchar2,fee_typeid
  }

  String getTotal() {
    double d = 0.00;
    list_fee_master_temp.forEach((f) {
      d += double.parse(f.amt!.text == '' ? '0' : f.amt!.text);
    });
    gTotal.value = d.toString();
    return d.toString();
  }

  void selectTab(String id) async {
    loader = CustomBusyLoader(context: context);
    dialog = CustomAwesomeDialog(context: context);
    gTotal.value = '';
    selectedTabIndex.value = id;
    list_fee_master_temp.clear();
    if (id != '4') {
      _list_head.forEach((f) {
        list_fee_master_temp.add(_ModelFeeTemp(
            id: f.id,
            name: f.name,
            damount: _getAmt(f.id!, selectedTabIndex.value,selectedStudent.value.quota_id=='5'?"0":"1"),
            amt: TextEditingController(
                text: _getAmt(f.id!, selectedTabIndex.value,selectedStudent.value.quota_id=='5'?"0":"1"))));
        getTotal();
      });
    } else {
      loader.show();
      list_outstanding.clear();
      try {
        var x = await api.createLead([
          {"tag": "9", "p_sid": selectedStudent.value.id}
        ], 'getdata_mc');
        loader.close();
        if (checkJson(x)) {
          list_outstanding.addAll(x.map((e) => _ModelOutStanding.fromJson(e)));
          list_outstanding.forEach((f) {
            list_fee_master_temp.add(_ModelFeeTemp(
                id: f.headId,
                name: f.headName,
                damount: f.bal.toString(),
                amt: TextEditingController(text: f.bal.toString())));
          });
          getTotal();
        }
      } catch (e) {
        loader.close();
        dialog
          ..dialogType = DialogType.error
          ..message = e.toString()
          ..show();
      }
    }
  }

  void viewTransSummery() async {
    dialog = CustomAwesomeDialog(context: context);
    loader = CustomBusyLoader(context: context);
    if (isCheckCondition(!isValidDateRange(txt_fdate.text, txt_tdate.text),
        dialog, 'Invalid Date range!')) return;
    list_trans_summery.clear();
    try {
      loader.show();
      var x = await api.createLead([
        {
          "tag": "7",
          "p_stno": selectedStudent.value.stId,
          "fdate": txt_fdate.text,
          "tdate": txt_tdate.text
        }
      ], 'getdata_mc');
      loader.close();
      if (checkJson(x)) {
        list_trans_summery
            .addAll(x.map((e) => MadelTransactionSummery.fromJson(e)));
      }
    } catch (e) {
      loader.close();
      dialog
        ..dialogType = DialogType.error
        ..message = e.toString()
        ..show();
    }
  }

  void viewReport(String tid) async {
    loader = CustomBusyLoader(context: context);
    loader.show();
    list_trans_details.clear();
    dialog = CustomAwesomeDialog(context: context);

    try {
      // print({"tag": "8", "p_tid": tid});
      var x = await api.createLead([
        {"tag": "8", "p_tid": tid}
      ], 'getdata_mc');

      // loader.close();
      if (checkJson(x)) {
        list_trans_details
            .addAll(x.map((e) => MadelTransactionDetails.fromJson(e)));
        if (list_trans_details.isNotEmpty) {
          Future.delayed(const Duration(milliseconds: 1), () {
            pwReportTransaction(
              font: font.value,
              image: image.value,
              list: list_trans_details,
              onComlpete: () {
                loader.close();
              },
            ).showReport();
          });
        } else {
          dialog
            ..dialogType = DialogType.warning
            ..message = 'No Data Found!'
            ..show();
        }
      }
    } catch (e) {
      loader.close();
      dialog
        ..dialogType = DialogType.error
        ..message = e.toString()
        ..show();
    }
  }

  void selectStudent(ModelEntStudent f) {
    selectedTabIndex.value = '1';
    selectTab('1');
    selectedStudent.value = f;
    list_trans_details.clear();
    list_trans_summery.clear();
  }

  void deletecStudent() {
    selectedStudent.value = ModelEntStudent();
  }

  void selectSession(String id) {
    selectedStudent.value = ModelEntStudent();
    cmb_sessionID.value = id;
    list_ent_student_temp.clear();
    list_ent_student_temp.addAll(
        list_ent_student_master.where((e) => e.ses == cmb_sessionID.value));
  }

  void search() {
    list_ent_student_temp.clear();
    list_ent_student_temp.addAll(list_ent_student_master.where((e) =>
        e.ses == cmb_sessionID.value &&
        (e.name!.toUpperCase().contains(txt_search.text.toUpperCase()) ||
            e.roll!.toUpperCase().contains(txt_search.text.toUpperCase()) ||
            e.stId!.toUpperCase().contains(txt_search.text.toUpperCase()) ||
            e.mob!.toUpperCase().contains(txt_search.text.toUpperCase()))));
  }

  @override
  void onInit() async {
    api = data_api();
    isLoading.value = true;
    user.value = await getUserInfo();
    if (user.value.eMPID == null) {
      isLoading.value = false;
      isError.value = true;
      errorMessage.value = 'Re-login required!';
      return;
    }
    image.value = await pwLoadImageWidget(user.value.comID!);
    font.value = await CustomLoadFont(font_loto_path);

    try {
      var x = await api.createLead([
        {"tag": "5", "p_cid": user.value.comID, "p_ses_id": "0"}
      ], 'getdata_mc');

      if (checkJson(x)) {
        list_ent_student_master
            .addAll(x.map((e) => ModelEntStudent.fromJson(e)));
        // list_ent_student_temp.addAll(list_ent_student_master);
        List<_session> list = [];
        list_ent_student_master.forEach((f) {
          list.add(_session(id: f.ses, name: f.ses));
        });
        list_session.addAll(list.toSet().toList());
      }

      x = await api.createLead([
        {"tag": "2", "p_cid": user.value.comID}
      ], 'getdata_mc');
      if (checkJson(x)) {
        list_fee_master_main.addAll(x
            .map((e) => ModelFeesMasterMC.fromJson(e))
            .where((f) => f.typeId == '1'));
        var y = list_fee_master_main.map((f) => _head(id: f.id, name: f.name));
        _list_head.addAll(y.toSet());
        _list_head.forEach((f) {
          list_fee_master_temp.add(_ModelFeeTemp(
              id: f.id,
              name: f.name,
              damount: _getAmt(f.id!, selectedTabIndex.value,selectedStudent.value.quota_id=='5'?"0":"1"),
              amt: TextEditingController(
                  text: _getAmt(f.id!, selectedTabIndex.value,selectedStudent.value.quota_id=='5'?"0":"1"))));
        });
        // getTotal();
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
    var y = list_fee_master_main
        .where((e) => e.typeId == '1' && e.catID == catID && e.id == id  && e.type==type);
    return y.isEmpty
        ? ''
        : y.first.amount == '0'
            ? ''
            : y.first.amount!;
  }
}

class _ModelOutStanding {
  String? headId;
  String? headName;
  double? dr;
  double? cr;
  double? bal;

  _ModelOutStanding({this.headId, this.headName, this.dr, this.cr, this.bal});

  _ModelOutStanding.fromJson(Map<String, dynamic> json) {
    headId = json['head_id'];
    headName = json['head_name'];
    dr = json['dr'];
    cr = json['cr'];
    bal = json['bal'];
  }
}

class _session extends Equatable {
  final String? id;
  final String? name;
  _session({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}

class _ModelFeeTemp {
  String? id;
  String? name;
  String? damount;
  TextEditingController? amt;
  _ModelFeeTemp({this.id, this.name, this.damount, this.amt});
}

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
