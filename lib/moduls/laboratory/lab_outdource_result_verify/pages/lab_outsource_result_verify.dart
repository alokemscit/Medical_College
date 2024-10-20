import 'package:agmc/moduls/laboratory/share_widget/lab_share_widget.dart';

import '../../../../core/config/const.dart';
import '../controller/lab_outsource_result_verify_controller.dart';

 

class OutSourceResultVerify extends StatelessWidget {
  const OutSourceResultVerify({
    super.key,
  });
  void disposeController() {
    try {
      Get.delete<OutSourceResultVerifyController>();
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    final OutSourceResultVerifyController controller =
        Get.put(OutSourceResultVerifyController());
    controller.context = context;

    return Obx(() => CommonBody3(
        controller,
        [
          _mainwidget(controller),
        ],
        'Outsourcing Result Verify::'));
  }
}

Widget _mainwidget(OutSourceResultVerifyController controller) => Expanded(
      child: controller.context.width > 1350
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _leftPanel(controller),
                4.widthBox,
                _rightPanel(controller),
              ],
            )
          : Column(
              children: [
                !controller.isShowLeftPanel.value
                    ? const SizedBox()
                    : Expanded(flex: 4, child: _leftPanel(controller)),
                _rightPanel(controller)
              ],
            ),
    );

Widget _rightPanel(OutSourceResultVerifyController controller) =>
    controller.selected_mrr.value.mrId == null
        ? const SizedBox()
        : Expanded(
            flex: 6,
            child: lab_widget().lab_rightPanel(controller, 'Save Verify'));

Widget _leftPanel(OutSourceResultVerifyController controller) =>
     lab_widget().lab_leftPanel(
        controller,
        controller.context.width,
        lab_widget().lab_treeview(
            controller.context,
            controller.list_mrr_master_temp,
            controller.list_test_data_temp,
            controller.selected_mrr.value, controller));
