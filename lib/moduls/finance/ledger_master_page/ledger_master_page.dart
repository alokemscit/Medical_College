
import '../../../core/config/const.dart';
import 'controller/ledger_master_controller.dart';
import 'model/model_ledger_master.dart';

class LedgerMasterPage extends StatelessWidget {
  const LedgerMasterPage({super.key});
  void disposeController() {
    try {
      Get.delete<LedgerMasterController>();
    } catch (e) {
      // print('Error disposing EmployeeController: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    LedgerMasterController controller = Get.put(LedgerMasterController());
    controller.context = context;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Obx(() => CustomCommonBody(
            controller.isLoading.value,
            controller.isError.value,
            controller.errorMessage.value,
            _desktop(controller),
            _desktop(controller),
            _desktop(controller))),
      ),
    );
  }
}

_desktop(LedgerMasterController controller) {
  bool b = false;
  return Stack(
    children: [
      CustomAccordionContainer(
          headerName: "Chart of Account",
          height: 0,
          isExpansion: false,
          children: [
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.start,
            //   children: [
            //     CustomButton(Icons.import_export, "Excel Ecport", () {
            //       controller.exportData();
            //     }, Colors.white),
            //   ],
            // ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: controller.ledger_list
                      .where((p0) => p0.pARENTID == '0')
                      .map((e) => _chartAccount(controller, e))
                      .toList(),
                ),
              ),
            ),
            //     FloatingActionButton(
            //       tooltip:"Export Excel",
            //   onPressed: () {
            //     // Add your onPressed logic here
            //   },
            //   backgroundColor: Colors.blue,
            //   child: const Icon(Icons.add),
            // ),
          ]),
      Positioned(
        top: 3.0, // Adjust this value for vertical position
        left: 86.0, // Adjust this value for horizontal position
        child: Center(
          child: Tooltip(
            message: 'Export Excel File',
            child: MaterialButton(
              height: 30,
              onPressed: () {
                if (!b) {
                  b = true;
                  controller.exportExcelFile();
                  Future.delayed(const Duration(seconds: 2),(() => b=false));
                } 
              },
              // color: appColorGrayLight,
              shape: const CircleBorder(),
              child: const Icon(Icons.file_download_sharp,
                  size: 18, color: Colors.white),
            ),
          ),
        ),
      ),
    ],
  );
}

Widget _chartAccount(LedgerMasterController controller, ModelLedgerMaster e) =>
    Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: _node(
          0,
          Row(
            children: [
              Text(
                '${e.cODE!} - ${e.nAME!}',
                style: customTextStyle.copyWith(
                    fontSize: 20, fontWeight: FontWeight.bold),
              ),
              10.widthBox,
              Text('(Chart of Acc)', style: _style())
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 27.0),
            child: PoppupMenu(menuList: [
              PopupMenuItem(
                child: const ListTile(
                  title: Text("Add Group"),
                  trailing: Icon(Icons.add_rounded),
                ),
                onTap: () {
                  controller.groupPopup(e, false);
                },
              ),
              //PopupMenuItem(child: ListTile(title: Text("Edit Group"), leading: Icon(Icons.add),)),
            ], child: const Icon(Icons.construction_sharp)),
          ),
          controller.ledger_list
              .where((p0) => p0.pARENTID == e.iD)
              .map((e) => _groupPart(controller, e))
              .toList()),
    );

Widget _subGroupPart(LedgerMasterController controller, ModelLedgerMaster e) =>
    Padding(
      padding: const EdgeInsets.only(bottom: 0),
      child: _node(
          26,
          Row(
            children: [
              Text('${e.cODE!} - ${e.nAME!}',
                  style: customTextStyle.copyWith(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      fontFamily: appFontMuli
                      //color: appColorLogo,
                      )),
              10.widthBox,
              Text('(Sub Group)', style: _style())
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: PoppupMenu(
                menuList: [
                  PopupMenuItem(
                      child: const ListTile(
                        title: Text("Add Ledger Category"),
                        trailing: Icon(Icons.add_rounded),
                      ),
                      onTap: () => controller.ledgerCategoryPopup(e, false)),
                  PopupMenuItem(
                      child: const ListTile(
                        title: Text("Edit Sub Group"),
                        trailing: Icon(Icons.edit_rounded),
                      ),
                      onTap: () => controller.subGroupPopup(e, true)),
                ],
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.construction_sharp,
                    size: 22,
                    color: appColorBlue,
                  ),
                )),
          ),
          controller.ledger_list
              .where((p0) => p0.pARENTID == e.iD)
              .map(
                (e) => _ledgerCategoryPart(controller, e),
              )
              .toList()),
    );

Widget _ledgerCategoryPart(
        LedgerMasterController controller, ModelLedgerMaster e) =>
    Padding(
      padding: const EdgeInsets.only(bottom: 0),
      child: _node(
          26,
          Row(
            children: [
              Text('${e.cODE!} - ${e.nAME!}',
                  style: customTextStyle.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    fontFamily: appFontMuli,
                    // color: kTextColor,
                  )),
              10.widthBox,
              Text('(Ledger Category)', style: _style())
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: PoppupMenu(
                menuList: [
                  PopupMenuItem(
                      child: const ListTile(
                        title: Text("Add Ledger"),
                        trailing: Icon(Icons.add_rounded),
                      ),
                      onTap: () => controller.ledgerPopup(e, false)),
                  PopupMenuItem(
                      child: const ListTile(
                        title: Text("Edit Ledger Category"),
                        trailing: Icon(Icons.edit_rounded),
                      ),
                      onTap: () => controller.ledgerCategoryPopup(e, true)),
                ],
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.construction_sharp,
                    size: 22,
                    color: kTextColor,
                  ),
                )),
          ),
          controller.ledger_list
              .where((p0) => p0.pARENTID == e.iD)
              .map(
                (e) => _ledgerPart(controller, e),
              )
              .toList()),
    );

Widget _groupPart(LedgerMasterController controller, ModelLedgerMaster e) =>
    Padding(
      padding: const EdgeInsets.only(bottom: 0),
      child: _node(
          26,
          Row(
            children: [
              Text('${e.cODE!} - ${e.nAME!}',
                  style: customTextStyle.copyWith(
                    fontSize: 15.5,
                    fontFamily: appFontMuli,
                    fontWeight: FontWeight.bold,
                    // color: appColorLogoDeep,
                  )),
              10.widthBox,
              Text(
                '(Group)',
                style: _style(),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: PoppupMenu(
                menuList: [
                  PopupMenuItem(
                      child: const ListTile(
                        title: Text("Add Sub Group"),
                        trailing: Icon(Icons.add_rounded),
                      ),
                      onTap: () => controller.subGroupPopup(e, false)),
                  PopupMenuItem(
                      child: const ListTile(
                        title: Text("Edit Group"),
                        trailing: Icon(Icons.edit_rounded),
                      ),
                      onTap: () {
                        controller.groupPopup(e, true);
                      }),
                ],
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.construction_sharp,
                    size: 22,
                    color: appColorLogo,
                  ),
                )),
          ),
          controller.ledger_list
              .where((p0) => p0.pARENTID == e.iD)
              .map(
                (e) => _subGroupPart(controller, e),
              )
              .toList()),
    );

_style() => customTextStyle.copyWith(
    fontSize: 10,
    fontWeight: FontWeight.normal,
    color: Colors.black,
    fontStyle: FontStyle.italic);

Widget _ledgerPart(LedgerMasterController controller, ModelLedgerMaster e) =>
    Padding(
      padding: const EdgeInsets.only(
        left: 36,
      ),
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.arrow_right),
                  4.widthBox,
                  Text(
                    '${e.cODE!} - ${e.nAME!}',
                    style: customTextStyle.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: appColorLogoDeep),
                  ),
                ],
              ),
              8.widthBox,
              Expanded(
                  child: Container(
                height: 0.5,
                color: appColorBlue.withOpacity(0.3),
              )),
              8.widthBox,
              Padding(
                padding: const EdgeInsets.only(
                    left: 8, top: 8, bottom: 8, right: 35),
                child: PoppupMenu(
                    menuList: [
                      PopupMenuItem(
                          child: const ListTile(
                            title: Text("Edit Ledger"),
                            trailing: Icon(Icons.edit_rounded),
                          ),
                          onTap: () => controller.ledgerPopup(e, true)),
                    ],
                    child: const Icon(
                      Icons.construction_sharp,
                      size: 18,
                      color: appColorPrimary,
                    )),
              )
            ],
          ),
        ),
      ),
    );

Widget _node(@required double leftPad, @required Widget name,
        @required Widget event, @required List<Widget> children) =>
    Padding(
      padding: EdgeInsets.only(left: leftPad),
      child: CustomPanel(
        isSelectedColor: false,
        isSurfixIcon: false,
        isLeadingIcon: true,
        isExpanded: false,
        title: Expanded(
          child: Row(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [name, 15.widthBox, event],
          ),
        ),

        /// Ledger-------
        children: children,
      ),
    );
