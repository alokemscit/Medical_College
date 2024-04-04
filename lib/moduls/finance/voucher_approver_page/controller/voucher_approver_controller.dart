import 'package:agmc/core/config/const.dart';

class VoucherApproverController extends GetxController with MixInController {
  final TextEditingController txt_checkBy = TextEditingController();
  final TextEditingController txt_agmBy = TextEditingController();
  final TextEditingController txt_gmBy = TextEditingController();
  final TextEditingController txt_hoBy = TextEditingController();
  var editId = ''.obs;

  void undo() {
    editId.value = '';
    txt_checkBy.text = '';
    txt_agmBy.text = '';
    txt_gmBy.text = '';
    txt_hoBy.text = '';
  }
}
