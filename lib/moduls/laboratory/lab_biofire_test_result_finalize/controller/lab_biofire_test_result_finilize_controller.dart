import 'package:equatable/equatable.dart';

import '../../../../core/config/const.dart';
import '../../../../core/shared/user_data.dart';
import '../../../../model/model_status.dart';
import '../../../../widget/pdf_widget/invoice.dart';
import '../../lab_biofire_test_result_entry/model/lab_model_mrr_details_list.dart';
import '../../lab_biofire_test_result_verify/model/model_lab_saved_data.dart';

class BiofireTestFinalizeController extends GetxController
    with MixInController {
  final TextEditingController txt_fdate = TextEditingController();
  final TextEditingController txt_tdate = TextEditingController();
  final TextEditingController txt_search = TextEditingController();
  final TextEditingController txt_method = TextEditingController();
  var list_mrr_details_master = <ModelMrrDetailsList>[].obs;
  var list_mrr_details = <ModelMrrDetailsList>[].obs;
  var selectedMrrID = ModelMrrDetailsList().obs;

  var list_mrr_master = <_mrr>[].obs;
  var list_mrr_master_temp = <_mrr>[].obs;
  //var list_sample_master = <_mrr>[].obs;
  //var list_sample_master_temp = <_mrr>[].obs;

  var isShowLeftPanel = true.obs;
  var selectedRadioValue = 1.obs;
  var isShowFilter = false.obs;

  var list_config_data = <ModelResultData>[].obs;

  var list_group = <_group>[].obs;
  var list_attr = <_attr>[].obs;

  void showReport2(String id, bool isPrv) async {
    dialog = CustomAwesomeDialog(context: context);
    loader = CustomBusyLoader(context: context);
    loader.show();
    try {
      // var y = await api.createLead([
      //   {"tag": isPrv ? "32" : "30", "p_resid": id, "p_rpt": "rpt_bio_report"}
      // ], "getssrs_drs_report");
       var y = await api.createLead([
        {"tag": "38", "p_result_id": id,"is_preview":isPrv?"1":"0", "p_rpt": "rptBIO"}
      ], "get_crystal_drs_report");
      // print(y);
      if (y == []) {
        loader.close();
        dialog
          ..dialogType = DialogType.error
          ..message = 'Report error'
          ..show();
        return;
      }
      ModelStatus mm = y
          .map(
            (e) => ModelStatus.fromJson(e),
          )
          .first;
      if (mm.status != '1') {
        loader.close();
        dialog
          ..dialogType = DialogType.error
          ..message = mm.msg!
          ..show();
        return;
      }
      loader.close();
      PdfInvoiceApi.openPdfBase64(mm.msg!);
    } catch (e) {
      loader.close();
      dialog
        ..dialogType = DialogType.error
        ..message = e.toString()
        ..show();
    }
  }

  void save(bool isPreview) async {
    loader = CustomBusyLoader(context: context);
    dialog = CustomAwesomeDialog(context: context);
    String g = '';
    String a = '';
    list_group.forEach((f) {
      g += '${f.id!}人${f.sl!}人${f.isNote!}人${f.isBin!}人${f.rem!.text}大';
    });
    list_attr.forEach((f) {
      a +=
          '${f.gid!}人${f.id!}人${f.sl!}人${f.isDedect! ? 1 : 0}人${f.ncopy!.text}大';
    });
    try {
      // print({
      //   "tag": "29",
      //   "str_grp": g,
      //   "str_att": a,
      //   "p_testid": selectedMrrID.value.testId,
      //   "p_mrrid": selectedMrrID.value.mrId,
      //   "p_sampleid": selectedMrrID.value.sampleId,
      //   "p_age": selectedMrrID.value.age,
      //   "p_note": txt_method.text,
      //   "p_eid": user.value.eMPID,
      //   "p_status": "1"
      // });
      List<dynamic> x = [];
      if (isPreview) {
        x = await api.createLead([
          {
            "tag": "31",
            "str_grp": g,
            "str_att": a,
            "p_testid": selectedMrrID.value.testId,
            "p_mrrid": selectedMrrID.value.mrId,
            "p_sampleid": selectedMrrID.value.sampleId,
            "p_age": selectedMrrID.value.age,
            "p_note": txt_method.text,
            "p_eid": user.value.eMPID,
            "p_status": "1"
          }
        ], 'getdata_drs');
      } else {
        // p_resid , str_grp ,str_att ,p_testid ,p_mrrid , p_sampleid ,p_note , p_eid ,p_status

        x = await api.createLead([
          {
            "tag": "35",
            "p_resid": selectedMrrID.value.res_id,
            "str_grp": g,
            "str_att": a,
            "p_testid": selectedMrrID.value.testId,
            "p_mrrid": selectedMrrID.value.mrId,
            "p_sampleid": selectedMrrID.value.sampleId,
            "p_note": txt_method.text,
            "p_eid": user.value.eMPID,
            "p_status": "2"
          }
        ], 'getdata_drs');
      }

      // print(x);
      loader.close();
      ModelStatus st = await getStatusWithDialog(x, dialog);
      if (st.status == '1') {
        dialog
          ..dialogType = DialogType.success
          ..message = st.msg!
          ..show()
          ..onTap = () async {
            if (!isPreview) {
              list_mrr_details_master.removeWhere(
                  (f) => f.sampleId == selectedMrrID.value.sampleId);
              list_mrr_details.clear();
              list_mrr_details.addAll(list_mrr_details_master);
              undo_panel();
              dataManipulate();
            }

            showReport2(st.extra!, isPreview);
          };
      }
    } catch (e) {
      loader.close();
      dialog
        ..dialogType = DialogType.error
        ..message = e.toString()
        ..show();
    }

    // print(g);
    // print(a);
  }

  void load_patinfo_test_details(ModelMrrDetailsList a) async {
    loader = CustomBusyLoader(context: context);
    loader.show();
    txt_method.text = '';
    list_config_data.clear();
    list_group.clear();
    list_attr.clear();
    selectedMrrID.value = ModelMrrDetailsList();
    txt_method.text = a.note!;
    dialog = CustomAwesomeDialog(context: context);
    try {
      var x = await api.createLead([
        {"tag": "34", "p_resid": a.res_id}
      ], "getdata_drs");

      if (checkJson(x)) {
        list_config_data.addAll(x.map((e) => ModelResultData.fromJson(e)));
        var list_g = <_group>[];
        var list_a = <_attr>[];
        list_config_data.forEach((f) {
          list_g.add(_group(
              id: f.grpId,
              name: f.grpName,
              isBin: f.isBin,
              isNote: f.isNote,
              sl: f.grpSl,
              rem: TextEditingController(text: f.note)));
          list_a.add(_attr(
              gid: f.grpId,
              id: f.atrId,
              name: f.atrName,
              isDedect: f.isDetected == '1' ? true : false,
              ncopy: TextEditingController(text: f.ncopy),
              typeID: f.typeId,
              sl: f.atrSl));
        });
        list_group.addAll(list_g.toSet().toList());
        list_attr.addAll(list_a.toSet().toList());
        loader.close();
      } else {
        loader.close();
        dialog
          ..dialogType = DialogType.warning
          ..message = 'This Test is not configured!'
          ..show();
        return;
      }

      selectedMrrID.value = a;
    } catch (e) {
      loader.close();
      dialog
        ..dialogType = DialogType.error
        ..message = e.toString()
        ..show();
    }
  }

  void undo_panel() {
    selectedMrrID.value = ModelMrrDetailsList();
    list_attr.clear();
    list_group.clear();
    txt_method.text = '';
    txt_search.text = '';
    list_config_data.clear();
  }

  void clickRadioButtpn() {
    selectedMrrID.value = ModelMrrDetailsList();
    txt_search.text = '';
    list_mrr_details.clear();
    list_config_data.clear();
    list_group.clear();
    list_attr.clear();
    list_mrr_details.addAll(list_mrr_details_master.where((e) =>
        e.mrType ==
        (selectedRadioValue.value == 1
            ? e.mrType
            : selectedRadioValue.value == 2
                ? 'O'
                : selectedRadioValue.value == 3
                    ? 'I'
                    : 'E')));
    list_mrr_details.refresh();
    dataManipulate();
  }

  void search() {
    list_mrr_details.clear();
    list_mrr_details.addAll(list_mrr_details_master.where((e) =>
        e.mrId!.toUpperCase().contains(txt_search.text.toUpperCase()) ||
        e.sampleId!.toUpperCase().contains(txt_search.text.toUpperCase())));
    list_mrr_details.refresh();
    dataManipulate();
  }

  void dataManipulate() {
    list_mrr_master.clear();
    list_mrr_master_temp.clear();
    var mr = <_mrr>[];
    // var sm = <_mrr>[];
    list_mrr_details.forEach((a) {
      mr.add(_mrr(id: a.mrId, name: a.mrId));
      print({"id": a.mrId, "name": a.mrId});
      // sm.add(_mrr(id: a.mrId, name: a.sampleId));
    });
    list_mrr_master.addAll(mr.toSet().toList());
    list_mrr_master_temp.addAll(list_mrr_master);
  }

  @override
  void onInit() async {
    api = data_api();
    isLoading.value = true;
    user.value = await getUserInfo();
    if (user.value.eMPID == null) {
      isLoading.value = false;
      isError.value = true;
      errorMessage.value = 'Re-ligin required!';
      return;
    }
    try {
      var x = await api.createLead([
        {"tag": "36", "fdate": " ", "tdate": " "}
      ], 'getdata_drs');
      if (checkJson(x)) {
        list_mrr_details.addAll((x
            .map((e) => ModelMrrDetailsList.fromJson(e)))
            .where((f) => f.isFinalized  == '0'));
        list_mrr_details_master.addAll(list_mrr_details);
        //print(list_mrr_details.length);
        dataManipulate();
        //list_sample_master.addAll(sm.toSet().toList());
        //list_sample_master_temp.addAll(list_sample_master);
      }
      // print(x);
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      isError.value = true;
      errorMessage.value = e.toString();
    }

    super.onInit();
  }
}

class _attr extends Equatable {
  String? id;
  String? gid;
  String? name;
  bool? isDedect;
  String? typeID;
  String? sl;

  TextEditingController? ncopy;
  _attr({
    this.id,
    this.gid,
    this.name,
    this.isDedect,
    this.ncopy,
    this.typeID,
    this.sl,
  });

  @override
  List<Object?> get props => [id, gid, name, typeID, sl];
}

class _group extends Equatable {
  String? id;
  String? name;
  String? isBin;
  String? isNote;
  String? sl;
  TextEditingController? rem;
  _group({
    this.id,
    this.name,
    this.isBin,
    this.isNote,
    this.sl,
    this.rem,
  });
  @override
  List<Object?> get props => [id, name, isBin, isNote, sl];
}

class _mrr extends Equatable {
  String? id;
  String? name;
  _mrr({
    this.id,
    this.name,
  });

  @override
  List<Object?> get props => [id, name];
}
