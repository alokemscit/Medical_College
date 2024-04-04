// ignore_for_file: use_build_context_synchronously

import 'package:agmc/core/config/const.dart';

import 'package:agmc/core/shared/user_data.dart';
import 'package:agmc/model/model_status.dart';
import 'package:agmc/moduls/finance/ledger_master_page/model/model_ledger_master.dart';
import 'package:agmc/widget/custom_awesome_dialog.dart';
import 'package:agmc/widget/custom_bysy_loader.dart';
import 'package:agmc/widget/custom_snakbar.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

import '../../../../widget/custom_dialog.dart';
import '../../../../widget/custom_textbox.dart';

class LedgerMasterController extends GetxController with MixInController {
  var ledger_list = <ModelLedgerMaster>[].obs;
  final TextEditingController txt_geroup_code = TextEditingController();
  final TextEditingController txt_group_Serial = TextEditingController();
  final TextEditingController txt_geroup_name = TextEditingController();

  final TextEditingController txt_subgeroup_code = TextEditingController();
  final TextEditingController txt_subgroup_Serial = TextEditingController();
  final TextEditingController txt_subgroup_name = TextEditingController();

  final TextEditingController txt_ledger_code = TextEditingController();
  final TextEditingController txt_ledger_Serial = TextEditingController();
  final TextEditingController txt_ledger_name = TextEditingController();

  var is_cc = false.obs;
  var is_sl = false.obs;

  void subGroupPopup(ModelLedgerMaster e) async {
    dialog = CustomAwesomeDialog(context: context);
    bool b = false;
    await CustomDialog(
        context,
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Sub Group Under \\ ${e.nAME!}"),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: 350,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        flex: 5,
                        child: CustomTextBox(
                            isDisable: true,
                            isFilled: false,
                            isReadonly: true,
                            caption: "Code",
                            maxlength: 15,
                            controller: txt_subgeroup_code,
                            onChange: (v) {})),
                    4.widthBox,
                    Expanded(
                        flex: 3,
                        child: CustomTextBox(
                            caption: "Serial",
                            textInputType: TextInputType.number,
                            maxlength: 5,
                            controller: txt_subgroup_Serial,
                            onChange: (v) {})),
                  ],
                ),
                CustomTextBox(
                    caption: "Sub Group Name",
                    maxlength: 150,
                    width: double.infinity,
                    controller: txt_subgroup_name,
                    onChange: (v) {}),
              ],
            ),
          ),
        ), () {
      if (!b) {
        b = true;
        Future.delayed(const Duration(seconds: 2), () {
          b = false;
        });
        if (txt_subgroup_name.text.isEmpty) {
          dialog
            ..dialogType = DialogType.warning
            ..message = 'Please eneter valid Sub Group name!'
            ..show();
          return;
        }
        saveSubGroup(e.iD!);
        //p_cid in int, p_id in int, p_name in varchar2,p_pid in int, p_code in varchar2, p_sl in int, p_isgroup in int
      }
    });
  }

  void saveSubGroup(String pid) async {
    loader = CustomBusyLoader(context: context);
    dialog = CustomAwesomeDialog(context: context);
    try {
      loader.show();

      print({
        "tag": "71",
        "p_cid": user.value.comID,
        "p_id": "0",
        "p_name": txt_subgroup_name.text,
        "p_pid": pid,
        "p_code": txt_subgeroup_code.text,
        "p_sl": txt_subgroup_Serial.text,
        "p_isgroup": "2",
        "p_is_cc": "0",
        "p_is_sl": "0"
      });
      var x = await api.createLead([
        {
          "tag": "71",
          "p_cid": user.value.comID,
          "p_id": "0",
          "p_name": txt_subgroup_name.text,
          "p_pid": pid,
          "p_code": txt_subgeroup_code.text,
          "p_sl": txt_subgroup_Serial.text,
          "p_isgroup": "2",
          "p_is_cc": "0",
          "p_is_sl": "0"
        }
      ]);
      loader.close();
      // print(x);
      ModelStatus s = await getStatusWithDialog(x, dialog);
      if (s.status == "1") {
        ledger_list.add(ModelLedgerMaster(
            cODE: s.extra!,
            iD: s.id,
            iSPARENT: '1',
            nAME: txt_subgroup_name.text,
            pARENTID: pid,
            sL: "1",
            isCC: "0",
            isSL: "0"));

        txt_subgeroup_code.text = '';
        txt_subgroup_name.text = '';
        txt_subgroup_Serial.text = '';
        // dialog
        //   ..dialogType = DialogType.success
        //   ..message = s.msg!
        //   ..show()
        //   ..onTap = () => Navigator.pop(context);
        Navigator.pop(context);
        CustomSnackbar(
            context: context, message: s.msg!, type: MsgType.success);
      }
      //print(x);
    } catch (e) {
      loader.close();
      dialog
        ..dialogType = DialogType.error
        ..message = e.toString()
        ..show();
    }
  }

  void groupPopup(ModelLedgerMaster e) async {
    dialog = CustomAwesomeDialog(context: context);
    bool b = false;
    await CustomDialog(
        context,
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Group Under \\ ${e.nAME!}"),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: 350,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        flex: 5,
                        child: CustomTextBox(
                            isDisable: true,
                            isFilled: false,
                            isReadonly: true,
                            caption: "Code",
                            maxlength: 15,
                            controller: txt_geroup_code,
                            onChange: (v) {})),
                    4.widthBox,
                    Expanded(
                        flex: 3,
                        child: CustomTextBox(
                            caption: "Serial",
                            textInputType: TextInputType.number,
                            maxlength: 5,
                            controller: txt_group_Serial,
                            onChange: (v) {})),
                  ],
                ),
                CustomTextBox(
                    caption: "Group Name",
                    maxlength: 150,
                    width: double.infinity,
                    controller: txt_geroup_name,
                    onChange: (v) {}),
              ],
            ),
          ),
        ), () {
      if (!b) {
        b = true;
        Future.delayed(const Duration(seconds: 2), () {
          b = false;
        });
        if (txt_geroup_name.text.isEmpty) {
          dialog
            ..dialogType = DialogType.warning
            ..message = 'Please eneter valid Group name!'
            ..show();
          return;
        }
        saveGroup(e.iD!);
        //p_cid in int, p_id in int, p_name in varchar2,p_pid in int, p_code in varchar2, p_sl in int, p_isgroup in int
      }
    });
  }

  void ledgerPopup(ModelLedgerMaster e) async {
    dialog = CustomAwesomeDialog(context: context);
    bool b = false;
    await CustomDialog(
        context,
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Ledger Under \\ ${e.nAME!}"),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: 350,
            child: Column(
              children: [
                6.heightBox,
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: customBoxDecoration,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                              flex: 5,
                              child: CustomTextBox(
                                  isDisable: true,
                                  isFilled: false,
                                  isReadonly: true,
                                  caption: "Code",
                                  maxlength: 15,
                                  controller: txt_ledger_code,
                                  onChange: (v) {})),
                          4.widthBox,
                          Expanded(
                              flex: 3,
                              child: CustomTextBox(
                                  caption: "Serial",
                                  textInputType: TextInputType.number,
                                  maxlength: 5,
                                  controller: txt_ledger_Serial,
                                  onChange: (v) {})),
                        ],
                      ),
                      4.heightBox,
                      CustomTextBox(
                          caption: "Ledger Name",
                          maxlength: 150,
                          width: double.infinity,
                          controller: txt_ledger_name,
                          onChange: (v) {}),
                    ],
                  ),
                ),
                4.heightBox,
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: customBoxDecoration,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Obx(() => Checkbox(
                              value: is_cc.value,
                              onChanged: (v) {
                                is_cc.value = v!;
                              })),
                          2.widthBox,
                          Text("Is Cost Center mandatory?",
                              style: customTextStyle.copyWith(
                                  fontSize: 12, fontWeight: FontWeight.bold))
                        ],
                      ),
                      Row(
                        children: [
                          Obx(() => Checkbox(
                              value: is_sl.value,
                              onChanged: (v) {
                                is_sl.value = v!;
                              })),
                          2.widthBox,
                          Text(
                            "Is Sub Ledger mandatory?",
                            style: customTextStyle.copyWith(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ), () {
      if (!b) {
        b = true;
        Future.delayed(const Duration(seconds: 2), () {
          b = false;
        });
        if (txt_ledger_name.text.isEmpty) {
          dialog
            ..dialogType = DialogType.warning
            ..message = 'Please enter valid Group name!'
            ..show();
          return;
        }
        saveLedger(e.iD!);
        //p_cid in int, p_id in int, p_name in varchar2,p_pid in int, p_code in varchar2, p_sl in int, p_isgroup in int
      }
    });
  }

  void saveLedger(String pid) async {
    loader = CustomBusyLoader(context: context);
    dialog = CustomAwesomeDialog(context: context);
    try {
      loader.show();
//p_cid in int, p_id in int, p_name in varchar2,p_pid in int, p_code in varchar2, p_sl in int, p_isgroup in int, p_is_sl in int,p_is_cc in int
      // print({
      //   "tag": "71",
      //   "p_cid": user.value.comID,
      //   "p_id": "0",
      //   "p_name": txt_ledger_name.text,
      //   "p_pid": pid,
      //   "p_code": txt_ledger_code.text,
      //   "p_sl": txt_ledger_Serial.text,
      //   "p_isgroup": "0",
      //   "p_is_cc": is_cc.value ? "1" : "0",
      //   "p_is_sl": is_sl.value ? "1" : "0",
      // });

      var x = await api.createLead([
        {
          "tag": "71",
          "p_cid": user.value.comID,
          "p_id": "0",
          "p_name": txt_ledger_name.text,
          "p_pid": pid,
          "p_code": txt_ledger_code.text,
          "p_sl": txt_ledger_Serial.text,
          "p_isgroup": "0",
          "p_is_sl": is_sl.value ? "1" : "0",
          "p_is_cc": is_cc.value ? "1" : "0",
        }
      ]);
      loader.close();
      // print(x);
      ModelStatus s = await getStatusWithDialog(x, dialog);
      if (s.status == "1") {
        ledger_list.add(ModelLedgerMaster(
            cODE: s.extra!,
            iD: s.id,
            iSPARENT: '0',
            nAME: txt_ledger_name.text,
            pARENTID: pid,
            sL: "1",
            isCC: is_cc.value ? "1" : "0",
            isSL: is_sl.value ? "1" : "0"));

        txt_ledger_code.text = '';
        txt_ledger_name.text = '';
        txt_ledger_Serial.text = '';
        is_cc.value = false;
        is_sl.value = false;
        // dialog
        //   ..dialogType = DialogType.success
        //   ..message = s.msg!
        //   ..show()
        //   ..onTap = () => Navigator.pop(context);
        Navigator.pop(context);
        CustomSnackbar(
            context: context, message: s.msg!, type: MsgType.success);
      }
      //print(x);
    } catch (e) {
      loader.close();
      dialog
        ..dialogType = DialogType.error
        ..message = e.toString()
        ..show();
    }
  }

  void saveGroup(String pid) async {
    loader = CustomBusyLoader(context: context);
    dialog = CustomAwesomeDialog(context: context);
    try {
      loader.show();
      var x = await api.createLead([
        {
          "tag": "71",
          "p_cid": user.value.comID,
          "p_id": "0",
          "p_name": txt_geroup_name.text,
          "p_pid": pid,
          "p_code": txt_geroup_code.text,
          "p_sl": txt_group_Serial.text,
          "p_isgroup": "1",
          "p_is_cc": "0",
          "p_is_sl": "0"
        }
      ]);
      loader.close();
      // print(x);
      ModelStatus s = await getStatusWithDialog(x, dialog);
      if (s.status == "1") {
        ledger_list.add(ModelLedgerMaster(
            cODE: s.extra!,
            iD: s.id,
            iSPARENT: '1',
            nAME: txt_geroup_name.text,
            pARENTID: pid,
            sL: "1",
            isCC: "0",
            isSL: "0"));

        txt_geroup_code.text = '';
        txt_geroup_name.text = '';
        txt_group_Serial.text = '';

        Navigator.pop(context);
        CustomSnackbar(
            context: context, message: s.msg!, type: MsgType.success);
      }
      //print(x);
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
    api = data_api();
    try {
      user.value = await getUserInfo();
      if (user.value == null) {
        isError.value = true;
        isLoading.value = false;
        errorMessage.value = "User re-login required!";
        return;
      }
      print(user.value.comID);
      isError.value = false;
      isLoading.value = true;
      var x = await api.createLead([
        {"tag": "70", "p_cid": user.value.comID}
      ]);
      //print(x);
      ledger_list.addAll(x.map((e) => ModelLedgerMaster.fromJson(e)));
      isLoading.value = false;
    } catch (e) {
      isError.value = true;
      isLoading.value = false;
      errorMessage.value = e.toString();
    }
    super.onInit();
  }
}
