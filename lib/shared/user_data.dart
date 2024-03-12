import 'package:agmc/moduls/admin/pagges/login_page/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataStaticUser {
  static String eid = '';
  static String name = '';
  static String dpid = '';
  static String dpname = '';
  static String dgid = '';
  static String dgname = '';
  static String uid = '';
  static String uname = '';
  static String? img = null;
  // Uint8List? img =null ;//await DataStaticUser.img.toByteData();
}

Future<User_Model> getUserInfo() async {
  final prefs = await SharedPreferences.getInstance();
  final eMPID = prefs.getString('eMPID');
  final eMPNAME = prefs.getString('eMPNAME');

  final dEPTID = prefs.getString('dEPTID');
  final dEPTNAME = prefs.getString('dEPTNAME');
  final uID = prefs.getString('uID');
  final uNAME = prefs.getString('uNAME');
  final dSGID = prefs.getString('dSGID');
  final dSGNAME = prefs.getString('dSGNAME');
  final iMAGE = prefs.getString('iMAGE');

  if (eMPID != null && eMPNAME != null) {
    return User_Model(
        eMPID: eMPID,
        eMPNAME: eMPNAME,
        dEPTID: dEPTID,
        dEPTNAME: dEPTNAME,
        uID: uID,
        uNAME: uNAME,
        dSGID: dSGID,
        dSGNAME: dSGNAME,
        iMAGE: iMAGE);
  }
  return User_Model();
}
