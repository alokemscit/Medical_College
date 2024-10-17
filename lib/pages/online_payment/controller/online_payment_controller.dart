import 'package:asgar_ali_hospital/constant/const.dart';
import 'package:asgar_ali_hospital/custom_widget/custom_awesome_dialog.dart';
import 'package:asgar_ali_hospital/custom_widget/custom_bysy_loader.dart';
import 'package:asgar_ali_hospital/data/data_api.dart';
import 'package:get/get.dart';

class OnlinePaymentController extends GetxController{
  late BuildContext context;
  late data_api api;
  late CustomAwesomeDialog dialog;
  late CustomBusyLoader loader;
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var isIPD=false.obs;
  var isIPDfound=false.obs;
  var isCorrectHCN=false.obs;
final TextEditingController txt_hcn=TextEditingController(); 
final TextEditingController txt_regno=TextEditingController(); 
final TextEditingController txt_name=TextEditingController(); 
final TextEditingController txt_ward=TextEditingController(); 
final TextEditingController txt_address=TextEditingController(); 
final TextEditingController txt_mob=TextEditingController(); 

void resetField(){
  isIPDfound.value=false;
  isCorrectHCN.value=false;
  txt_hcn.text='';
  txt_regno.text='';
  txt_ward.text='';
  txt_address.text='';
  txt_mob.text='';
  txt_name.text='';
}




}