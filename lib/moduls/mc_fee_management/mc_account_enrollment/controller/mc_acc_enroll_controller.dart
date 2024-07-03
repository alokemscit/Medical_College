// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable, camel_case_types, avoid_function_literals_in_foreach_calls
import 'package:agmc/core/config/const.dart';
import 'package:equatable/equatable.dart';

import '../../../../model/model_status.dart';
import '../../mc_head_setup/model/model_fee_master.dart';

class McAccountEnrollMentController extends GetxController
    with MixInController {
  var selectedSessionID = ''.obs;
  var selectedStudentID = ''.obs;
  var selectedStudentName = ''.obs;
  var isOutStanding = false.obs;
  final TextEditingController txt_till_date = TextEditingController();
  var list_fee_master_main = <ModelFeeMaster>[].obs;
  var lis_temp_outstanding = <_outstandingHead>[].obs;
  var total = ''.obs;

  void Total() {
    String s = '0';
    lis_temp_outstanding.forEach((f) {
      s = (double.parse(s) +
              double.parse(
                  f.txtController!.text == '' ? '0' : f.txtController!.text))
          .toString();
    });
    total.value = s;
    //print(s);
    // return s;
  }

  void generateOutStanding() {
    lis_temp_outstanding.clear();
    list_fee_master_main.forEach((f) {
      lis_temp_outstanding.add(_outstandingHead(
          id: f.id, name: f.name, txtController: TextEditingController()));
    });
  }

  void undo() {
    total.value = '';
    selectedStudentID.value = '';
    selectedStudentName.value = '';
    isOutStanding.value = false;
  }

  void loadStudentMaster() {
    undo();

    list_student_temp.clear();
    list_student_temp.addAll(
        list_student.where((e) => e.sESSIONID == selectedSessionID.value));
  }

  var list_student = <_ModelStudentMaster>[].obs;
  var list_student_temp = <_ModelStudentMaster>[].obs;
  var list_session = <_modelSession>[].obs;
  @override
  void onInit() async {
    api = data_api();
    isLoading.value = true;

    try {
      var x = await api.createLead([
        {
          "url":
              "https://portal.asgaralimc.edu.bd/mcsmgtapp.api/api/GetStudentSearchByIDapi"
        },
      ], 'remote_api');
      //  print(x);
      if (x != [] &&
          x.map((e) => ModelStatus.fromJson(e)).first.status != '3') {
        list_student.addAll(x.map((e) => _ModelStudentMaster.fromJson(e)));

        list_student.forEach((e) {
          // print(e.sESSIONNAME);
          list_session.add(_modelSession(
              sessionId: e.sESSIONID, SessionName: e.sESSIONNAME));
        });
        list_session.toSet().toList();
      }

      // print(list_student.length);

      x = await api.createLead([
        {"tag": "130"}
      ]);
      if (x != [] &&
          x.map((e) => ModelStatus.fromJson(e)).first.status != '3') {
        list_fee_master_main.addAll(x.map((e) => ModelFeeMaster.fromJson(e)));
        //print(list_fee_master_main.length);
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

class _outstandingHead {
  String? id;
  String? name;

  TextEditingController? txtController;
  _outstandingHead({
    this.id,
    this.name,
    this.txtController,
  });
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['STUDENT_ID'] = this.sTUDENTID;
    data['STUDENT_FULL_NAME'] = this.sTUDENTFULLNAME;
    data['CONTACT_NO'] = this.cONTACTNO;
    data['SESSION_NAME'] = this.sESSIONNAME;
    data['ROLL'] = this.rOLL;
    data['SESSIONID'] = this.sESSIONID;
    return data;
  }
}
