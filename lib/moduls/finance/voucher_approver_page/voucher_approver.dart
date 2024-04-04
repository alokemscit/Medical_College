import 'package:agmc/core/config/const_widget.dart';
import 'package:agmc/moduls/finance/voucher_approver_page/controller/voucher_approver_controller.dart';
 
import '../../../core/config/const.dart';

class VoucherApprover extends StatelessWidget {
  const VoucherApprover({super.key});
  void disposeController() {
    try {
      Get.delete<VoucherApproverController>();
    } catch (e) {
      //
    }
  }

  @override
  Widget build(BuildContext context) {
    VoucherApproverController controller = Get.put(VoucherApproverController());
    controller.context = context;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Obx(() => CustomCommonBody(
            controller.isLoading.value,
            controller.isError.value,
            controller.errorMessage.value,
            _mainWidget(controller),
            _mainWidget(controller),
            _mainWidget(controller))),
      ),
    );
  }
}

_mainWidget(VoucherApproverController controller) => CustomAccordionContainer(
        isExpansion: false,
        height: 0,
        headerName: "Voucher Approver",
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  Row(
                    children: [
                      controller.context.width <=650
                          ? Expanded(child: _entryPart(controller))
                          : _entryPart(controller),
                    ],
                  ),
                  8.heightBox,
                  Expanded(
                      child: SingleChildScrollView(
                    child: Table(
                      border: CustomTableBorder(),
                      columnWidths: CustomColumnWidthGenarator(_col),
                      children: [
                        TableRow(
                            decoration: CustomTableHeaderRowDecorationnew,
                            children: [
                              CustomTableCell2("Checked By"),
                              CustomTableCell2("AGM. By"),
                              CustomTableCell2("Sr. GM. By"),
                              CustomTableCell2("H.O. By"),
                              CustomTableCell2("")
                            ]),
                      ],
                    ),
                  ))
                ],
              ),
            ),
          )
        ]);

List<int> _col = [120, 120, 120, 120, 30];

_buttonPart(VoucherApproverController controller) => Row(
      children: [
        // 8.widthBox,
        RoundedButton(() {
          controller.undo();
        }, Icons.undo,16),
        12.widthBox,
        RoundedButton(() {

        }, Icons.save,16),
      ],
    );

_entryPart(VoucherApproverController controller) => Container(
      decoration: customBoxDecoration.copyWith(
          borderRadius: BorderRadiusDirectional.circular(4)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          children: [
            _controllPart(controller),
            controller.context.width > 650
                ? const SizedBox()
                : Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: _buttonPart(controller),
                  )
          ],
        ),
      ),
    );
_controllPart(VoucherApproverController controller) => Row(
      children: [
        CustomTextBox(
            caption: "Chk By",
            maxlength: 4,
            controller: TextEditingController(),
            textInputType: TextInputType.number,
            onChange: (v) {}),
        8.widthBox,
        CustomTextBox(
          maxlength: 4,
            caption: "AGM",
            controller: TextEditingController(),
            textInputType: TextInputType.number,
            onChange: (v) {}),
        8.widthBox,
        CustomTextBox(
          maxlength: 4,
            caption: "GM",
            controller: TextEditingController(),
            textInputType: TextInputType.number,
            onChange: (v) {}),
        8.widthBox,
        CustomTextBox(
          maxlength: 4,
            caption: "HO",
            controller: TextEditingController(),
            textInputType: TextInputType.number,
            onChange: (v) {}),
        controller.context.width > 650
            ? Padding(
                padding: const EdgeInsets.only(left: 8),
                child: _buttonPart(controller),
              )
            : const SizedBox()
      ],
    );
