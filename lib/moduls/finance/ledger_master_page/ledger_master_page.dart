import 'package:agmc/widget/custom_accordion.dart';
import 'package:agmc/widget/custom_body.dart';
import 'package:agmc/widget/custom_panel.dart';
import 'package:agmc/widget/custom_textbox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';

import '../../../core/config/const.dart';
import '../../../widget/custom_dialog.dart';
import '../../../widget/custom_widget_list.dart';
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
            Container(),
            _desktop(controller),
            _desktop(controller))),
      ),
    );
  }
}

_desktop(LedgerMasterController controller) => CustomAccordionContainer(
      headerName: "Legder Master",
      height: 0,
      isExpansion: false,
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:controller.ledger_list
              .where((p0) => p0.pARENTID == '0')
              .map((e) => _chartAccount(controller, e))
              .toList(),
            ),
          ),
        )
      ]
    );

Widget _chartAccount(LedgerMasterController controller, ModelLedgerMaster e) =>
    Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: _node(
          0,
          Text(
           '${e.cODE!} - ${e.nAME!}',
            style: customTextStyle.copyWith(
                fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 27.0),
            child: PoppupMenu(menuList: [
              PopupMenuItem(
                child: const ListTile(
                  title: Text("Add Group"),
                  trailing: Icon(Icons.add_rounded),
                ),
                onTap: ()  {
                   controller.groupPopup(e);
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

Widget _groupPart(LedgerMasterController controller, ModelLedgerMaster e) =>
    Padding(
      padding: const EdgeInsets.only(bottom: 0),
      child: _node(
          26,
          Text('${e.cODE!} - ${e.nAME!}',
              style: customTextStyle.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: appColorLogo,
              )),
           Padding(
            padding: const EdgeInsets.only(right: 20),
            child: PoppupMenu(
                menuList: [
                  PopupMenuItem(
                      child: const ListTile(
                    title: Text("Add Ledger"),
                    trailing: Icon(Icons.add_rounded),
                  ),
                   onTap: ( )=> controller.ledgerPopup(e)
                  ),
                  const PopupMenuItem(
                      child: ListTile(
                    title: Text("Edit Group"),
                    trailing: Icon(Icons.edit_rounded),
                  )),
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
                (e) => _ledgerPart(e),
              )
              .toList()),
    );

Widget _ledgerPart(ModelLedgerMaster e) => Padding(
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
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: appColorPrimary),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(left: 8, top: 8, bottom: 8, right: 35),
                child: PoppupMenu(
                    menuList: [
                      PopupMenuItem(
                          child: ListTile(
                        title: Text("Edit Ledger"),
                        trailing: Icon(Icons.edit_rounded),
                      )),
                    ],
                    child: Icon(
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [name, event],
            ),
          ),

          /// Ledger-------
          children: children,
        ));
