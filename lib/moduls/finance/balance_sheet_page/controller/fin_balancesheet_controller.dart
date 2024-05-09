import 'package:agmc/core/config/const.dart';
import 'package:agmc/core/config/const_widget.dart';
import 'package:agmc/core/shared/custom_list.dart';
import 'package:agmc/model/model_common.dart';
import 'package:intl/intl.dart';

class BalanceSheetController extends BaseController {
  var comparisonType = 1.obs;
  var list_month = <ModelCommon>[].obs;
  var list_year = <ModelCommon>[].obs;

  final TextEditingController txt_fdate = TextEditingController();
  final TextEditingController txt_tdate = TextEditingController();

  var displayPreviuos = ''.obs;
  var displayCurrent = ''.obs;

  var monthID = ''.obs;
  var yearID = ''.obs;

  void show() async {
    displayCurrent.value = '';
    displayPreviuos.value = '';
    dialog = CustomAwesomeDialog(context: context);
    loader = CustomBusyLoader(context: context);
    if (comparisonType.value == 1) {
      if (txt_fdate.text.isEmpty) {
        dialog
          ..dialogType = DialogType.warning
          ..message = 'Please select from date'
          ..show();
        return;
      }
      if (txt_tdate.text.isEmpty) {
        dialog
          ..dialogType = DialogType.warning
          ..message = 'Please select To date'
          ..show();
        return;
      }
      if (!isValidDateRange(txt_fdate.text, txt_tdate.text)) {
        dialog
          ..dialogType = DialogType.warning
          ..message = 'Invalid Date range'
          ..show();
        return;
      }
      DateFormat format = DateFormat('dd/MM/yyyy');

      // Parse the string into a DateTime object
      DateTime fromDate = format.parse(txt_fdate.text);
      DateTime toDate = format.parse(txt_tdate.text);
      displayCurrent.value = 'From : ${txt_fdate.text} To : ${txt_tdate.text}';
      displayPreviuos.value='From : ${ DateFormat('dd/MM/yyyy').format(DateTime(fromDate.year - 1, fromDate.month, fromDate.day))} To : ${ DateFormat('dd/MM/yyyy').format(DateTime(toDate.year - 1, toDate.month, toDate.day))}';
    }
  }

  @override
  void onInit() async {
    await super.init();
    list_month.addAll(await get_month_List());
    list_year.addAll(await get_year_List());

    //print(list_year.length);
    super.onInit();
    //print(user.value.uNAME);

    // print(isError.value);
    // print(isLoading.value);
    // print(errorMessage.value);
  }

  @override
  void onClose() {
    // Dispose of the controller when it is no longer needed
    // Get.delete<BaseController>();
    Get.delete<BalanceSheetController>();
    super.onClose();
  }
}
