import '../../../../core/config/const.dart';
import '../controller/lab_patient_lab_history_controller.dart';

class PatientLabHistory extends StatelessWidget {
  const PatientLabHistory({super.key});
  void disposeController() {
    try {
      Get.delete<PatientLabHistoryController>();
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    final PatientLabHistoryController controller = Get.put(PatientLabHistoryController());
    controller.context = context;
    return Obx(()=>CommonBody3(controller, [],'Patient History'));
  }
}
