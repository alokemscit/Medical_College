// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:agmc/core/config/const.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/shared/user_data.dart';
import '../../../../model/model_status.dart';
import '../../../../widget/custom_snakbar.dart';
import '../../mc_account_enrollment/model/mc_model_entitled_Student.dart';
import '../../mc_head_setup/model/model_fee_master.dart';

class McFeeCollectionController extends GetxController with MixInController {
  var list_ent_student_master = <ModelEntStudent>[].obs;
  var list_ent_student_temp = <ModelEntStudent>[].obs;
  var list_fee_master_main = <ModelFeeMaster>[].obs;
  var list_coll_attr = <_collAttr>[].obs;

  var list_outstanding_trans = <_modelOpeningTrans>[].obs;

  var list_trans = <_trans>[].obs;
  var list_head = <_transHead>[].obs;

  var list_trans_fee = <_modelTrans>[].obs;
  var list_trans_fee_head = <_transFeeHead>[].obs;

  var isShowPopup = false.obs;
  var selectedStudent = ModelEntStudent().obs;
  final TextEditingController txt_st_id = TextEditingController();
  final TextEditingController txt_search = TextEditingController();
  final TextEditingController txt_date = TextEditingController();
  final TextEditingController txt_remarks = TextEditingController();
  final TextEditingController txt_fdate = TextEditingController();
  final TextEditingController txt_tdate = TextEditingController();

  var total = ''.obs;
  var radioValue = '1'.obs;

  void show_Transaction() async {
    list_head.clear();
    list_trans.clear();
    list_trans_fee.clear();
    list_trans_fee_head.clear();
    list_outstanding_trans.clear();
    dialog = CustomAwesomeDialog(context: context);
    loader = CustomBusyLoader(context: context);
    loader.show();
    if (!isValidDateRange(txt_fdate.text, txt_tdate.text)) {
      loader.close();
      dialog
        ..dialogType = DialogType.warning
        ..message = 'Valid date range required!'
        ..show();
      return;
    }
    try {
      //p_stid in varchar2,p_fdate in varchar2,p_tdate in varchar2
      var x = await api.createLead([
        {
          "tag": "137",
          "p_stid": selectedStudent.value.stId,
          "p_fdate": txt_fdate.text,
          "p_tdate": txt_tdate.text
        }
      ]);
      loader.close();
      if (x != [] ||
          x.map((f) => ModelStatus.fromJson(f)).first.status != '3') {
        list_trans_fee.addAll(x.map((e) => _modelTrans.fromJson(e)));
        var uniqueHeads = list_trans_fee
            .map((f) => _transFeeHead(id: f.trid,tno: f.trno,tdate: f.tdate))
            .toSet()
            .toList();
         list_trans_fee_head.assignAll(uniqueHeads);
     }
    } catch (e) {
      loader.close();
      dialog
        ..dialogType = DialogType.error
        ..message = e.toString()
        ..show();
    }
  }

  void showData_outstanding() async {
    list_head.clear();
    list_trans.clear();
    list_trans_fee.clear();
    list_trans_fee_head.clear();
    list_outstanding_trans.clear();
    dialog = CustomAwesomeDialog(context: context);
    loader = CustomBusyLoader(context: context);
    loader.show();
    if (!isValidDateRange(txt_fdate.text, txt_tdate.text)) {
      loader.close();
      dialog
        ..dialogType = DialogType.warning
        ..message = 'Valid date range required!'
        ..show();
      return;
    }
    try {
      //p_stid in varchar2,p_fdate in varchar2,p_tdate in varchar2
      var x = await api.createLead([
        {
          "tag": "135",
          "p_stid": selectedStudent.value.stId,
          "p_fdate": txt_fdate.text,
          "p_tdate": txt_tdate.text
        }
      ]);
      loader.close();
      if (x != [] ||
          x.map((f) => ModelStatus.fromJson(f)).first.status != '3') {
        list_outstanding_trans
            .addAll(x.map((f) => _modelOpeningTrans.fromJson(f)));

        list_head.clear();
        var uniqueHeads = list_outstanding_trans
            .map((f) => _transHead(id: f.id, name: f.hname!))
            .toSet()
            .toList();
        list_head.assignAll(uniqueHeads);

        // print(list_head.length);
        list_trans.clear();
        list_head.forEach((f) {
          // print(f.name);
          var opening = 0.00, cloasing = 0.00;
          var t = list_outstanding_trans.where((e) => e.id == f.id);
          t.forEach((a) {
            // print(a.hname);
            if (opening == 0)
              opening += double.parse(a.oamt.toString()) + cloasing;
            //-cloasing;
            cloasing = opening > 0
                ? opening - double.parse(a.tamt.toString())
                : double.parse(a.tamt.toString());

            list_trans.add(_trans(
                id: a.id,
                name: a.hname,
                date: a.tdate,
                oamt: opening,
                tamt: double.parse(a.tamt.toString()),
                bal: cloasing,
                tno: a.trsno));

            opening = cloasing;
          });
        });
      }
    } catch (e) {
      loader.close();
      dialog
        ..dialogType = DialogType.error
        ..message = e.toString()
        ..show();
    }
  }

  void save() async {
    dialog = CustomAwesomeDialog(context: context);
    loader = CustomBusyLoader(context: context);
    loader.show();
    if (total.value == '') {
      loader.close();
      dialog
        ..dialogType = DialogType.warning
        ..message = 'Transaction amount should be greater than zero!'
        ..show();
      return;
    }
    var s = '';
    list_coll_attr.forEach((f) {
      if (f.amt!.text.trim().isNotEmpty) {
        s += '${f.id!}人${f.amt!.text}人${f.rem!.text}大';
      }
    });
    // print(s);
    //p_cid in int,p_stid in int,p_date in varchar2,p_rem in varchar2,p_str in varchar2,p_eid in varchar2
    try {
      var x = await api.createLead([
        {
          "tag": "136",
          "p_cid": user.value.comID,
          "p_stid": selectedStudent.value.id,
          "p_date": txt_date.text,
          "p_rem": txt_remarks.text,
          "p_str": s,
          "p_eid": user.value.eMPID
        }
      ]);
      loader.close();
      ModelStatus st = await getStatusWithDialog(x, dialog);
      if (x != [] || st.status == '1') {
        dialog
          ..dialogType = DialogType.success
          ..message = st.msg!
          ..show();
        list_coll_attr.forEach((f) {
          f.amt!.text = '';
          f.rem!.text = '';
        });
        list_coll_attr.refresh();
        total.value = '';
      }
    } catch (e) {
      loader.close();
      dialog
        ..dialogType = DialogType.error
        ..message = e.toString()
        ..show();
    }
  }

  void loadAttr() async {
    txt_remarks.text = '';
    total.value = '';
    list_coll_attr.clear();
    list_fee_master_main.forEach((f) {
      list_coll_attr.add(_collAttr(
          id: f.id,
          name: f.name,
          amt: TextEditingController(),
          outAmt: '',
          rem: TextEditingController()));
    });
  }

  void total_cal() {
    total.value = '';
    total.value = list_coll_attr.fold(0.0, (sum, item) {
      double amt = double.tryParse(item.amt!.text) ?? 0.0;
      return sum + amt;
    }).toString();
  }

  void undo() {
    selectedStudent.value = ModelEntStudent();
    txt_st_id.text = '';
    txt_remarks.text = '';
    list_coll_attr.clear();
    list_head.clear();
    list_trans.clear();
  }

  void search() {
    list_ent_student_temp.clear();
    list_ent_student_temp.addAll(list_ent_student_master.where((f) =>
        f.name!.toUpperCase().contains(txt_search.text.toUpperCase()) ||
        f.ses!.toUpperCase().contains(txt_search.text.toUpperCase()) ||
        f.stId!.toUpperCase().contains(txt_search.text.toUpperCase())));
  }

  void show() {
    dialog = CustomAwesomeDialog(context: context);
    if (txt_st_id.text.isEmpty) {
      dialog
        ..dialogType = DialogType.warning
        ..message = 'Student ID requird!'
        ..show();
      return;
    }
    selectedStudent.value = list_ent_student_master
            .where((e) => e.stId == txt_st_id.text)
            .isEmpty
        ? ModelEntStudent()
        : list_ent_student_master.where((e) => e.stId == txt_st_id.text).first;
    if (selectedStudent.value.id == null) {
      CustomSnackbar(
          context: context,
          message: 'Invalid Stodent ID',
          type: MsgType.warning);
    } else {
      loadAttr();
    }
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

    try {
      var x = await api.createLead([
        {"tag": "134", "p_cid": user.value.comID, "p_ses_id": "0"}
      ]);
      if (x != [] ||
          x.map((e) => ModelStatus.fromJson(e)).first.status != '3') {
        list_ent_student_master
            .addAll(x.map((e) => ModelEntStudent.fromJson(e)));
        list_ent_student_temp.addAll(list_ent_student_master);
      }
      x = await api.createLead([
        {"tag": "130", "p_cid": user.value.comID}
      ]);
      if (x != [] ||
          x.map((e) => ModelStatus.fromJson(e)).first.status != '3') {
        list_fee_master_main.addAll(x.map((e) => ModelFeeMaster.fromJson(e)));
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

class _transFeeHead extends Equatable {
  String? id;
  String? tno;
  String? tdate;
  _transFeeHead({
    this.id,
    this.tno,
    this.tdate,
  });

  @override
  List<Object?> get props => [id, tno, tdate];
}

class _transHead extends Equatable {
  String? id;

  String? name;
  _transHead({
    this.id,
    this.name,
  });

  @override
  List<Object?> get props => [id, name];
}

class _trans {
  String? id;
  String? date;
  String? tno;
  String? name;
  double? oamt;
  double? tamt;
  double? bal;
  _trans({
    this.id,
    this.date,
    this.tno,
    this.name,
    this.oamt,
    this.tamt,
    this.bal,
  });
}

class _collAttr {
  String? id;
  String? name;
  String? outAmt;
  TextEditingController? amt;
  TextEditingController? rem;
  _collAttr({
    this.id,
    this.name,
    this.outAmt,
    this.amt,
    this.rem,
  });
}

class _modelOpeningTrans {
  String? sl;
  String? trsid;
  String? tdate;
  String? trsno;
  String? rem;
  String? id;
  String? hname;
  int? oamt;
  int? tamt;

  _modelOpeningTrans(
      {this.sl,
      this.trsid,
      this.tdate,
      this.trsno,
      this.rem,
      this.id,
      this.hname,
      this.oamt,
      this.tamt});

  _modelOpeningTrans.fromJson(Map<String, dynamic> json) {
    sl = json['sl'];
    trsid = json['trsid'];
    tdate = json['tdate'];
    trsno = json['trsno'];
    rem = json['rem'];
    id = json['id'];
    hname = json['hname'];
    oamt = json['oamt'];
    tamt = json['tamt'];
  }
}

class _modelTrans {
  String? trid;
  String? trno;
  String? tdate;
  String? rem;
  String? hid;
  String? hname;
  int? trnamt;
  String? rem2;

  _modelTrans(
      {this.trid,
      this.trno,
      this.tdate,
      this.rem,
      this.hid,
      this.hname,
      this.trnamt,
      this.rem2});

  _modelTrans.fromJson(Map<String, dynamic> json) {
    trid = json['trid'];
    trno = json['trno'];
    tdate = json['tdate'];
    rem = json['rem'];
    hid = json['hid'];
    hname = json['hname'];
    trnamt = json['trnamt'];
    rem2 = json['rem2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['trid'] = this.trid;
    data['trno'] = this.trno;
    data['tdate'] = this.tdate;
    data['rem'] = this.rem;
    data['hid'] = this.hid;
    data['hname'] = this.hname;
    data['trnamt'] = this.trnamt;
    data['rem2'] = this.rem2;
    return data;
  }
}
