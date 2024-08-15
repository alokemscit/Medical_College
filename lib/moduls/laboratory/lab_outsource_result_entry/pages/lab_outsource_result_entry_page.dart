import 'package:agmc/moduls/laboratory/share_widget/lab_share_widget.dart';

import '../../../../core/config/const.dart';

import '../controller/lab_outsource_result_entry_controller.dart';

class OutSourceResultEntry extends StatelessWidget {
  const OutSourceResultEntry({
    super.key,
  });
  void disposeController() {
    try {
      Get.delete<OutSourceResultEntryController>();
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    final OutSourceResultEntryController controller =
        Get.put(OutSourceResultEntryController());
    controller.context = context;

    return Obx(() => CommonBody3(
        controller,
        [
          _mainwidget(controller),
        ],
        'Outsourcing Result Entry::'));
  }
}

Widget _mainwidget(OutSourceResultEntryController controller) => Expanded(
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

Widget _rightPanel(OutSourceResultEntryController controller) =>
    controller.selected_mrr.value.mrId == null
        ? const SizedBox()
        : Expanded(
            flex: 6,
            child: lab_widget().lab_rightPanel(controller, 'Save Entry'));

Widget _leftPanel(OutSourceResultEntryController controller) =>
     lab_widget().lab_leftPanel(
        controller,
        controller.context.width,
        lab_widget().lab_treeview(
            controller.context,
            controller.list_mrr_master_temp,
            controller.list_test_data_temp,
            controller.selected_mrr.value, controller));
