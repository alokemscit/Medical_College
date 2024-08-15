// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable, camel_case_types, avoid_function_literals_in_foreach_calls
import 'package:agmc/core/config/const.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/shared/user_data.dart';
import '../../../../model/model_status.dart';
import '../model/mc_model_entitled_Student.dart';

class McAccountEnrollMentController extends GetxController
    with MixInController {
  var selectedOnlineStudent = _ModelStudentMaster().obs;
  final TextEditingController txt_rem = TextEditingController();

  var selectedSessionID = ''.obs;
  var isfreeQuota = false.obs;
  //var selectedStudentID = ''.obs;
  //var selectedStudentName = ''.obs;
  //var isOutStanding = false.obs;
  var isShowOnlineStudent = false.obs;
  final TextEditingController txt_till_date = TextEditingController();
  final TextEditingController txt_search_entitled = TextEditingController();
  final TextEditingController txt_search_for_entitle = TextEditingController();

  var list_fee_master_main = <_ModelFeeMaster>[].obs;
  var _list_head = <_head>[].obs;

  var list_bill = <_bill>[].obs;

  var total = ''.obs;
  var billTotal = ''.obs;
  var editStudentID = ''.obs;

  var list_student = <_ModelStudentMaster>[].obs;
  var list_student_temp = <_ModelStudentMaster>[].obs;
  var list_session = <_modelSession>[].obs;

  var list_ent_student_master = <ModelEntStudent>[].obs;
  var list_ent_student_temp = <ModelEntStudent>[].obs;

  void searchForEntitle() {
    list_student_temp.clear();
    list_student_temp.addAll(list_student.where((e) => e.sTUDENTFULLNAME!
        .toString()
        .toUpperCase()
        .contains(txt_search_for_entitle.text.toUpperCase())||
        e.sTUDENTID!
        .toString()
        .toUpperCase()
        .contains(txt_search_for_entitle.text.toUpperCase())||
        e.cONTACTNO!
        .toString()
        .toUpperCase()
        .contains(txt_search_for_entitle.text.toUpperCase())||
        e.sESSIONNAME!
        .toString()
        .toUpperCase()
        .contains(txt_search_for_entitle.text.toUpperCase()) 
        
        
        ));
  }

  void entitledSearch() {
    list_ent_student_temp.clear();
    list_ent_student_temp.addAll(list_ent_student_master.where((e) =>
        e.name!
            .toString()
            .toUpperCase()
            .contains(txt_search_entitled.text.toUpperCase()) ||
        e.stId!
            .toString()
            .toUpperCase()
            .contains(txt_search_entitled.text.toUpperCase()) ||
        e.ses!
            .toString()
            .toUpperCase()
            .contains(txt_search_entitled.text.toUpperCase()) ||
        e.mob!
            .toString()
            .toUpperCase()
            .contains(txt_search_entitled.text.toUpperCase())));
  }

  void loadBill([bool isFreeQuota = false]) {
    _list_head.clear();
    list_bill.clear();
    var y = list_fee_master_main.map((f) => _head(id: f.id, name: f.name));
    _list_head.addAll(y.toSet());

    double t1 = 0.0;
    String k = '';
    _list_head.forEach((f) {
      k = isFreeQuota ? '' : _getAmt(f.id!, "4");
      t1 += double.parse(k == '' ? '0' : k);
      list_bill.add(_bill(
          id: f.id,
          name: f.name,
          billAmt: TextEditingController(text: k),
          collAmt: TextEditingController(text: k)));
    });
    //if (isFreeQuota) {
    total.value = t1 > 0 ? t1.toString() : '';
    billTotal.value = t1 > 0 ? t1.toString() : '';
    txt_rem.text = '';
    //}
  }

  void SelectOnlineStudent(_ModelStudentMaster f) {
    isfreeQuota.value = false;
    undo();
    selectedOnlineStudent.value = f;
    isShowOnlineStudent.value = false;
    loadBill();
    //selectedStudentID.value = f.sTUDENTID!;
    //selectedStudentName.value = f.sTUDENTFULLNAME!;
  }

  void save() async {
    dialog = CustomAwesomeDialog(context: context);
    loader = CustomBusyLoader(context: context);
    loader.show();
    var s = '';

    double d_bill = 0.00;
    double d_coll = 0.00;
    list_bill.forEach((f) {
      d_bill = double.parse(f.billAmt!.text == '' ? '0' : f.billAmt!.text);
      d_coll = double.parse(f.collAmt!.text == '' ? '0' : f.collAmt!.text);
      if ((d_bill + d_coll) > 0) {
        s += '${f.id!},${d_bill.toString()},${d_coll.toString()};';
      }
    });

    try {
//st_id in varchar2,st_name in varchar2,st_mob in varchar2,
// st_ses_id in int, st_ses_name in varchar2,p_cid in int, p_str in varchar2,p_till_date in varchar2,p_roll in int, p_eid in varchar2,p_rem in varchar2)
//st_id in varchar2,st_name in varchar2,st_mob in varchar2,
//st_ses_id in int, st_ses_name in varchar2,p_cid in int, p_str in varchar2,p_till_date in varchar2,p_roll in int, p_eid in varchar2,p_rem in varchar2
      // print({
      //   "tag": "4",
      //   "st_id": selectedOnlineStudent.value.sTUDENTID,
      //   "st_name": selectedOnlineStudent.value.sESSIONNAME,
      //   "st_mob": selectedOnlineStudent.value.cONTACTNO,
      //   "st_ses_id": selectedSessionID.value,
      //   "st_ses_name": selectedOnlineStudent.value.sESSIONNAME,
      //   "p_cid": user.value.comID,
      //   "p_str": s,
      //   "p_till_date": txt_till_date.text,
      //   "p_roll": selectedOnlineStudent.value.rOLL ?? '',
      //   "p_eid": user.value.eMPID,
      //   "p_rem": txt_rem.text
      // });

      var x = await api.createLead([
        {
          "tag": "4",
          "st_id": selectedOnlineStudent.value.sTUDENTID,
          "st_name": selectedOnlineStudent.value.sTUDENTFULLNAME,
          "st_mob": selectedOnlineStudent.value.cONTACTNO,
          "st_ses_id": selectedSessionID.value,
          "st_ses_name": selectedOnlineStudent.value.sESSIONNAME,
          "p_cid": user.value.comID,
          "p_str": s,
          "p_till_date": txt_till_date.text,
          "p_roll": selectedOnlineStudent.value.rOLL ?? '',
          "p_eid": user.value.eMPID,
          "p_rem": txt_rem.text,
          "p_isfree": isfreeQuota.value ? "1" : "0"
        }
      ], 'getdata_mc');
      // print(x);
      loader.close();
      ModelStatus st = await getStatusWithDialog(x, dialog);
      if (st.status == '1') {
        list_student.removeWhere(
            (f) => f.sTUDENTID == selectedOnlineStudent.value.sTUDENTID);
        list_student_temp.removeWhere(
            (f) => f.sTUDENTID == selectedOnlineStudent.value.sTUDENTID);

        dialog
          ..dialogType = DialogType.success
          ..message = st.msg!
          ..show()
          ..onTap = () async {
            var x = await api.createLead([
              {"tag": "5", "p_cid": user.value.comID, "p_ses_id": "0"}
            ], 'getdata_mc');
            if (checkJson(x)) {
              list_ent_student_master.clear();
              list_ent_student_master
                  .addAll(x.map((e) => ModelEntStudent.fromJson(e)));
              if (list_ent_student_master.isNotEmpty) {
                list_ent_student_temp.clear();
                list_ent_student_temp.addAll(list_ent_student_master);
              }
            }
          };
        Future.delayed(const Duration(milliseconds: 500), () {
          undo();
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

  void Total() {
    double d = 0.00;
    list_bill.forEach((f) {
      d += double.parse((f.collAmt!.text == '' || f.collAmt!.text == '.')
          ? '0'
          : f.collAmt!.text);
    });
    billTotal.value = d > 0 ? d.toString() : '';
  }

  void generateOutStanding() {
    // lis_temp_outstanding.clear();
    list_fee_master_main.forEach((f) {
      // lis_temp_outstanding.add(_outstandingHead(
      //     id: f.id, name: f.name, txtController: TextEditingController()));
    });
  }

  void undo() {
    total.value = '';
    billTotal.value = '';
    selectedOnlineStudent.value = _ModelStudentMaster();
    txt_rem.text = '';
    // isOutStanding.value = false;
  }

  void loadStudentMaster() {
    undo();

    list_student_temp.clear();
    list_student_temp.addAll(list_student.where((e) =>
        e.sESSIONID == selectedSessionID.value &&
        !isExists(e.sTUDENTID!.trim())));
  }

  bool isExists(String id) {
    if (list_ent_student_master.where((c) => c.stId!.trim() == id).isNotEmpty) {
      // print('object');
      return true;
    }
    return false;
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
        {
          "url":
              "https://portal.asgaralimc.edu.bd/mcsmgtapp.api/api/GetStudentSearchByIDapi"
        },
      ], 'remote_api');
      //  print(x);
      if (checkJson(x)) {
        list_student.addAll(x.map((e) => _ModelStudentMaster.fromJson(e)));
        list_session.clear();
        if (list_student.isNotEmpty) {
          var y = list_student
              .map((e) => _modelSession(
                  sessionId: e.sESSIONID, SessionName: e.sESSIONNAME))
              .toSet()
              .toList();
          list_session.addAll(y);
        }
      }

      x = await api.createLead([
        {"tag": "2", "p_cid": user.value.comID}
      ], 'getdata_mc');
      if (checkJson(x)) {
        list_fee_master_main.addAll(x
            .map((e) => _ModelFeeMaster.fromJson(e))
            .where((f) => f.typeId == '1'));
      }

      x = await api.createLead([
        {"tag": "5", "p_cid": user.value.comID, "p_ses_id": "0"}
      ], 'getdata_mc');
      if (checkJson(x)) {
        list_ent_student_master
            .addAll(x.map((e) => ModelEntStudent.fromJson(e)));
        if (list_ent_student_master.isNotEmpty) {
          list_ent_student_temp.addAll(list_ent_student_master);
        }
      }

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      isError.value = true;
      errorMessage.value = e.toString();
    }
    super.onInit();
  }

  String _getAmt(String id, String catID) {
    var y = list_fee_master_main
        .where((e) => e.typeId == '1' && e.catID == catID && e.id == id);
    // print(y.first.amount);
    return y.isEmpty
        ? ''
        : y.first.amount == '0'
            ? ''
            : y.first.amount!;
  }
}

class _modelSession extends Equatable {
  String? sessionId;
  String? SessionName;
  _modelSession({
    this.sessionId,
    this.SessionName,
  });

  @override
  List<Object?> get props => [sessionId, SessionName];
}

class _ModelStudentMaster {
  String? sTUDENTID;
  String? sTUDENTFULLNAME;
  String? cONTACTNO;
  String? sESSIONNAME;
  String? rOLL;
  String? sESSIONID;

  _ModelStudentMaster(
      {this.sTUDENTID,
      this.sTUDENTFULLNAME,
      this.cONTACTNO,
      this.sESSIONNAME,
      this.rOLL,
      this.sESSIONID});

  _ModelStudentMaster.fromJson(Map<String, dynamic> json) {
    //print(json['SESSION_NAME']);
    sTUDENTID = json['STUDENT_ID'];
    sTUDENTFULLNAME = json['STUDENT_FULL_NAME'];
    cONTACTNO = json['CONTACT_NO'];
    sESSIONNAME = json['SESSION_NAME'];
    rOLL = json['ROLL'];
    sESSIONID = json['SESSIONID'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['STUDENT_ID'] = this.sTUDENTID;
  //   data['STUDENT_FULL_NAME'] = this.sTUDENTFULLNAME;
  //   data['CONTACT_NO'] = this.cONTACTNO;
  //   data['SESSION_NAME'] = this.sESSIONNAME;
  //   data['ROLL'] = this.rOLL;
  //   data['SESSIONID'] = this.sESSIONID;
  //   return data;
  // }
}

class _bill {
  String? id;
  String? name;
  TextEditingController? billAmt;
  TextEditingController? collAmt;
  _bill({
    this.id,
    this.name,
    this.billAmt,
    this.collAmt,
  });
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

class _ModelFeeMaster {
  String? id;
  String? name;
  String? typeId;
  String? typeName;
  String? amount;
  String? catID;

  _ModelFeeMaster(
      {this.id,
      this.name,
      this.typeId,
      this.typeName,
      this.amount,
      this.catID});

  _ModelFeeMaster.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    typeId = json['type_id'];
    typeName = json['type_name'];
    amount = json['amount'];
    catID = json['cat_id'];
  }
}
