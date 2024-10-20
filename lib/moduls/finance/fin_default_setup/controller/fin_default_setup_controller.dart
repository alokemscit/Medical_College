import 'package:agmc/core/config/const.dart';

import '../../../../core/shared/user_data.dart';
import '../../voucher_entry_page/model/model_voucher_type.dart';
import '../model/model_fiscal_year.dart';
import '../model/model_voucher_app_type.dart';
import '../model/model_voucher_approver.dart';

class FinDefaultSetupController extends GetxController with MixInController {
  var editFisID = ''.obs;
  var cmb_fisStatusID = ''.obs;

  var cmb_editApprorver = ''.obs;

  var cmb_editApprorverStatusID = ''.obs;

  var cmb_appTypeId = ''.obs;

  var vTypeEditId = ''.obs;

  final TextEditingController txt_voucherTypeName = TextEditingController();
  final TextEditingController txt_voucherTypeShortName =
      TextEditingController();

  final TextEditingController txt_fis_start_date = TextEditingController();
  final TextEditingController txt_fis_end_date = TextEditingController();

  final TextEditingController txt_appEmpId = TextEditingController();

  var listStatus = <_satus>[].obs;
  var list_vtype = <ModelVoucherType>[].obs;
  var list_fiscalYear = <ModelFiscalYearMaster>[].obs;
  var list_voucher_appType = <ModelVoucherAppTypeMaster>[].obs;
  var list_voucher_approver = <ModelVoucherApprover>[].obs;

  @override
  void onInit() async {
    super.onInit();
    api = data_api();

    isError.value = false;
    isLoading.value = true;

    user.value = await getUserInfo();

    listStatus.addAll(_statusList);

    try {
      var x = await api.createLead([
        {
          "tag": "80",
        }
      ]);
      //print(x);
      list_vtype.addAll(x.map((e) => ModelVoucherType.fromJson(e)));

      x = await api.createLead([
        {"tag": "85", "p_cid": user.value.comID}
      ]);
      list_fiscalYear.addAll(x.map((e) => ModelFiscalYearMaster.fromJson(e)));
      //  print(x);
      x = await api.createLead([
        {"tag": "86"}
      ]);
      list_voucher_appType
          .addAll(x.map((e) => ModelVoucherAppTypeMaster.fromJson(e)));


x = await api.createLead([
        {"tag": "84", "p_cid": user.value.comID}
      ]);
      list_voucher_approver.addAll(x.map((e) => ModelVoucherApprover.fromJson(e)));
  //print(x);


      isLoading.value = false;
    } catch (e) {
      isError.value = true;
      isLoading.value = false;
      errorMessage.value = e.toString();
    }
  }
}

class _satus {
  final String id;
  final String name;
  _satus({required this.id, required this.name});
}

List<_satus> _statusList = [
  _satus(id: '1', name: 'Active'),
  _satus(id: '0', name: 'InActive'),
];
