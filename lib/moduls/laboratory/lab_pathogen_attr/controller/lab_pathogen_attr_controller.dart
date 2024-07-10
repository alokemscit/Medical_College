// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:agmc/core/config/const.dart';

class PathogenAttrController extends GetxController with MixInController {
  var selectedGroupID = '1'.obs;
  var list_attr_temp = <_tmpAttr>[].obs;
  final TextEditingController txt_attr_name = TextEditingController();
  void delete_attr_temp(_tmpAttr e) {
    list_attr_temp.removeWhere((f) => f.name == e.name);
  }

  void add_Attr_temp() {
    dialog = CustomAwesomeDialog(context: context);
    if (txt_attr_name.text.isEmpty) {
      dialog
        ..dialogType = DialogType.warning
        ..message = 'Name Required!'
        ..show();
      return;
    }
    if (list_attr_temp
        .where((f) => f.name!.toUpperCase() == txt_attr_name.text.toUpperCase())
        .isNotEmpty) {
      dialog
        ..dialogType = DialogType.warning
        ..message = '${txt_attr_name.text} Name already exists!'
        ..show();
      return;
    }
    list_attr_temp
        .add(_tmpAttr(name: txt_attr_name.text, gid: selectedGroupID.value));
    txt_attr_name.text = '';
  }
}

class _tmpAttr {
  String? gid;
  String? name;
  _tmpAttr({
    this.gid,
    this.name,
  });
}
