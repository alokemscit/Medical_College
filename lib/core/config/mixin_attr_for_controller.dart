import 'package:agmc/core/config/const.dart';
 

import 'package:agmc/model/model_status.dart';

import '../../moduls/admin/pagges/login_page/model/user_model.dart';
 import 'package:pdf/widgets.dart' as pw;

mixin MixInController {
  late BuildContext context;
  late data_api api = data_api();
  late CustomAwesomeDialog dialog = CustomAwesomeDialog(context: context);
  late CustomBusyLoader loader = CustomBusyLoader(context: context);
  var user =  User_Model().obs;

  var isLoading = false.obs;
  var isError = false.obs;
  var errorMessage = "".obs;
  var statusList = <ModelStatus>[].obs;
  var image = Rxn<pw.MemoryImage>();

  var font = Rxn<pw.Font>();
   var list_tool=<CustomTool>[].obs;

}

mixin MixinMethod {
  void disposeController();
}
