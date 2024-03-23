 
 
 

import '../../../core/config/const.dart'; 
import '../../../core/config/const_widget.dart';
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

_desktop(LedgerMasterController controller) => CustomAccordionContainer(
      headerName: "Chart of Account",
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
          Row(
            children: [
              Text(
               '${e.cODE!} - ${e.nAME!}',
                style: customTextStyle.copyWith(
                    fontSize: 22, fontWeight: FontWeight.bold),
              ),
              10.widthBox,
               Text('(Chart of Acc)',
               style: _style())
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
               Text('(Sub Group)',
               style: _style())
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
                   onTap: ( )=> controller.ledgerPopup(e)
                  ),
                  const PopupMenuItem(
                      child: ListTile(
                    title: Text("Edit Sub Group"),
                    trailing: Icon(Icons.edit_rounded),
                  )),
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
                (e) => _ledgerPart(e),
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
                    fontSize: 16,
                    fontFamily: appFontMuli,
                    fontWeight: FontWeight.bold,
                   // color: appColorLogoDeep,
                  )),
                   10.widthBox,
               Text('(Group)',
               style: _style(),)
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
                   onTap: ( )=> controller.subGroupPopup(e)
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
                (e) => _subGroupPart(controller,e),
              )
              .toList()),
    );


_style()=>customTextStyle.copyWith(fontSize: 10,
               fontWeight: FontWeight.normal,color: Colors.black,fontStyle: FontStyle.italic);

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
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: appColorLogoDeep),
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
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [name, 15.widthBox, event],
              ),
            ),
          
            /// Ledger-------
            children: children,
          ),
        );
