import 'package:agmc/core/config/const.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import '../../../../core/shared/user_data.dart';
import '../../../../model/model_status.dart';
import '../../../../widget/custom_awesome_dialog.dart';
import '../../../../widget/custom_bysy_loader.dart';
import '../model/model_costcenter_master.dart';

class CostcenterController extends GetxController with MixInController {
  var list_costcenter_main = <ModelCostcenterMaster>[].obs;
  var list_costcenter_temp = <ModelCostcenterMaster>[].obs;

  var editId = ''.obs;
  final TextEditingController txt_code = TextEditingController();
  final TextEditingController txt_name = TextEditingController();
  final TextEditingController txt_desc = TextEditingController();
  final TextEditingController txt_search = TextEditingController();

  void search() {
    var x = list_costcenter_main
        .where((p0) =>
            p0.nAME!.toUpperCase().contains(txt_search.text.toUpperCase()) ||
            p0.cODE!.toUpperCase().contains(txt_search.text.toUpperCase()) ||
            p0.dESCRIPTION!
                .toUpperCase()
                .contains(txt_search.text.toUpperCase()))
        .toList();
    list_costcenter_temp.clear();
    list_costcenter_temp.addAll(x);
  }

  void edit(ModelCostcenterMaster e) {
     editId.value = e.iD!;
    txt_name.text = e.nAME!;
    txt_code.text = e.cODE!;
    txt_desc.text = e.dESCRIPTION == null ? '' : e.dESCRIPTION!;
  }

  void undo() {
     editId.value = '';
    txt_search.text = '';
    txt_name.text = '';
    txt_code.text = '';
    txt_desc.text = '';list_costcenter_temp.clear();
    list_costcenter_temp.addAll(list_costcenter_main);
  }

  void save() async{
    //p_cid in int, p_id in int, p_name in varchar2,p_desc in varchar2, p_code in varchar2, v_user in int
   dialog = CustomAwesomeDialog(context: context);
    loader = CustomBusyLoader(context: context);
    try {
      if (txt_name.text == '') {
        dialog
          ..dialogType = DialogType.warning
          ..message = "Please enter valid sub leadeger name!"
          ..show();
        return;
      }

      loader.show();

      var x = await api.createLead([
        {
          "tag": "75",
          "p_cid": user.value.comID,
          "p_id": editId.value == '' ? "0" : editId.value,
          "p_name": txt_name.text,
          "p_desc": txt_desc.text,
          "p_code": txt_code.text,
           "v_user": user.value.eMPID
        }
      ]);
      loader.close();
      // print(x);
      if (x == []) {
        dialog
          ..dialogType = DialogType.error
          ..message = 'Data save error'
          ..show();
        return;
      }

      ModelStatus s1 = await getStatusWithDialog(x, dialog);
      if (s1.status == '1') {
        dialog
          ..dialogType = DialogType.success
          ..message = s1.msg!
          ..show();
        list_costcenter_main.removeWhere((e) => e.iD == editId.value);
        list_costcenter_main.insert(
            0,
            ModelCostcenterMaster (
                iD: s1.id,
                nAME: txt_name.text,
                cODE: s1.extra,
                dESCRIPTION: txt_desc.text));
        list_costcenter_temp.clear();
        list_costcenter_temp.addAll(list_costcenter_main);
        editId.value = '';
        txt_search.text = '';
        txt_name.text = '';
        txt_code.text = '';
        txt_desc.text = '';
        
      }
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
    isLoading.value = true;
    isError.value = false;
    // await Future.delayed(Duration(seconds: 10));
    api = data_api();
    user.value = await getUserInfo();
    if (user == null) {
      isLoading.value = false;
      isError.value = true;
      errorMessage.value = "Re- Login required";
      return;
    }

    try {
      var x = await api.createLead([
        {"tag": "74", "p_cid": user.value.comID}
      ]);
      list_costcenter_main
          .addAll(x.map((e) => ModelCostcenterMaster.fromJson(e)));
      list_costcenter_temp.addAll(list_costcenter_main);
      isLoading.value = false;
      //print(x);
    } catch (e) {
      isLoading.value = true;
      errorMessage.value = e.toString();
      isError.value = true;
    }

    super.onInit();
  }
}
