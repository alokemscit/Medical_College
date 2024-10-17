// ignore_for_file: null_check_always_fails

import 'dart:convert';
import 'dart:typed_data';

import 'package:asgar_ali_hospital/constant/const.dart';
import 'package:asgar_ali_hospital/data/data_static_user.dart';
import 'package:asgar_ali_hospital/pages/login_page/model/model_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  ModelUser? _user;

  ModelUser? get user => _user;

  Future<void> loadUser() async {
    DataStaticUser.hcn = '';
    DataStaticUser.img = null;
    DataStaticUser.mob = '';
    DataStaticUser.name = '';
    DataStaticUser.bg = '';
    DataStaticUser.dob = '';
    DataStaticUser.gender = '';
    final prefs = await SharedPreferences.getInstance();
    final hcn = prefs.getString('hcn');
    final name = prefs.getString('name');
    final mob = prefs.getString('mob');
    //print(mob);
    final bg = prefs.getString('bg');
    final sex = prefs.getString('sex');
    final dob = prefs.getString('dob');
    final img = prefs.getString('img');
    _user = null;
    // print('aaaaaaa'+id.toString());
    if (hcn != null && name != null) {
      DataStaticUser.hcn = hcn;
      DataStaticUser.name = name;
      DataStaticUser.mob = mob!;
   
      DataStaticUser.dob = dob!;
      DataStaticUser.bg = bg!;
      DataStaticUser.gender = sex!;
      try {
        Uint8List bytes = base64Decode(img!);
        // Create an Image widget from the decoded bytes
        DataStaticUser.img = Image.memory(
          bytes,
          fit: BoxFit.cover,
          height: 55, // Adjust the fit property as needed
        );
      } catch (e) {
        print(e);
      }

      _user = ModelUser(
        hcn: hcn,
        name: name,
        mob: mob,
        bg: bg,
        sex: sex,
        dob: dob,
        img: img,
      );
      notifyListeners();
    }
    // notifyListeners();
  }

  // Log in a user and store their data in SharedPreferences.
  Future<void> login(
    String hcn,
    String? name,
    String? mob,
    String? bg,
    String? sex,
    String? dob,
    String? img,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('hcn', hcn);
    await prefs.setString('name', name!);
    await prefs.setString('mob', mob!);
    await prefs.setString('bg', bg!);
    await prefs.setString('sex', sex!);
    await prefs.setString('dob', dob!);
    await prefs.setString('img', img!);

    _user = ModelUser(
      hcn: hcn,
      name: name,
      mob: mob,
      bg: bg,
      sex: sex,
      dob: dob,
      img: img,
    );
    notifyListeners();
  }

  // Log out a user and clear their data from SharedPreferences.
  Future<void> logout() async {
    DataStaticUser.hcn = '';
    DataStaticUser.name = '';
    DataStaticUser.mob = '';
    DataStaticUser.dob = '';
    DataStaticUser.bg = '';
    DataStaticUser.gender = '';

    DataStaticUser.img = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('hcn');
    await prefs.remove('name');
    await prefs.remove('mob');
    await prefs.remove('bg');
    await prefs.remove('sex');
    await prefs.remove('dob');
    await prefs.remove('img');
    await prefs.clear();
    _user = null;
    notifyListeners();
  }
}

Future<ModelUser> loadUserInfo() async {
  final prefs = await SharedPreferences.getInstance();
  final hcn = prefs.getString('hcn');
  final name = prefs.getString('name');
  final mob = prefs.getString('mob');
  final bg = prefs.getString('bg');
  final sex = prefs.getString('sex');
  final dob = prefs.getString('dob');
  final img = prefs.getString('img');

  if (hcn != null && name != null) {
    return ModelUser(
      hcn: hcn,
      name: name,
      mob: mob,
      bg: bg,
      sex: sex,
      dob: dob,
      img: img,
    );
  } else {
    return null!;
  }
}
