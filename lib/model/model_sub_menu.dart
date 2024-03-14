import 'dart:convert';

import 'package:agmc/core/config/data_api.dart';

class Menu {
  String? id;
  String? name;
  List<Smenu>? smenu;

  Menu({this.id, this.name, this.smenu});

  Menu.fromJson(Map<String, dynamic> json) {
    id = json['ID'].toString();
    name = json['NAME'];
    //print(":::::"+json['smenu']);
    if (json['SMENU'] != null) {
      smenu = <Smenu>[];
      jsonDecode(json['SMENU']).forEach((v) {
        smenu!.add(Smenu.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;

    if (smenu != null) {
      data['smenu'] = smenu!.map((v) => v.toJson()).toList();
    }
    //print(data);
    return data;
  }
}

class Smenu {
  String? smId;
  String? smName;

  Smenu({this.smId, this.smName});

  Smenu.fromJson(Map<String, dynamic> json) {
    smId = json['sm_id'];
    smName = json['sm_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sm_id'] = smId;
    data['sm_name'] = smName;
    return data;
  }
}

//mList.map((post) => User_Model.fromJson(post)).toList();
// ignore: non_constant_identifier_names
Future<List<Menu>> get_sub_menu_data_list(String id) async {
  List<Menu> list = [];
  data_api repo = data_api();
  try {
    var x = await repo.createLead([
      //@name, @pid int,@img
      {"tag": "69", "pid": id}
    ]);
    // print(x);
    list = x
        .map((e) => Menu.fromJson(e))
        .toList()
        .where((element) => element.smenu != null)
        .toList();
  } catch (e) {
    //print(e);
    return [];
  }

  return list;
  //List<Menu> x = menu_data.map((e) => MenuData.fromJson(e)).toList();
  // return (list.where((o) => o.mid!.toString() == id).first).menu!.toList();
}
