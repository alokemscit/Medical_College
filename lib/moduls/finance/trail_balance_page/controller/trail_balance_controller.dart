 

import 'package:agmc/core/config/const.dart';
import 'package:agmc/core/config/const_widget.dart';
import '../../../../core/shared/user_data.dart';
import '../model/model-trail_ledger.dart';

class TarailBalanceController extends GetxController with MixInController {
  final TextEditingController txt_fromDate = TextEditingController();
  final TextEditingController txt_toDate = TextEditingController();
  var list_traing_balance = <ModelTrailLedger>[].obs;

  var list_group = <_group>[].obs;

  var list_sub = <_sub>[].obs;
  var selectedRadioValue = 1.obs;

  // TableRow _tableRow(_sub data) => TableRow(
  //         decoration:
  //             CustomTableHeaderRowDecorationnew.copyWith(color: Colors.white),
  //         children: [
  //           TableCell(
  //               verticalAlignment: TableCellVerticalAlignment.middle,
  //               child: oneColumnCellBody(data.code!)),
  //           TableCell(
  //               verticalAlignment: TableCellVerticalAlignment.middle,
  //               child: oneColumnCellBody(data.name!)),
  //           TableCell(
  //               verticalAlignment: TableCellVerticalAlignment.middle,
  //               child: twoColumnCellBody(
  //                   data.odr!.toString(), data.ocr!.toString())),
  //           TableCell(
  //               verticalAlignment: TableCellVerticalAlignment.middle,
  //               child: twoColumnCellBody(
  //                   data.tdr!.toString(), data.tcr!.toString())),
  //           TableCell(
  //               verticalAlignment: TableCellVerticalAlignment.middle,
  //               child: twoColumnCellBody(
  //                   data.cdr! > data.ccr!
  //                       ? (data.cdr! - data.ccr!).toString()
  //                       : "0",
  //                   data.ccr! > data.cdr!
  //                       ? (data.ccr! - data.cdr!).toString()
  //                       : "0"))
  //         ]);

  // grouDetails(String id, List<int> _col) {
   
  //   return tableBodyGenerator(
  //       _col,

  //   list_sub.where((p0) => p0.pid ==id)
  //           .map(
  //             (e) => _tableRow(_sub(
  //               pid: e.pid,
  //               id: e.id,
  //               code: e.code,
  //               name: e.name,
  //               odr: e.odr,
  //               ocr: e.ocr,
  //               tdr: e.tdr,
  //               tcr: e.tcr,
  //               cdr: e.cdr,
  //               ccr: e.ccr,
  //             )),
  //           )
  //           .toList()

  //           );
  // }

  void showData() async {
    list_traing_balance.clear();
    list_group.clear();
    list_sub.clear();
    //print('object');
    dialog = CustomAwesomeDialog(context: context);
    loader = CustomBusyLoader(context: context);
    if (txt_fromDate.text == '') {
      dialog
        ..dialogType = DialogType.warning
        ..message = 'Valid from date required'
        ..show();
      return;
    }
    if (txt_toDate.text == '') {
      dialog
        ..dialogType = DialogType.warning
        ..message = 'Valid to date required'
        ..show();
      return;
    }
    //  bool b = isValidDateRange(txt_fromDate.text, txt_toDate.text);
    if (!isValidDateRange(txt_fromDate.text, txt_toDate.text)) {
      dialog
        ..dialogType = DialogType.warning
        ..message = 'From Date and To Date are not a valid date range!'
        ..show();
      return;
    }
    loader.show();
    try {
      var x = await api.createLead([
        {
          "tag": "89",
          "p_cid": user.value.comID,
          "fdate": txt_fromDate.text,
          "tdate": txt_toDate.text
        }
      ]);
      list_traing_balance.addAll(x.map((e) => ModelTrailLedger.fromJson(e)));

      list_group.addAll(list_traing_balance.map((element) =>
          _extractGroupProperty(element, selectedRadioValue.value)));
      list_group = list_group.toSet().toList().obs;
      // print(list_group.length);
// Sort the list based on the 'accid' property
      list_group.sort((a, b) => a.accid!.compareTo(b.accid!));

      List<_group> list = [];
      list_group.forEach((element) {
        if (selectedRadioValue.value == 1) {
          var filteredBalance = list_traing_balance
              .where((p0) => p0.gROUPID == element.id)
              .toList();

          var uniqueGroups = filteredBalance.toSet().toList();

          list.addAll(uniqueGroups.map((e) => _group(
                id: e.sUBID!,
                name: e.sUBNAME!,
                code: e.sUBCODE!,
                accid: e.gROUPID!,
              )));
        } else if (selectedRadioValue.value == 2) {
          var filteredBalance = list_traing_balance
              .where((p0) => p0.sUBID == element.id)
              .toList();

          var uniqueGroups = filteredBalance.toSet().toList();

          list.addAll(uniqueGroups.map((e) => _group(
                id: e.cATID!,
                name: e.cATNAME!,
                code: e.cATCODE!,
                accid: e.sUBID!,
              )));
        } else if (selectedRadioValue.value == 3) {
          var filteredBalance = list_traing_balance
              .where((p0) => p0.cATID == element.id)
              .toList();

          var uniqueGroups = filteredBalance.toSet().toList();

          list.addAll(uniqueGroups.map((e) => _group(
                id: e.gLID!,
                name: e.gLNAME!,
                code: e.gLCODE!,
                accid: e.cATID!,
              )));
        }
      });

      list = list.toSet().toList();

      List<ModelTrailLedger> filteredBalance = [];
      list.forEach((e) {
        //var filteredBalance =
        filteredBalance = [];
        if (selectedRadioValue.value == 1) {
         filteredBalance.addAll(list_traing_balance.where((p0) => p0.sUBID == e.id))   ;
        }
        if (selectedRadioValue.value == 2) {
         filteredBalance.addAll(list_traing_balance.where((p0) => p0.cATID == e.id))   ;
        }
         if (selectedRadioValue.value == 3) {
         filteredBalance.addAll(list_traing_balance.where((p0) => p0.gLID == e.id))   ;
        }

      //  print(e.id);

        list_sub.add(_sub(
          pid: e.accid,
          id: e.id,
          code: e.code,
          name: e.name,
          odr: filteredBalance.fold(
              0.00, (previous, current) => previous! + current.oDR!),
          ocr: filteredBalance.fold(
              0.00, (previous, current) => previous! + current.oCR!),
          tdr: filteredBalance.fold(
              0.00, (previous, current) => previous! + current.tRDR!),
          tcr: filteredBalance.fold(
              0.00, (previous, current) => previous! + current.tRCR!),
          cdr: filteredBalance.fold(
              0.00, (previous, current) => previous! + current.cDR!),
          ccr: filteredBalance.fold(
              0.00, (previous, current) => previous! + current.cCR!),
        ));

        // print(e.id!+e.name!);
      });

      // }

      loader.close();
    } catch (e) {
      loader.close();
      dialog
        ..dialogType = DialogType.error
        ..message = e.toString()
        ..show();
    }
    //loader.show();

    //loader.close();
  }

  _group _extractGroupProperty(
      ModelTrailLedger element, int selectedRadioValue) {
    switch (selectedRadioValue) {
      case 1:
        return _group(
            id: element.gROUPID!,
            name: '${element.cHARTNAME!} => ${element.gROUPNAME!}',
            code: element.gROUPCODE!,
            accid: element.cHARTID!);
      case 2:
        return _group(
            id: element.sUBID!,
            name: '${element.cHARTNAME!} => ${element.gROUPNAME!} => ${element.sUBNAME!}' ,
            code: element.sUBCODE!,
            accid: element.gROUPID!);
      case 3:
        return _group(
            id:  element.cATID!,
            name: '${element.cHARTNAME!} => ${element.gROUPNAME!} => ${element.sUBNAME!} => ${element.cATNAME!}'  ,
            code: element.cATCODE!,
            accid: element.sUBID!);
      default:
        throw ArgumentError('Invalid radio button value');
    }
  }



  @override
  void onInit() async {
    super.onInit();
    isLoading.value = true;
    isError.value = false;

    api = data_api();
    user.value = await getUserInfo();
    if (user == null) {
      isError.value = true;
      errorMessage.value = "Re- Login required";
      isLoading.value = false;
      return;
    }

    isLoading.value = false;
  }
}

class _sub {
  final String? pid;
  final String? id;
  final String? code;
  final String? name;
  final double? odr;
  final double? ocr;
  final double? tdr;
  final double? tcr;
  final double? cdr;
  final double? ccr;

  _sub(
      {required this.pid,
        required this.id,
      required this.code,
      required this.name,
      required this.odr,
      required this.ocr,
      required this.tdr,
      required this.tcr,
      required this.cdr,
      required this.ccr});
}

class _group {
  final String? accid;
  final String? id;
  final String? code;
  final String? name;

  _group(
      {required this.id,
      required this.name,
      required this.code,
      required this.accid});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _group &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name;

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
