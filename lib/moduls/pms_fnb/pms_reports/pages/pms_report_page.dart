import '../../../../core/config/const.dart';
import '../controller/pms_report_controller.dart';

class PmsReportsPage extends StatelessWidget {
  const PmsReportsPage({super.key});
  void disposeController() {
    try {
      Get.delete<PmsReportsPageController>();
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    final PmsReportsPageController controller =
        Get.put(PmsReportsPageController())..context=context;
     
    return CommonBody2(controller,
     CustomTwoPanelWindow(
      leftPanelHeaderText: "Peport Type", rightPanelHeaderText: "Report Filter", 
      leftChildren: const [], rightChildren:const [], context: context,rightFlex: 0,));
  }
}
