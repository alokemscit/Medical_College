
import '../../../../core/config/const.dart';
import '../controller/lab_biofire_test_result_entry_controller.dart';

class BiofireResultEntry extends StatelessWidget {
  const BiofireResultEntry({super.key});
  void disposeController() {
    try {
      Get.delete<BiofireResultEntryController>();
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    final BiofireResultEntryController controller = Get.put(BiofireResultEntryController());
    controller.context = context;
    return Obx(()=>CommonBody3(controller, [],'Biofire Test Resul'));
  }
}