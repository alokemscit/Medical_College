// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable, camel_case_types, avoid_function_literals_in_foreach_calls, unused_element

import 'package:agmc/core/config/const.dart';

import 'package:agmc/widget/custom_pdf_generatoe.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';

import 'package:pdf/widgets.dart' as pw;

import '../../../../core/shared/user_data.dart';
import '../../../../model/model_status.dart';
import '../../mc_fee_collection/shared_widget/mv_transaction_report.dart';
import '../model/mc_model_entitled_Student.dart';
import '../model/mc_model_trans_details.dart';
import '../model/model_transaction_summery.dart';

class McAccountEnrollMentController extends GetxController
    with MixInController {
  var selectedOnlineStudent = _ModelStudentMaster().obs;
  final TextEditingController txt_rem = TextEditingController();

  var cmb_sessionEntitledID = ''.obs;
  var selectedSessionID = ''.obs;
  var isfreeQuota = false.obs;

  var isShowOnlineStudent = false.obs;
  final TextEditingController txt_till_date = TextEditingController();
  final TextEditingController txt_search_entitled = TextEditingController();
  final TextEditingController txt_search_for_entitle = TextEditingController();

  final TextEditingController txt_from_date = TextEditingController();
  final TextEditingController txt_to_date = TextEditingController();

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

  var list_trans_summery = <MadelTransactionSummery>[].obs;
  var list_trans_details = <MadelTransactionDetails>[].obs;

  var selectedOnlineStudentID = ''.obs;

  void setSessionForAccSudent(String id) {
    cmb_sessionEntitledID.value = id;
    list_ent_student_temp.clear();
    list_ent_student_temp.addAll(list_ent_student_master
        .where((e) => e.ses_id == cmb_sessionEntitledID.value));
  }

  //late Font? font;
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
      //print(x);
      // loader.close();
      if (checkJson(x)) {
        list_trans_details
            .addAll(x.map((e) => MadelTransactionDetails.fromJson(e)));
        if (list_trans_details.isNotEmpty) {
          Future.delayed(const Duration(milliseconds: 1), () {
            //_Report().showReport(this);

            pwReportTransaction(
              list: list_trans_details,
              font: font.value,
              image: image.value,
              onComlpete: () {
                loader.close();
              },
            ).showReport();
          });
        } else {
          loader.close();
          dialog
            ..dialogType = DialogType.warning
            ..message = 'No Data Found!'
            ..show();
        }
      } else {
        loader.close();
      }
    } catch (e) {
      loader.close();
      dialog
        ..dialogType = DialogType.error
        ..message = e.toString()
        ..show();
    }
  }

  void viewTransSummery(String stno) async {
    dialog = CustomAwesomeDialog(context: context);
    loader = CustomBusyLoader(context: context);
    if (isCheckCondition(
        !isValidDateRange(txt_from_date.text, txt_to_date.text),
        dialog,
        'Invalid Date range!')) return;
    list_trans_summery.clear();
    try {
      loader.show();
      var x = await api.createLead([
        {
          "tag": "7",
          "p_stno": stno,
          "fdate": txt_from_date.text,
          "tdate": txt_to_date.text
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

  void searchForEntitle() {
    list_student_temp.clear();
    list_student_temp.addAll(list_student.where((e) =>
        e.sTUDENTFULLNAME!
            .toString()
            .toUpperCase()
            .contains(txt_search_for_entitle.text.toUpperCase()) ||
        e.sTUDENTID!
            .toString()
            .toUpperCase()
            .contains(txt_search_for_entitle.text.toUpperCase()) ||
        e.cONTACTNO!
            .toString()
            .toUpperCase()
            .contains(txt_search_for_entitle.text.toUpperCase()) ||
        e.sESSIONNAME!
            .toString()
            .toUpperCase()
            .contains(txt_search_for_entitle.text.toUpperCase())));
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
            .contains(txt_search_entitled.text.toUpperCase())  
          ||  e.quota_name!
            .toString()
            .toUpperCase()
            .contains(txt_search_entitled.text.toUpperCase()))  
            
                );
  }

  void loadBill([bool isFreeQuota = false]) {
    _list_head.clear();
    list_bill.clear();
    var y = list_fee_master_main.map((f) => _head(id: f.id, name: f.name));
    _list_head.addAll(y.toSet());

    double t1 = 0.0;
    String k = '';
    _list_head.forEach((f) {
     
      k = isFreeQuota
          ? ''
          : _getAmt(f.id!, "4",
              selectedOnlineStudent.value.QUOTA_ID == "5" ? "0" : "1");

          if(double.parse(k == '' ? '0' : k)>0){
     t1 += double.parse(k == '' ? '0' : k);
      
      list_bill.add(_bill(
          id: f.id,
          name: f.name,
          billAmt: TextEditingController(text: k),
          collAmt: TextEditingController(text: k)));
          }

     
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
    isfreeQuota.value = f.QUOTA_ID == "5" ? true : false;
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
          "p_isfree": selectedOnlineStudent.value.QUOTA_ID=="5" ? "1" : "0",
          "p_quota_id": selectedOnlineStudent.value.QUOTA_ID,
          "p_quota_name": selectedOnlineStudent.value.QUOTA_NAME,
        }
      ], 'getdata_mc');
      // p_quota_id,p_quota_name
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
                list_ent_student_temp.addAll(list_ent_student_master
                    .where((e) => e.ses_id == cmb_sessionEntitledID.value));
              }
            }
            viewReport(st.id!);

            Future.delayed(const Duration(milliseconds: 500), () {
              undo();
            });
          };
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
    // list_company.add(((get_company_list()).where((element) => element.id == user.value.comID)).first);
    //font.value = await pwFontloader(font_loto_path);

    user.value = await getUserInfo();
    if (user.value.eMPID == null) {
      isLoading.value = false;
      isError.value = true;
      errorMessage.value = 'Re-login required!';
      return;
    }
    image.value = await pwLoadImageWidget(user.value.comID!);
    font.value = await CustomLoadFont(appFontPathRoboto);

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
       // print(x);
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
          // list_ent_student_temp.addAll(list_ent_student_master);

          list_ent_student_master.forEach((f) {
            list_student.removeWhere((e) => e.sTUDENTID == f.stId);
            list_student_temp.removeWhere((e) => e.sTUDENTID == f.stId);
          });
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

  String _getAmt(String id, String catID, String type) {
    var y = list_fee_master_main
        .where((e) => e.typeId == '1' && e.catID == catID && e.id == id && e.type==type);
    // print(y.first.amount);
    return y.isEmpty
        ? ''
        : y.first.amount == '0'
            ? ''
            : y.first.amount!;
  }

  void showOutStanding() async {
    loader = CustomBusyLoader(context: context);
    loader.show();
    Future.delayed(const Duration(milliseconds: 1), () async {
      await _Report().showReport_uotstanding(this);
    });
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
  String? QUOTA_ID;
  String? QUOTA_NAME;
  _ModelStudentMaster(
      {this.sTUDENTID,
      this.sTUDENTFULLNAME,
      this.cONTACTNO,
      this.sESSIONNAME,
      this.rOLL,
      this.sESSIONID,
      this.QUOTA_ID,
      this.QUOTA_NAME});

  _ModelStudentMaster.fromJson(Map<String, dynamic> json) {
    //print(json['SESSION_NAME']);
    sTUDENTID = json['STUDENT_ID'];
    sTUDENTFULLNAME = json['STUDENT_FULL_NAME'];
    cONTACTNO = json['CONTACT_NO'];
    sESSIONNAME = json['SESSION_NAME'];
    rOLL = json['ROLL'];
    sESSIONID = json['SESSIONID'];
    QUOTA_ID = json['QUOTA_ID'];
    QUOTA_NAME = json['QUOTA_NAME'];
  }
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
  String? type;

  _ModelFeeMaster(
      {this.id,
      this.name,
      this.typeId,
      this.typeName,
      this.amount,
      this.catID,this.type});

  _ModelFeeMaster.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    typeId = json['type_id'];
    typeName = json['type_name'];
    amount = json['amount'];
    catID = json['cat_id'];
    type = json['type'];
  }
}

class _Report {
  Future<void> showReport_uotstanding(
    McAccountEnrollMentController controller,
  ) async {
    var font = controller.font.value;
    var image = controller.image.value;
    var first = controller.list_ent_student_temp.first;
    var date = DateFormat('dd/MM/yyyy').format(DateTime.now());
    CustomPDFGenerator(
        // orientation: PageOrientation.landscape,
        font: font,
        header: [
          pw.Image(image!, width: 150, height: 80),
          pwHeight(12),
          pwTextOne(font, 'Student Outstanding Report', '', 9,
              pw.MainAxisAlignment.center),
          pwHeight(4),
          pwTextOne(font, 'Session : ', first.ses ?? '', 9,
              pw.MainAxisAlignment.start),
          pwHeight(4),
          pwTextOne(font, 'Till Date : ', date, 9, pw.MainAxisAlignment.start),
        ],
        footer: [
          pwTextOne(font, 'Printed By  : ', controller.user.value.eMPNAME ?? '',
              9, pw.MainAxisAlignment.start),
        ],
        body: [
          pwGenerateTable([
            30,
            10,
            80,
            30,
            50
          ], [
            pwTableCell('Student ID', font, pw.Alignment.centerLeft, 12),
            pwTableCell('Roll', font, pw.Alignment.center, 12),
            pwTableCell('Name', font, pw.Alignment.centerLeft, 12),
            pwTableCell('Is Poor Quota', font, pw.Alignment.center, 12),
            pwTableCell('Outstanding', font, pw.Alignment.centerRight, 12),
          ], [
            ...controller.list_ent_student_temp.map((f) => pw.TableRow(
                    // decoration: pw.BoxDecoration(color: ),
                    children: [
                      pwTableCell(f.stId ?? '', font),
                      pwTableCell(f.roll ?? '', font, pw.Alignment.center),
                      pwTableCell(f.name ?? '', font, pw.Alignment.centerLeft),
                      pwTableCell((f.isfree ?? '') == '1' ? 'Yes' : 'No', font,
                          pw.Alignment.center),
                      pwTableCell(f.omt == null ? "0" : f.omt.toString(), font,
                          pw.Alignment.centerRight),
                    ])),
            pw.TableRow(
                decoration: const pw.BoxDecoration(color: PdfColors.grey400),
                children: [
                  pwTableCell('', font, pw.Alignment.centerRight, 10),
                  pwTableCell('', font, pw.Alignment.centerRight, 10),
                  pwTableCell('', font, pw.Alignment.centerRight, 10),
                  pwTableCell('Total', font, pw.Alignment.centerRight, 10),
                  pwTableCell(
                      controller.list_ent_student_temp
                          .fold(0.00,
                              (previous, current) => previous + current.omt!)
                          .toString(),
                      font,
                      pw.Alignment.centerRight,
                      10),
                ]),
          ]),
        ],
        fun: () {
          controller.loader.close();
        }).ShowReport();
  }
}
