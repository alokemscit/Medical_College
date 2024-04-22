 
import 'package:agmc/core/config/const.dart';
 
import 'package:agmc/model/model_status.dart';
import 'package:agmc/moduls/admin/pagges/login_page/model/user_model.dart';
import 'package:agmc/widget/custom_awesome_dialog.dart';
import 'package:agmc/widget/custom_bysy_loader.dart';
 
 
mixin MixInController{
   late BuildContext context;
   late data_api api;
   late CustomAwesomeDialog dialog;
  late CustomBusyLoader loader;
  var user = User_Model().obs;
  var isLoading = false.obs;
  var isError = false.obs;
  var errorMessage = "".obs;
  var statusList = <ModelStatus>[].obs;
}