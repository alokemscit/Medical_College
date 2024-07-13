import 'package:agmc/core/config/const.dart';
import 'package:agmc/moduls/app_dashboard/app_doc_profile_setup/page/doc_profile_setup.dart';
import 'package:agmc/moduls/diet_management/diet_menu_config/pages/diet_menu_config.dart';
import 'package:agmc/moduls/finance/balance_sheet_page/fin_balancesheet_page.dart';
import 'package:agmc/moduls/finance/cost_center_linkage_page/cost_center_linkage.dart';
import 'package:agmc/moduls/finance/cost_center_page/cost_center_page.dart';
import 'package:agmc/moduls/finance/sub_ledger_linkage_page/sub_ledger_linkage_page.dart';

import 'package:agmc/moduls/finance/sub_ledger_master/sub_ledger_master_page.dart';
import 'package:agmc/moduls/finance/trail_balance_page/trail_balance.dart';

import 'package:agmc/moduls/finance/voucher_entry_page/voucher_entry_page.dart';
import 'package:agmc/moduls/pms_fnb/goods_formula_setup/pages/goods_formula_setup.dart';

import '../../moduls/app_dashboard/app_banner/page/app_banner_page.dart';
import '../../moduls/app_dashboard/app_department/page/app_department_page.dart';
import '../../moduls/app_dashboard/app_health_package_config/pages/app_health_packahe_config_page.dart';
import '../../moduls/app_dashboard/app_health_package_master/pages/app_health_package_master_page.dart';
import '../../moduls/app_dashboard/app_investigation_attr/pages/app_investigation_attribute_page.dart';
import '../../moduls/app_dashboard/app_top_doctor/pages/app_top_doctor_list.dart';
import '../../moduls/diet_management/diet_assign/pages/diet_assign_page.dart';
import '../../moduls/diet_management/diet_category/pages/diet_category_page.dart';
import '../../moduls/diet_management/diet_meal_ietm/pages/diet_item_page.dart';

import '../../moduls/diet_management/diet_mealplan/pages/weekly_meal_plan.dart';
import '../../moduls/finance/fin_dashboard/fin_datshboadr.dart';
import '../../moduls/finance/fin_default_setup/fin_default_setup_page.dart';
import '../../moduls/finance/gl_opening_page/gl_opening_balance.dart';
import '../../moduls/finance/ledger_master_page/ledger_master_page.dart';
import '../../moduls/laboratory/lab_biofire_panel/pages/lab_biofire_panel_page.dart';
import '../../moduls/laboratory/lab_biofire_test_result_entry/pages/lab_biofire_test_result_entry.dart';
import '../../moduls/laboratory/lab_pathogen_attr/pages/lab_pathogen_attr_page.dart';
import '../../moduls/laboratory/lab_pathogen_group/pages/lab_patogen_group_page.dart';
import '../../moduls/laboratory/lab_patient_history/pages/lab_patient_history_page.dart';
import '../../moduls/laboratory/lab_resistance_attr/pages/lab_resistence_attr_page.dart';
import '../../moduls/laboratory/lab_resistance_group/pages/lab_resistance_group_page.dart';
import '../../moduls/mc_fee_management/mc_account_enrollment/pages/mc_account_enroll_page.dart';
import '../../moduls/mc_fee_management/mc_default_setup/pages/mc_default_setup.dart';
import '../../moduls/mc_fee_management/mc_fee_collection/pages/mc_fee_collection.dart';
import '../../moduls/mc_fee_management/mc_head_setup/pages/mc_fees_head_page.dart';
import '../../moduls/pms_fnb/plan_approval/pages/plan_approval_page.dart';
import '../../moduls/pms_fnb/pms_reports/pages/pms_report_page.dart';
import '../../moduls/pms_fnb/production_plan/pages/production_plan_page.dart';
import '../../moduls/pms_fnb/production_process/pages/production_process.dart';
import '../../moduls/pms_fnb/row_material_analyser/pages/material_needs_analysis.dart';

Widget getPage(String id) {
  switch (id) {
    case "212":
      {
        return const LedgerMasterPage();
      }
    case "208":
      {
        return const LedgerMasterPage();
      }
    case "206":
      {
        return const SubLedgerMaster();
      }
    case "207":
      {
        return const ConstcenterPage();
      }
    case "209":
      {
        return const SubLeaderLinkageMaster();
      }
    case "211":
      {
        return const VoucherEntryPage();
      }
    case "214":
      {
        return const GlOpeningBalance();
      }
    case "218":
      {
        return const TrailBalance();
      }

    case "1289":
      {
        return const CostCeneterLinkagePage();
      }

    case "1291":
      {
        return const FinDefaultPageSetup();
      }
    case "1300":
      {
        return const BalanceSgeetPage();
      }

// for diet ###########################
    case '1315':
      return const DietCategory();
    case '1316':
      return const DietItems();
    case '1317':
      return const WeeklyMealPlan(); // MealPlan();
    case '1318':
      return const DietMenuConfig();
    case '1322':
      return const DietAssign();
//###########################

    // for pms fnb
    case "1305":
      {
        return const GoodsFormulaSetup();
      }
    case "1306":
      {
        return const ProductionPlan();
      }

    case "1307":
      {
        return const PlanApproval();
      }

    case "1308":
      {
        return const MaterialNeedsAnalysis();
      }
    case "1309":
      {
        return const ProductionProcess();
      }
    case "1310":
      {
        return const PmsReportsPage();
      }
// Laboratory ###########################
    case '1352':
      return const PathogenGroup();
    case '1353':
      return const PathogenAttr();
    case '1354':
      return const BiofirePanel();
    case '1356':
      return const PatientLabHistory();
    case '1355':
      return const BiofireResultEntry();
    case '1357':
      return const ResistanceGroup();
      case '1358' : return const ResistenceAttr();
//##############################

// App Dashboard ####################################
    case "1325":
      return const AppDocDepartment();
    case "1326":
      return const DoctorProfileSeup();
    case "1329":
      return const AppBanner();
    case "1328":
      return const AppTopDoctorList();
    case "1335":
      return const HealthPackageMaster();
    case "1337":
      return const AppInvAttrMaster();
    case "1336":
      return const HealthPackageConfig();
//##############################################################################################
    // MC Fee Management
    case '1344':
      return const McDefaultSetup();
    case '1342':
      return const McFeesHeadMaster();
    case '1347':
      return const McAccountEnrollMent();
    case '1343':
      return const McFeeCollection();
    // #############################################################################################
    case "":
      return const SizedBox(
          //child: Text("Under Construction!"),
          );
    default:
      return const Center(
        child: Text(
          "Under Construction!",
          style: TextStyle(fontSize: 30, color: Colors.blue),
        ),
      );
  }
}

Widget getDashBoard(String id) {
  switch (id) {
    case "198":
      {
        return const FinDashBoard();
      }

    default:
      return const Center();
  }
}
