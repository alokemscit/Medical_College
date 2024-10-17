// ignore_for_file: non_constant_identifier_names

import 'package:asgar_ali_hospital/common_model/model_status.dart';
import 'package:asgar_ali_hospital/constant/const.dart';
import 'package:asgar_ali_hospital/custom_widget/custom_awesome_dialog.dart';
import 'package:asgar_ali_hospital/custom_widget/custom_bysy_loader.dart';
 
import 'package:asgar_ali_hospital/custom_widget/pdf_viewer.dart';
import 'package:asgar_ali_hospital/data/data_api.dart';
import 'package:asgar_ali_hospital/data/data_static_user.dart';
import 'package:asgar_ali_hospital/pages/lab_report_page/model/model_inv_pres.dart';
import 'package:asgar_ali_hospital/pages/lab_report_page/model/model_mob_hcn.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
 import 'package:flutter/material.dart';
 import 'package:get/get.dart';
import 'package:intl/intl.dart';

class LabReportPageController extends GetxController {
  late BuildContext context;
  late data_api api;
  late CustomAwesomeDialog dialog;
  late CustomBusyLoader loader;
  var isLoading = false.obs;
  var isLoadingInv = false.obs;
  var list_pat_with_hcn = <ModelPatWithHCN>[].obs;
  var list_inv_pres_with_hcn = <ModelInvPresWithHCN>[].obs;

  var list_inv_list = <_InvList>[].obs;

  var selectedHCN = ''.obs;

  void viewInvReport(ModelInvPresWithHCN e) async {
    loader = CustomBusyLoader(context: context);
    dialog = CustomAwesomeDialog(context: context);
    try {
      loader.show();
      api.createLead([
        {"rid": e.rID, "gid": e.rGID, "id": e.tDID}
      ], "get_pdf_report").then((value) {
        loader.close();

        if (value != []) {
          //print(value);
          ModelStatus s = value.map((e) => ModelStatus.fromJson_2(e)).first;
          //print(s.msg);
          if (s.status != "1") {
            dialog
              ..dialogType = DialogType.error
              ..message = s.msg!
              ..show();
            return;
          }
          String urls =
              "https://web.asgaralihospital.com/OtherProject/PatientReport/pub/${s.msg!}.pdf";

          Navigator.push(
            context,
            MaterialPageRoute<dynamic>(
              builder: (_) => PDFViewerFromUrl(
                url: urls,
              ),
            ),
          );
        }
      });
    } catch (e) {
      loader.close();
      dialog
        ..dialogType = DialogType.error
        ..message = e.toString()
        ..show();
    }
  }

  void loadInvestigation() async {
    loader = CustomBusyLoader(context: context);
    dialog = CustomAwesomeDialog(context: context);
    try {
      isLoadingInv.value = true;
      list_inv_list.clear();
      list_inv_pres_with_hcn.clear();
      // loader.show();
      var x = await api.createLead([
        {"tag": "13", "hcn": selectedHCN.value}
      ]);
      list_inv_pres_with_hcn.addAll(x
          .map((e) => ModelInvPresWithHCN.fromJson(e))
          .where((element) => element.tP == 'opd'));
      print(x);
      Map<String, int> counts = {};

      // Count occurrences of DOC_ID, DT, and DOC_NAME combinations
      var y = list_inv_pres_with_hcn.where((p0) => p0.tP == 'opd');
      for (var item in y) {
        String key = '${item.dOCID}^${item.dT}^${item.dOCNAME}^${item.mRID}';
        counts[key] = (counts[key] ?? 0) + 1;
      }

      // Print the counts
      // print('DOC_ID\tDT\tDOC_NAME\trow count');
      counts.forEach((key, value) {
        var parts = key.split('^');
        var docId = parts[0].trim();
        var dt = parts[1].trim();
        var docName = parts[2].trim();
        var mrid = parts[3].trim();
        // print('$docId\t$dt\t$docName\t$value');
        list_inv_list.add(_InvList(
            docId: docId,
            docName: docName,
            date: dt,
            mrid: mrid,
            no: value.toString()));
      });

      list_inv_list.sort((a, b) => DateFormat("dd/MM/yyyy")
          .parse(b.date!)
          .compareTo(DateFormat("dd/MM/yyyy").parse(a.date!)));

      //loader.close();
      isLoadingInv.value = false;
      //loadInvestigation();
    } catch (e) {
      //loader.close();
      isLoadingInv.value = false;
      dialog
        ..dialogType = DialogType.error
        ..message = e.toString()
        ..show();
    }
  }

  @override
  void onInit() async {
    super.onInit();
    api = data_api();
    try {
      isLoading.value = true;
      var x = await api.createLead([
        {"tag": "14", "mob": DataStaticUser.mob}
      ]);
      list_pat_with_hcn.addAll(x.map((e) => ModelPatWithHCN.fromJson(e)));
      // selectedHCN.value = DataStaticUser.hcn;
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
    }
  }
}

class _InvList {
  String? docId;
  String? docName;
  String? date;
  String? no;
  String? mrid;
  _InvList({this.docId, this.date, this.docName, this.no, this.mrid});
}

