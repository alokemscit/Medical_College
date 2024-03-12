import 'package:agmc/config/const.dart';
import 'package:agmc/moduls/admin/pagges/login_page/model/user_model.dart';
import 'package:agmc/shared/user_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  User_Model? _user;

  User_Model? get user => _user;

  // Load user data from SharedPreferences when the app starts.
  Future<void> loadUser() async {
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
      _user = User_Model(eMPID:eMPID,
      eMPNAME:eMPNAME,
      dEPTID:dEPTID,
      dEPTNAME:dEPTNAME,
      uID:uID,
      uNAME:uNAME,
      dSGID:dSGID,
      dSGNAME:dSGNAME,
      iMAGE:iMAGE
      );

        DataStaticUser.eid = eMPID;
        DataStaticUser.name = eMPNAME;
        DataStaticUser.dpid = dEPTID!;
        DataStaticUser.dpname =dEPTID;
        DataStaticUser.dgid = dSGID!;
        DataStaticUser.dgname =dSGNAME!;
        DataStaticUser.uid = uID!;
        DataStaticUser.uname =uNAME!;
        DataStaticUser.img = iMAGE;


      notifyListeners();
    }
  }

  // Log in a user and store their data in SharedPreferences.
  Future<void> login(
  String eMPID,
  String eMPNAME,
  String dEPTID,
  String dEPTNAME,
  String uID,
  String uNAME,
  String dSGID,
  String dSGNAME,
  String iMAGE) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('eMPID', eMPID);
    await prefs.setString('eMPNAME', eMPNAME);
    await prefs.setString('dEPTID', dEPTID);
    await prefs.setString('dEPTNAME', dEPTNAME);
    await prefs.setString('uID', uID);
    await prefs.setString('uNAME', uNAME);
    await prefs.setString('dSGID', dSGID);
    await prefs.setString('dSGNAME', dSGNAME);
    await prefs.setString('iMAGE', iMAGE);

    _user = User_Model(eMPID:eMPID,
      eMPNAME:eMPNAME,
      dEPTID:dEPTID,
      dEPTNAME:dEPTNAME,
      uID:uID,
      uNAME:uNAME,
      dSGID:dSGID,
      dSGNAME:dSGNAME,
      iMAGE:iMAGE);

  DataStaticUser.eid = eMPID;
        DataStaticUser.name = eMPNAME;
        DataStaticUser.dpid = dEPTID;
        DataStaticUser.dpname =dEPTID;
        DataStaticUser.dgid = dSGID;
        DataStaticUser.dgname =dSGNAME;
        DataStaticUser.uid = uID;
        DataStaticUser.uname =uNAME;
        DataStaticUser.img = iMAGE;


    notifyListeners();
  }

  // Log out a user and clear their data from SharedPreferences.
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('eMPID');
    await prefs.remove('eMPNAME');
    await prefs.remove('dEPTID');
    await prefs.remove('dEPTNAME');
    await prefs.remove('uID');
    await prefs.remove('uNAME');
    await prefs.remove('dSGID');
    await prefs.remove('dSGNAME');
    await prefs.remove('iMAGE');

      DataStaticUser.eid = '';
        DataStaticUser.name ='';
        DataStaticUser.dpid = '';
        DataStaticUser.dpname ='';
        DataStaticUser.dgid = '';
        DataStaticUser.dgname ='';
        DataStaticUser.uid = '';
        DataStaticUser.uname ='';
        DataStaticUser.img = '';


    _user = null;
    notifyListeners();
  }
}
