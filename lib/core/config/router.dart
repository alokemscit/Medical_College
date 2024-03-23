
import 'package:agmc/core/config/const.dart';
import 'package:agmc/moduls/finance/cost_center_linkage_page/cost_center_linkage.dart';
import 'package:agmc/moduls/finance/cost_center_page/cost_center_page.dart';
import 'package:agmc/moduls/finance/sub_ledger_linkage_page/sub_ledger_linkage_page.dart';
 
import 'package:agmc/moduls/finance/sub_ledger_master/sub_ledger_master_page.dart';
import 'package:agmc/moduls/finance/voucher_entry_page/voucher_entry_page.dart';

import '../../moduls/finance/ledger_master_page/ledger_master_page.dart';

Widget getPage( String id) {
  switch (id) {
    case "212":
      {
        return  const LedgerMasterPage();
      }
    case "208":
      {
        return  const LedgerMasterPage();
      }
    case "206":
      {
        return  const SubLedgerMaster();
      }
      case "207":
      {
        return  const ConstcenterPage();
      }
      case "209":
      {
        return  const SubLeaderLinkageMaster();
      }
        case "211":
      {
        return  const VoucherEntryPage();
      }
      case "1289":
      {
        return  const CostCeneterLinkagePage();
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