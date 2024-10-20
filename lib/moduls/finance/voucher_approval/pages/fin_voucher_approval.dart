import 'package:agmc/widget/custom_datepicker.dart';

import '../../../../core/config/const.dart';
import '../controller/fin_voucher_approval_controller.dart';

class FinVoucherApproval extends StatelessWidget {
  const FinVoucherApproval({super.key});
  void disposeController() {
    try {
      Get.delete<FinVoucherApprovalController>();
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    final FinVoucherApprovalController controller =
        Get.put(FinVoucherApprovalController());
    controller.context = context;
    return Obx(() => CommonBody3(
        controller,
        [
          _customMenu(),
          _topPanel(controller),
        ],
        'Voucher Approval::',Colors.transparent,const EdgeInsets.only(top: 0,left: 8,right: 8,bottom: 1)));
  }
}

_customMenu() => Row(
  mainAxisAlignment: MainAxisAlignment.start,
  children: [
    Expanded(
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(4),
        color: appGray100,
        boxShadow: [
          BoxShadow(
            blurRadius: 2,
            spreadRadius: .01,
            color: appColorGrayDark.withOpacity(0.5)
          )
        ]
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Tooltip(
            message: 'New',
            child: Container(
               padding: const EdgeInsets.all(4),
             decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
              child: const Icon(Icons.file_copy_outlined,size: 18,color: appColorGrayDark,)),
          ),
        )),
    )
  ],
);

Widget _topPanel(FinVoucherApprovalController controller) => Row(
      children: [
        Flexible(
          child: SizedBox(
            width: 450,
            child: CustomGroupBox(
                groupHeaderText: 'Voucher Filter',
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomDropDown(
                          id: controller.selectedvoucherType.value,
                          width: 300,
                          list: controller.list_vtype
                              .map((f) => DropdownMenuItem<String>(
                                  value: f.iD,
                                  child: Text(
                                    f.nAME!,
                                    style: customTextStyle.copyWith(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w500),
                                  )))
                              .toList(),
                          onTap: (v) {}),
                      12.heightBox,
                      Row(
                        children: [
                          CustomDatePickerDropDown(
                              width: 145,
                              date_controller: controller.txt_fdate,
                              label: 'From Date',
                              isBackDate: true,
                              isShowCurrentDate: true),
                          11.widthBox,
                          CustomDatePickerDropDown(
                              width: 145,
                              date_controller: controller.txt_tdate,
                              label: 'To Date',
                              isBackDate: true,
                              isShowCurrentDate: true),
                          8.widthBox,
                          CustomButton(Icons.search, 'Show', () {},
                              appColorLogoDeep, appColorLogoDeep, kBgColorG)
                        ],
                      )
                    ],
                  ),
                )),
          ),
        ),
      ],
    );
