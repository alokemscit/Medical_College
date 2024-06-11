// ignore_for_file: camel_case_types

import 'dart:convert';
 
import 'package:http/http.dart' as http;

class data_api {
  Future<List<dynamic>> createLead(List<dynamic> parameter,
      [String methods = "getdata"]) async {
    List<dynamic> apiData1 = [];

    //print(object)
    String url = 'https://web.asgaralihospital.com/api/mob/$methods';
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Methods":
            "Origin, X-Requested-With, Content-Type, Accept",
      },
      body: jsonEncode(parameter),
    );
    if (response.statusCode == 200) {
      //print(response.body);
      apiData1 = jsonDecode(response.body);
    } else {
      apiData1 = [];
    }
    return apiData1;
  }

  Future<List<dynamic>> otp(List<dynamic> parameter) async {
    List<dynamic> apiData1 = [];
    String url = 'https://web.asgaralihospital.com/api/mob/generate_otp';
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Methods":
            "Origin, X-Requested-With, Content-Type, Accept",
      },
      body: jsonEncode(parameter),
    );
    if (response.statusCode == 200) {
      print(response.body);
      apiData1 = jsonDecode(response.body);
      print(apiData1);
    } else {
      apiData1 = [];
    }
    return apiData1;
  }


  
Future<List<dynamic>> get_mysql_doctor(
      [String methods = "get_mysql_doctor"]) async {
    List<dynamic> apiData1 = [];

    //print(object)
    String url = 'https://web.asgaralihospital.com/api/mob/$methods';
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Methods":
            "Origin, X-Requested-With, Content-Type, Accept",
      },
      //body: jsonEncode(parameter),
    );
    if (response.statusCode == 200) {
      //print(response.body);
      apiData1 = jsonDecode(response.body);
    } else {
      apiData1 = [];
    }
    return apiData1;
  }
}
