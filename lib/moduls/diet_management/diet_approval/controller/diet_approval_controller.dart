// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:agmc/core/config/const.dart';
import 'package:agmc/core/shared/user_data.dart';
import 'package:equatable/equatable.dart';

import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart';

import '../../../../model/model_common.dart';
import '../../../../model/model_status.dart';
import '../../../../widget/custom_pdf_generatoe.dart';
import '../../diet_assign/model/model_diet_assigned_data.dart';
import '../../diet_assign/model/model_diet_item_summary.dart';
import '../../diet_assign/model/model_ns_patient_list.dart';
import '../../diet_category/model/model_diet_master.dart';
import '../../diet_meal_ietm/model/model_meal_item.dart';
import '../../diet_mealplan/model/model_meal_plan_config.dart';
import '../../shared/diet_common_function.dart';
import '../model/model_diet_approved_ns.dart';

class DietApprovalController extends GetxController with MixInController {
  var selectedDiettypeID = ''.obs;
  var selectedWeekID = ''.obs;
  var selectedTimeID = ''.obs;
  //var selectedNsID = ''.obs;
  var selectedConfigID = ''.obs;

  var selectedTabID = ''.obs;

  final TextEditingController txt_date = TextEditingController();
  final TextEditingController txt_search = TextEditingController();

  var list_diet_type = <ModelCommon>[].obs;
  var list_week = <ModelCommon>[].obs;
  var list_time = <ModelCommon>[].obs;
  var list_plan_configured = <ModelPlanConfiguedData>[].obs;

  var list_patient = <ModelNsPatientList>[].obs;
  var list_final_list = <_menu>[].obs;
  var list_final_list_main = <_menu>[].obs;
  var _list_menu = <_ModelMenuConfig>[].obs;
  var list_meal_attributes = <ModelMealItemMaster>[].obs;
  var lis_diet_master = <ModelDietMaster>[].obs;

  var list_diet_assigned_data = <ModelDietAssignedData>[].obs;

  var list_ns = <ModelCommon>[].obs;
  var list_diet_summ = <ModelDietAssignedSummaryData>[].obs;
  var list_diet_approved_ns = <ModelDietAssignedApprovedNs>[].obs;

  var col = <int>[].obs;

  bool b = true;
  void toolEvent(ToolMenuSet v) {
    if (!b) return;
    b = false;
    if (v == ToolMenuSet.undo) {
      mToolEnableDisable(list_tool, [], [
        ToolMenuSet.save,
        ToolMenuSet.undo,
        ToolMenuSet.print,
        ToolMenuSet.approve
      ]);
      undo();
    }
    if (v == ToolMenuSet.print) {
      viewPrint();
    }
    if (v == ToolMenuSet.save) {
      save();
    }
    if (v == ToolMenuSet.approve) {
      approve();
    }
    Future.delayed(const Duration(milliseconds: 300), () {
      b = true;
    });
  }

  void approve() async {
    dialog = CustomAwesomeDialog(context: context);
    loader = CustomBusyLoader(context: context);
    try {
      var y = (DateFormat('dd/MM/yyyy').parse(txt_date.text).weekday % 7 + 1)
          .toString();
      // in varchar2,p_day_id in int,  in int, in int, in varchar2,p_eid
      ModelStatus s = await commonSaveUpdate(
          api,
          loader,
          dialog,
          [
            {
              "tag": "23",
              "p_date": txt_date.text,
              "p_day_id": y,
              "p_time_id": selectedTimeID.value,
              "p_diet_type_id": selectedDiettypeID.value,
              "p_ns_id": selectedTabID.value,
              "p_eid": user.value.eMPID
            }
          ],
          'getdata_ipd');
      if (s.status == '1') {
        list_diet_approved_ns.clear();
        dialog
          ..dialogType = DialogType.success
          ..message = s.msg!
          ..show()
          ..onTap = () async {
            // p_date in varchar2,p_day_id in int,p_time_id  in int,p_diet_type_id in int,p_ns_id
            await mLoadModel_All(
                api,
                [
                  {
                    "tag": "22",
                    "p_date": txt_date.text,
                    "p_day_id": y,
                    "p_time_id": selectedTimeID.value,
                    "p_diet_type_id": selectedDiettypeID.value,
                    "p_ns_id": "0",
                  }
                ],
                list_diet_approved_ns,
                (e) => ModelDietAssignedApprovedNs.fromJson(e),
                'getdata_ipd');
          };
      }
    } catch (e) {}
  }

  void undo() {
    txt_search.text = '';
    selectedTabID.value = '';
    list_final_list_main.clear();
    list_final_list.clear();
  }

  @override
  void onInit() async {
    isLoading.value = true;
    api = data_api();

    user.value = await getUserInfo();
    if (!await isValidLoginUser(this)) return;
    try {
      font.value = await CustomLoadFont(appFontPathRoboto);

      await Diet_Get_DietType(api, list_diet_type);

      await Diet_Get_DietWeek(api, list_week);

      await Diet_Get_DietTime(api, list_time);

//await Diet_Get_NurseStation(api, lis_nurse_station);
      await Diet_Get_DietConfigData(api, list_plan_configured);

      await mLoadModel_All(
          api,
          [
            {"tag": "20"}
          ],
          list_ns,
          (e) => ModelCommon.fromJson(e),
          'getdata_ipd');
      isLoading.value = false;
    } catch (e) {
      CustomInitError(this, e.toString());
    }
    super.onInit();
  }

  @override
  void onClose() {
     txt_date.dispose();
  txt_search.dispose();

  // Clear Rx lists and reset values if needed
  list_diet_type.clear();
  list_week.clear();
  list_time.clear();
  list_plan_configured.clear();
  list_patient.clear();
  list_final_list.clear();
  list_final_list_main.clear();
  _list_menu.clear();
  list_meal_attributes.clear();
  lis_diet_master.clear();
  list_diet_assigned_data.clear();
  list_ns.clear();
  list_diet_summ.clear();
  list_diet_approved_ns.clear();
  col.clear();
 
    super.onClose();
  }

  void updateMenuItem(String id, String sl, String newValue) {
    var menuItem = list_final_list.firstWhere((e) => e.regid == id);
    for (var menu in menuItem.menu) {
      if (menu.sl == sl) {
        menu.val = newValue;
      }
    }
    list_final_list.refresh(); // Refresh the list to update the UI
  }

  void setDiet(_menu list, String? v) {
    list.dietid = v;
    var y = '';
    try {
      var k = DateFormat('dd/MM/yyyy').parse(txt_date.text).weekday;
      y = (k == 7 ? 1 : k + 1).toString();
    } catch (e) {}

    for (var menu in list.menu) {
      menu.val = _getItemID(selectedDiettypeID.value, y, selectedTimeID.value,
          menu.id ?? '', menu.sl ?? '', v!);
    }
    list_final_list.refresh();
    list_final_list_main
      ..clear()
      ..addAll(list_final_list);

    mToolEnableDisable(list_tool, [
      ToolMenuSet.save,
      ToolMenuSet.undo,
    ], [
      ToolMenuSet.print,
      ToolMenuSet.approve
    ]);
  }

  String _getItemID(String dietTypeId, String dayID, String timeID,
      String menuID, String sl, String mealID) {
    var x = list_plan_configured.where((e) =>
        e.dayId == dayID &&
        e.dietTypeId == dietTypeId &&
        e.timeId == timeID &&
        e.menuId == menuID &&
        e.sl == sl &&
        e.mealId == mealID);
    if (x.isNotEmpty) {
      // print(x.first.itemId ?? '');
      return x.first.itemId ?? '';
    } else {
      return '';
    }
  }

  void loadPatient() async {
    selectedConfigID.value = '';
    list_patient.clear();
    list_final_list.clear();
    list_final_list_main.clear();
    _list_menu.clear();
    list_meal_attributes.clear();
    lis_diet_master.clear();
    list_diet_summ.clear();
    list_diet_approved_ns.clear();
    mToolEnableDisable(list_tool, [], [
      ToolMenuSet.save,
      ToolMenuSet.undo,
      ToolMenuSet.print,
      ToolMenuSet.approve
    ]);
    // list_sum_menu.clear();
    loader = CustomBusyLoader(context: context);
    dialog = CustomAwesomeDialog(context: context);
    if (selectedDiettypeID.value.isNotEmpty &&
        selectedTimeID.value.isNotEmpty &&
        selectedTabID.value != '') {
      loader.show();
      try {
        var y = (DateFormat('dd/MM/yyyy').parse(txt_date.text).weekday % 7 + 1)
            .toString();

        await mLoadModel_All(
            api,
            [
              {
                "tag": "21",
                "p_date": txt_date.text,
                "p_day_id": y,
                "p_time_id": selectedTimeID.value,
                "p_diet_type_id": selectedDiettypeID.value,
                "ns_id": selectedTabID.value
              }
            ],
            list_diet_summ,
            (e) => ModelDietAssignedSummaryData.fromJson(e),
            'getdata_ipd');

        await mLoadModel_All(
            api,
            [
              {
                "tag": "22",
                "p_date": txt_date.text,
                "p_day_id": y,
                "p_time_id": selectedTimeID.value,
                "p_diet_type_id": selectedDiettypeID.value,
                "p_ns_id": "0",
              }
            ],
            list_diet_approved_ns,
            (e) => ModelDietAssignedApprovedNs.fromJson(e),
            'getdata_ipd');

        var x = await api.createLead([
          {
            "tag": "14",
            "p_date": txt_date.text,
            "p_day_id": y,
            "p_time_id": selectedTimeID.value,
            "p_diet_type_id": selectedDiettypeID.value
          }
        ], 'getdata_ipd');
        list_diet_assigned_data
          ..clear()
          ..addAll(x.map((e) => ModelDietAssignedData.fromJson(e)));
        //list_sum_menu

        x = await api.createLead([
          {
            "tag": "106",
            "p_timeid": selectedTimeID.value,
            "p_diet_typeid": selectedDiettypeID.value
          }
        ]);
        _list_menu.addAll(x.map((e) => _ModelMenuConfig.fromJson(e)));

        x = await api.createLead([
          {"tag": "107", "p_diet_typeid": selectedDiettypeID.value}
        ]);

        list_meal_attributes
            .addAll(x.map((e) => ModelMealItemMaster.fromJson(e)));

        x = await api.createLead([
          {"tag": "97", "p_type_id": selectedDiettypeID.value}
        ]);

        lis_diet_master.addAll(x.map((e) => ModelDietMaster.fromJson(e)));

        await mLoadModel_All(
            api,
            [
              {"tag": "19", "p_ns_id": selectedTabID.value}
            ],
            list_patient,
            (e) => ModelNsPatientList.fromJson(e),
            'getdata_ipd');

        for (var e in list_patient) {
          final regId = e.regId!;
          final menuCopy = List.generate(_list_menu.length, (i) {
            final menu = _ModelMenuConfig.fromMenu(_list_menu[i]);
            if ((menu.id ?? '').isNotEmpty && (menu.sl ?? '').isNotEmpty) {
              menu.val = _getItemID_Saved(regId, menu.id!, menu.sl!);
            }
            return menu;
          }).where((menu) => menu.sl != null).toList();

          list_final_list.add(_menu(
            hcn: e.hcn,
            hcn_cell: cutomCell(
              e.hcn ?? '',
              () {
                selectedConfigID.value = e.regId ?? '';
              },
            ),
            regid: regId,
            regid_cell: cutomCell(
              e.regId ?? '',
              () {
                selectedConfigID.value = e.regId ?? '';
              },
            ),
            name: e.patName,
            name_cell: cutomCell(
              e.patName ?? '',
              () {
                selectedConfigID.value = e.regId ?? '';
              },
            ),
            bedno: e.bedNo,
            bedno_cell: cutomCell(e.bedNo ?? '', () {
              selectedConfigID.value = e.regId ?? '';
            }),
            nsName: e.nsName ?? '',
            nsName_cell: cutomCell(e.nsName ?? '', () {
              selectedConfigID.value = e.regId ?? '';
            }),
            remarks: TextEditingController(text: _getSavedRemarks(regId)),
            dietid: _getSavedDietID(regId),
            menu: menuCopy,
          ));
        }

        list_final_list_main
          ..clear()
          ..addAll(list_final_list);

        if (list_final_list_main.isNotEmpty) {
          if (list_diet_approved_ns
              .where((e) => e.nsId == selectedTabID.value)
              .isNotEmpty) {
            mToolEnableDisable(list_tool, [
              ToolMenuSet.print,
            ], [
              ToolMenuSet.save,
              ToolMenuSet.undo,
              ToolMenuSet.approve
            ]);
          } else {
            mToolEnableDisable(list_tool, [
              //  ToolMenuSet.save,
              ToolMenuSet.undo,
              ToolMenuSet.print,
              ToolMenuSet.approve
            ], []);
          }
        }

        col.clear();
        // hcn,reg,name,bed,rem,
        col.value = [16, 35, 35, 40, 60, 30, 60, 50];
        for (var e in _list_menu) {
          if (e.sl != null) col.add(35);
        }
        // print('Execution Done');
        loader.close();
      } catch (e) {
        loader.close();
        dialog
          ..dialogType = DialogType.error
          ..message = e.toString()
          ..show();
      }
    }
  }

  void search() {
    list_final_list
      ..clear()
      ..addAll(list_final_list_main.where((e) =>
          (e.name ?? '')
              .toUpperCase()
              .contains(txt_search.text.toUpperCase()) ||
          (e.hcn ?? '').toUpperCase().contains(txt_search.text.toUpperCase()) ||
          (e.regid ?? '')
              .toUpperCase()
              .contains(txt_search.text.toUpperCase()) ||
          (e.bedno ?? '')
              .toUpperCase()
              .contains(txt_search.text.toUpperCase())));
  }

  void save() async {
    loader = CustomBusyLoader(context: context);
    dialog = CustomAwesomeDialog(context: context);
    List<Map<String, dynamic>> list = [];

    for (var e in list_final_list) {
      //  print('Diet ID : ${e.id} Diedt name: ${e.name}');
      for (var action in e.menu) {
        if ((action.val ?? '') != '' &&
            (action.id ?? '') != '' &&
            e.dietid != '' &&
            (action.sl ?? '') != '') {
          list.add({
            "reg_id": e.regid,
            "note": e.remarks!.text,
            "diet_id": e.dietid,
            "menu_id": action.id,
            "item_id": action.val,
            "sl": action.sl
          });
        }
      }
    }
    if (isCheckCondition(
        list.isEmpty, dialog, 'No menu configured to save data!')) return;
    try {
      var y = '';

      var k = DateFormat('dd/MM/yyyy').parse(txt_date.text).weekday;
      y = (k == 7 ? 1 : k + 1).toString();

      ModelStatus st = await commonSaveUpdate(
          api,
          loader,
          dialog,
          [
            {
              "tag": "13",
              "p_date": txt_date.text,
              "p_day_id": y,
              "p_time_id": selectedTimeID.value,
              "p_diet_type_id": selectedDiettypeID.value,
              "p_emp_id": user.value.eMPID,
              "p_json": jsonEncode(list)
            }
          ],
          'getdata_ipd');

      if (st.status == '1') {
        list_diet_summ.clear();
        dialog
          ..dialogType = DialogType.success
          ..message = st.msg!
          ..show()
          ..onTap = () async {
            try {
              loader.show();
              await mLoadModel_All(
                  api,
                  [
                    {
                      "tag": "21",
                      "p_date": txt_date.text,
                      "p_day_id": y,
                      "p_time_id": selectedTimeID.value,
                      "p_diet_type_id": selectedDiettypeID.value,
                      "ns_id": selectedTabID.value
                    }
                  ],
                  list_diet_summ,
                  (e) => ModelDietAssignedSummaryData.fromJson(e),
                  'getdata_ipd');
              loader.close();
              viewPrint();

              mToolEnableDisable(list_tool, [
                //  ToolMenuSet.save,
                ToolMenuSet.undo,
                ToolMenuSet.print,
                ToolMenuSet.approve
              ], [
                ToolMenuSet.save
              ]);
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
      dialog
        ..dialogType = DialogType.error
        ..message = e.toString()
        ..show();
    }

    //print(jsonEncode(list));
  }

  void viewPrint() async {
    loader = CustomBusyLoader(context: context);
    dialog = CustomAwesomeDialog(context: context);
    if (list_final_list.isEmpty) {
      dialog
        ..dialogType = DialogType.warning
        ..message = 'No Record found!'
        ..show();
      return;
    }

    var col1 = [35, 35, 60, 30, 60, 50];
    for (var e in _list_menu) {
      if (e.sl != null) col1.add(35);
    }

    List<_sumMenu> mList = [];
    List<_sumMenu> list = [];
    list_diet_summ.forEach((f) {
      list.add(_sumMenu(id: f.menuId, name: f.menuName));
    });
    mList.addAll(list.toSet().toList());

    CustomPDFGenerator(
            font: font.value,
            header: [
              pwTextOne(font.value, "Date      : ", txt_date.text, 9,
                  pwMainAxisAlignmentStart),
              pwHeight(4),
              pwTextOne(
                  font.value,
                  "NS. Name  : ",
                  list_ns.firstWhere((e) => e.id == selectedTabID.value).name ??
                      '',
                  9,
                  pwMainAxisAlignmentStart),
              pwHeight(4),
              pwTextOne(
                  font.value,
                  "Diet Time : ",
                  list_time
                          .firstWhere((e) => e.id == selectedTimeID.value)
                          .name ??
                      '',
                  9,
                  pwMainAxisAlignmentStart),
            ],
            footer: [
              pwTextOne(font.value, "Printed By : ", user.value.eMPNAME ?? '',
                  9, pwMainAxisAlignmentStart),
            ],
            body: [
              pwGenerateTable(col1, [
                pwTableCell('HCN', font.value),
                pwTableCell('Adm.No', font.value),
                pwTableCell('Name', font.value),
                pwTableCell('Bed No', font.value),
                pwTableCell('Remarks', font.value),
                pwTableCell('Diet', font.value),
                for (var i = 0; i < list_final_list.first.menu.length; i++)
                  if (list_final_list.first.menu[i].sl != null)
                    pwTableCell(list_final_list.first.menu[i].name!, font.value,
                        pwAligmentCenter),
              ], [
                for (var i = 0; i < list_final_list.length; i++)
                  pwTableRow([
                    pwTableCell(list_final_list[i].hcn ?? '', font.value,
                        pwAligmentLeft, 6),
                    pwTableCell(list_final_list[i].regid ?? '', font.value,
                        pwAligmentLeft, 6),
                    pwTableCell(list_final_list[i].name ?? '', font.value,
                        pwAligmentLeft, 6),
                    pwTableCell(list_final_list[i].bedno ?? '', font.value,
                        pwAligmentLeft, 6),
                    pwTableCell(list_final_list[i].remarks!.text, font.value,
                        pwAligmentLeft, 6),
                    pwTableCell(
                        (list_final_list[i].dietid ?? '') == ''
                            ? ''
                            : _pwGetDietName(list_final_list[i].dietid ?? ''),
                        font.value,
                        pwAligmentLeft,
                        6),
                    for (var j = 0; j < list_final_list[i].menu.length; j++)
                      if ((list_final_list[i].menu[j].sl ?? '') != '')
                        pwTableCell(
                            (list_final_list[i].menu[j].val ?? '') == ''
                                ? ''
                                : _pwGetItemName(
                                    list_final_list[i].menu[j].val ?? ''),
                            font.value,
                            pwAligmentLeft,
                            6),
                  ]),
              ]),
              mList.isEmpty ? pwHeight(0) : pwHeight(18),
              mList.isEmpty
                  ? pwHeight(0)
                  : pwTextOne(font.value, "Item Summary  : ", '', 7,
                      pwMainAxisAlignmentStart),
              mList.isEmpty
                  ? pwHeight(0)
                  : pwSizedBoxWithWidth(
                      300,
                      pwGenerateTable([
                        30,
                        60
                      ], [
                        pwTableCell('Menu Name', font.value),
                        pwTableCell('Particulars', font.value)
                      ], [
                        ...mList.map((e) => pwTableRow([
                              pwTableCell(e.name ?? '', font.value),
                              pwGenerateTable([
                                50,
                                20
                              ], [
                               
                              ], [
                                ...list_diet_summ
                                    .where((f) => f.menuId == e.id)
                                    .map((a) => pwTableRow([
                                          pwTableCell(
                                              a.itemName ?? '', font.value),
                                          pwTableCell((a.cnt ?? 0.0).toString(),
                                              font.value, pwAligmentCenter)
                                        ])),
                              ])
                            ]))
                      ])),
            ],
            fun: () {},
            orientation: PageOrientation.landscape)
        .ShowReport();
  }

  String _pwGetItemName(
    String id,
  ) {
    // print(id);
    if (id == '0') return '';
    var x = list_meal_attributes.where((e) => e.id == id);
    if (x.isNotEmpty) {
      return x.first.name ?? '';
    }
    return '';
  }

  String _pwGetDietName(String id) {
    var x = lis_diet_master.where((e) => e.id == id);
    if (x.isNotEmpty) {
      return x.first.name ?? '';
    }
    return '';
  }

  String _getSavedRemarks(String regid) {
    var x = list_diet_assigned_data.where((e) => e.regId == regid
        // &&  e.itemId == itemid
        );
    if (x.isNotEmpty) {
      // print(x.first.itemId ?? '');
      return x.first.note ?? '';
    } else {
      return '';
    }
  }

  String _getSavedDietID(String regid) {
    var x = list_diet_assigned_data.where((e) => e.regId == regid
        // &&  e.itemId == itemid
        );
    if (x.isNotEmpty) {
      // print(x.first.itemId ?? '');
      return x.first.dietId ?? '';
    } else {
      return '';
    }
  }

  String _getItemID_Saved(String regid, String menuID, String sl) {
    var x = list_diet_assigned_data
        .where((e) => e.regId == regid && e.menuId == menuID && e.sl == sl
            // &&  e.itemId == itemid
            );
    if (x.isNotEmpty) {
      // print(x.first.itemId ?? '');
      return x.first.itemId ?? '';
    } else {
      return '';
    }
  }

  void textRemarksChenged() {
    mToolEnableDisable(list_tool, [
      ToolMenuSet.save,
      ToolMenuSet.undo,
    ], [
      ToolMenuSet.print,
      ToolMenuSet.approve
    ]);
  }
}

class _menu {
  String? hcn;
  CustomTableCellx? hcn_cell;
  String? regid;
  CustomTableCellx? regid_cell;
  String? name;
  CustomTableCellx? name_cell;
  String? bedno;
  CustomTableCellx? bedno_cell;
  String? nsName;
  CustomTableCellx? nsName_cell;
  TextEditingController? remarks;
  String? dietid;

  List<_ModelMenuConfig> menu;
  _menu({
    this.hcn,
    this.regid,
    this.name,
    this.bedno,
    this.remarks,
    this.dietid,
    required this.menu,
    this.nsName,
    this.hcn_cell,
    this.regid_cell,
    this.name_cell,
    this.bedno_cell,
    this.nsName_cell,
  });
}

class _ModelMenuConfig {
  String? id;
  String? name;
  String? sl;
  String? ischk;
  String? val;
  _ModelMenuConfig({this.name, this.id, this.ischk, this.sl, this.val});

  _ModelMenuConfig.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    sl = json['sl'];
    ischk = json['ischk'];
  }

  _ModelMenuConfig.fromMenu(_ModelMenuConfig abc)
      : id = abc.id,
        val = abc.val,
        name = abc.name,
        sl = abc.sl,
        ischk = abc.ischk;
}

CustomTableCellx cutomCell(String text, Function() fun) => CustomTableCellx(
      text: text,
      isTextTuncate: true,
      //fontWeight: FontWeight.bold,
      onTap: () {
        fun();
        //selectedConfigID.value = e.regId ?? '';
      },
    );

class _sumMenu extends Equatable {
  String? id;
  String? name;
  _sumMenu({
    this.id,
    this.name,
  });

  @override
  List<Object?> get props => [id, name];
}
