import 'package:asgar_ali_hospital/common_model/model_gender.dart';
import 'package:asgar_ali_hospital/common_model/model_status.dart';
import 'package:asgar_ali_hospital/constant/const.dart';
import 'package:asgar_ali_hospital/custom_widget/custom_awesome_dialog.dart';
import 'package:asgar_ali_hospital/custom_widget/custom_bysy_loader.dart';
 
import 'package:asgar_ali_hospital/data/data_api.dart';
import 'package:asgar_ali_hospital/data/data_static_user.dart';
import 'package:asgar_ali_hospital/entities/entity_age.dart';
import 'package:asgar_ali_hospital/pages/appointment_page/model/model_appointment_slot.dart';
import 'package:asgar_ali_hospital/pages/appointment_page/model/model_patient_info.dart';
import 'package:asgar_ali_hospital/pages/main_home_page/model/model_doctor_master.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DoctorAppointmentController extends GetxController {
  DoctorAppointmentController({required this.docId});
  final String? docId;
  late BuildContext context;
  late data_api api;
  late CustomAwesomeDialog dialog;
  late CustomBusyLoader loader;
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  late ModelDoctorMaster doctorMaster;
  var list_slot = <ModelAppiontmentSlot>[].obs;
  var list_slot_selected = <ModelAppiontmentSlot>[].obs;
  var dateNames = <String>[].obs; //myList.map((e) => e.name).toSet();
  var chkDate = ''.obs;
  var chkTimeID = ''.obs;
  var isHCN = false.obs;
  var date_of_birth = ''.obs;
  var date_of_birth_temp = ''.obs;
  var isDateShow = false.obs;
  var bg_list = [];
  var list_gender = <ModelGenderMaster>[].obs;
  var bloodGroupID = ''.obs;
  var genderID = ''.obs;
  final TextEditingController txt_hcn = TextEditingController();
  final TextEditingController txt_name = TextEditingController();
  final TextEditingController txt_mobile = TextEditingController();

  void onHCnSubmitted() async {
    dialog = CustomAwesomeDialog(context: context);
    loader = CustomBusyLoader(context: context);
    if (txt_hcn.text.length < 11) {
      return;
    }
    try {
      var x = await api.createLead([
        {"tag": "7", "hcn": txt_hcn.text.toUpperCase()}
      ]);
//print(x);
      ModelPatientInfo p = x.map((e) => ModelPatientInfo.fromJson(e)).isNotEmpty
          ? x.map((e) => ModelPatientInfo.fromJson(e)).first
          : ModelPatientInfo();

      txt_mobile.text = p.cELLPHONE!;
      txt_name.text = p.pATNAME!;
      date_of_birth.value = p.dOB!;
      genderID.value = p.sEX!;
      bloodGroupID.value = p.bLOODGRP!;
        } catch (e) {
      dialog
        ..dialogType = DialogType.error
        ..message = "No information found!"
        ..show();
    }
  }

  void saveAppointment() async {
    print("object");

    dialog = CustomAwesomeDialog(context: context);
    loader = CustomBusyLoader(context: context);

    if (chkTimeID.value == '') {
      dialog
        ..dialogType = DialogType.error
        ..message = "Please select appointment slot time!"
        ..show();
      return;
    }
    if (isHCN.value) {
      if (txt_hcn.text.length < 11) {
        dialog
          ..dialogType = DialogType.error
          ..message = "Please enter valid HCN!"
          ..show();
        return;
      }
    }
    if (txt_mobile.text.length < 11) {
      dialog
        ..dialogType = DialogType.error
        ..message = "Please enter valid Mobile number!"
        ..show();
      return;
    }
    if (txt_mobile.text.length < 11) {
      dialog
        ..dialogType = DialogType.error
        ..message = "Patient's name required!"
        ..show();
      return;
    }
    if (date_of_birth.value.length < 10) {
      dialog
        ..dialogType = DialogType.error
        ..message = "Patient's date of birth required!"
        ..show();
      return;
    }
    if (genderID.value == '') {
      dialog
        ..dialogType = DialogType.error
        ..message = "Please select gender!"
        ..show();
      return;
    }
    if (bloodGroupID.value == '') {
      dialog
        ..dialogType = DialogType.error
        ..message = "Please select blood group!"
        ..show();
      return;
    }
    DateTime dateTime = DateFormat('dd/MM/yyyy').parse(date_of_birth.value);
// final age = now.year - birthday.year;
    //"tag":"9","p_hcn":"' + hcn + '","p_pat_name":"' + encodeURIComponent(name) + '","p_gender":"' + _sex + '","p_age_y":"' + _yyyy + '",  "p_age_m":"' + _mm + '","p_age_d":"' + _dd + '","p_mobile":"' + mobile + '","p_email":"' + _email + '","p_doctor_id":"'+doc_id+'","p_appoint_date":"' + appdate + '","p_approx_s_time":"' + slotid + '","P_Address":"' + encodeURIComponent(_address) + '","P_NID":"' + _nid + '",    }]
    Age age = await AgeCalculator(dateTime);
    //print(age.toString());
    try {
      loader.show();
      api.createLead([
        {
          "tag": "68",
          "p_hcn": txt_hcn.text,
          "p_pat_name": txt_name.text,
          "p_gender": genderID.value,
          "p_age_y": age.years.toString(),
          "p_age_m": age.months.toString(),
          "p_age_d": age.days.toString(),
          "p_mobile": txt_mobile.text,
          "p_email": "",
          "p_doctor_id": doctorMaster.dOCID,
          "p_appoint_date": chkDate.value,
          "p_approx_s_time": chkTimeID.value,
          "P_Address": "",
          "P_NID": ""
        }
      ]).then((value) {
        loader.close();
        print(value);
        if (value == []) {
          dialog
            ..dialogType = DialogType.error
            ..message = "Appointment Booked Error!"
            ..show();
          return;
        }
        ModelStatus s = value.map((e) => ModelStatus.fromJson(e)).first;
        if (s.status.toString() != "1") {
          dialog
            ..dialogType = DialogType.error
            ..message = s.msg!
            ..show();
          return;
        }
        list_slot.removeWhere((element) => element.iD == chkTimeID.value);
         list_slot_selected.removeWhere((element) => element.iD == chkTimeID.value);
        dialog
          ..dialogType = DialogType.success
          ..message = s.msg!
          ..show()
          ..onTap = () {
            Navigator.pop(context);
          };
      });
    } catch (e) {
      loader.close();
      dialog
        ..dialogType = DialogType.error
        ..message = e.toString()
        ..show();
    }
  }

  void selectDate() {
    chkTimeID.value = '';
    list_slot_selected.clear();
    list_slot_selected.addAll(
        list_slot.where((element) => element.aPPOINTMENTDATE == chkDate.value));
  }

  @override
  void onInit() async {
    super.onInit();
    bg_list = [
      '--',
      'A+',
      'A-',
      'B+',
      'B-',
      'O+',
      'O-',
      'AB+',
      'AB-',
      'Unknown'
    ];
    list_gender.addAll([
      ModelGenderMaster(iD: "M", nAME: "Male"),
      ModelGenderMaster(iD: "F", nAME: "Female"),
      ModelGenderMaster(iD: "O", nAME: "Others")
    ]);
    api = data_api();
    try {
      isLoading.value = true;
      var x = await api.createLead([
        {"tag": "67", "p_doctor_id": docId}
      ]);
      // print(x);

      list_slot.addAll(x.map((e) => ModelAppiontmentSlot.fromJson(e)));
      Set<String> distinctNames =
          list_slot.map((e) => e.aPPOINTMENTDATE!).toSet();
      dateNames.addAll(distinctNames);
      chkDate.value = dateNames.isEmpty ? "" : dateNames.first.toString();
      if (chkDate.isNotEmpty) {
        list_slot_selected.clear();
        list_slot_selected.addAll(list_slot
            .where((element) => element.aPPOINTMENTDATE == chkDate.value));
      }

      if (DataStaticUser.hcn != '') {
        isHCN.value = true;
        txt_hcn.text = DataStaticUser.hcn;

        txt_name.text = DataStaticUser.name;
        txt_mobile.text = DataStaticUser.mob;
        date_of_birth.value = DataStaticUser.dob;
        // print(DataStaticUser.dob);
      }

      isLoading.value = false;
    } catch (e) {
      errorMessage.value = e.toString();
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    list_slot.clear();
    dateNames.clear();

    super.onClose();
  }
}
