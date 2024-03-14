
import 'package:agmc/core/config/const.dart';

import '../../moduls/finance/ledger_master_page/ledger_master_page.dart';

Widget getPage( String id) {
  switch (id) {
    case "208":
      {
        return  const LedgerMasterPage();
      }
   
      
      case "":
      return const SizedBox(
        //child: Text("Under Construction!"),
      );
    default:
      return const Center(
        child: Text("Under Construction!",style: TextStyle(fontSize: 30,color: Colors.blue),),
      );
  }
}