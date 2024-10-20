// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:agmc/core/config/const.dart';
import 'package:agmc/core/shared/user_data.dart';
import 'package:agmc/widget/custom_pdf_generatoe.dart';
import 'package:equatable/equatable.dart';

import '../model/mis_model_asset_history.dart';

class MisAssetHistoryController extends GetxController with MixInController {
  var list_asset_master = <ModelMisAssetHistory>[].obs;
  var list_asset_temp = <ModelMisAssetHistory>[].obs;
  var list_asset_temp_master = <ModelMisAssetHistory>[].obs;
  final TextEditingController txt_search = TextEditingController();
  //var list_item_master = <_item>[].obs;
  // var list_item_temp = <_item>[].obs;
  var selectedGroupID = ''.obs;

  var list_group = <_item>[].obs;
  var list_mgroup = <_item>[].obs;

  var selectedItem = _item().obs;

  void setSelectedItem(_item f) {
    selectedItem.value = f;
    list_asset_temp
      ..clear()
      ..addAll(list_asset_master.where((e) => e.iTEMID == f.id));
  }

  

  @override
  void onInit() async {
    api = data_api();
    isLoading.value = true;
    user.value = await getUserInfo();
    if (user.value.eMPID == null) {
      isLoading.value = false;
      isError.value = true;
      errorMessage.value = 'Re-Login Required!';
      return;
    }
    font.value = await CustomLoadFont(appFontPathRoboto);
    try {
      var x = await api.createLead([
        {"tag": "12"}
      ], 'getdata_mc');
      if (checkJson(x)) {
        list_asset_master
            .addAll(x.map((e) => ModelMisAssetHistory.fromJson(e)));
        //list_asset_temp.addAll(list_asset_master);
        // List<_item> list = [];
        List<_item> mglist = [];
        List<_item> glist = [];
        for (var e in list_asset_master) {
          //list.add(_item(id: e.iTEMID, name: e.iTEMNAME));
          mglist.add(_item(id: e.major_group_id, name: e.mAJORGROUP));
          glist.add(
              _item(id: e.group_id, name: e.gROUPNAME, code: e.major_group_id));
        }
        list_mgroup.addAll(mglist.toSet());
        list_group.addAll(glist.toSet());

        // list_item_master.addAll(list.toSet());
        // list_item_temp.addAll(list_item_master);
        //print(list_item.length);
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      isError.value = true;
      errorMessage.value = e.toString();
    }
    super.onInit();
  }

  void setGroup(String s) {
    list_asset_temp.clear();
    loader = CustomBusyLoader(context: context);
    loader.show();
    selectedGroupID.value = s;
    list_asset_temp
      ..clear()
      ..addAll(list_asset_master.where((e) => e.group_id == s));
    list_asset_temp_master
      ..clear()
      ..addAll(list_asset_temp);
    loader.close();
  }


Future<List<TableRow>> generateTableRows(List<ModelMisAssetHistory> dataList) async {
  //return compute(_buildRows, dataList);
  return dataList
      .map((f) => TableRow(
            decoration: const BoxDecoration(color: Colors.white),
            children: [
              CustomTableCellx(text: f.gRNNO ?? '', isSelectable: true),
              CustomTableCellx(text: f.gRNDATE ?? ''),
              CustomTableCellx(text: f.cHALANNO ?? ''),
              CustomTableCellx(text: f.cHALANDATE ?? ''),
              CustomTableCellx(text: f.bATCHNO ?? ''),
              CustomTableCellx(text: f.iTEMID ?? ''),
              CustomTableCellx(text: f.iTEMNAME ?? ''),
              CustomTableCellx(text: f.sUPPLIERNAME ?? ''),
            ],
          ))
      .toList();
}
  void search() {
    list_asset_temp
      ..clear()
      ..addAll(list_asset_temp_master.where((e) =>
          e.iTEMNAME!.toUpperCase().contains(txt_search.text.toUpperCase()) ||
          (e.cHALANNO ?? '')
              .toUpperCase()
              .contains(txt_search.text.toUpperCase()) ||
          (e.gRNNO ?? '')
              .toUpperCase()
              .contains(txt_search.text.toUpperCase()) ||
          (e.iTEMID ?? '')
              .toUpperCase()
              .contains(txt_search.text.toUpperCase()) ||
          (e.bATCHNO ?? '')
              .toUpperCase()
              .contains(txt_search.text.toUpperCase()) ||
          (e.cOMPANYNAME ?? '')
              .toUpperCase()
              .contains(txt_search.text.toUpperCase()) ||
          (e.cHALANDATE ?? '')
              .toUpperCase()
              .contains(txt_search.text.toUpperCase()) ||
          (e.sUPPLIERNAME ?? '')
              .toUpperCase()
              .contains(txt_search.text.toUpperCase())));
  }

  print_table() {
    var list = list_asset_temp.first;
    loader = CustomBusyLoader(context: context);
    CustomPDFGenerator(
      font: font.value,
      header: [
        pwTextOne(font.value, 'Item Group : ', list.gROUPNAME ?? '', 12),
        pwHeight(4),
      ],
      footer: [
        pwTextOne(font.value, 'Printed by :', user.value.eMPNAME ?? '', 9,
            pwMainAxisAlignmentStart)
      ],
      body: [
        pwGenerateTable([
          15,
          15,
          15,
          15,
          20,
          15,
          50,
          50
        ], [
          pwTableColumnHeader('GRN. No', font.value),
          pwTableColumnHeader('GRN. Date', font.value),
          pwTableColumnHeader('Chalan. No', font.value),
          pwTableColumnHeader('Chalan. Date', font.value),
          pwTableColumnHeader('Batch No', font.value),
          pwTableColumnHeader('Item Code', font.value),
          pwTableColumnHeader('Item Name', font.value),
          pwTableColumnHeader('Supplier', font.value),
        ], [
          ...list_asset_temp.map((f) => pwTableRow([
                pwTableCell(f.gRNNO ?? '', font.value),
                pwTableCell(f.gRNDATE ?? '', font.value),
                pwTableCell(f.cHALANNO ?? '', font.value),
                pwTableCell(f.cHALANDATE ?? '', font.value),
                pwTableCell(f.bATCHNO ?? '', font.value),
                pwTableCell(f.iTEMID ?? '', font.value),
                pwTableCell(f.iTEMNAME ?? '', font.value),
                pwTableCell(f.sUPPLIERNAME ?? '', font.value),
              ]))
        ])
      ],
      fun: () {
        loader.close();
      },
    ).ShowReport();
  }
}

class _item extends Equatable {
  String? id;
  String? name;
  String? code;
  _item({this.id, this.name, this.code});

  @override
  List<Object?> get props => [id, name, code];
}
