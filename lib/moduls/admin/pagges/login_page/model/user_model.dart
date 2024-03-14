// ignore: camel_case_types
// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class User_Model {
  String? sTATUS;
  String? sMSG;
  String? eMPID;
  String? pWS;
  String? eMPNAME;
  String? dEPTID;
  String? dEPTNAME;
  String? uID;
  String? uNAME;
  String? dSGID;
  String? dSGNAME;
  String? dOJ;
  String? sVSR1;
  String? sVSR1NAME;
  String? hOD1;
  String? hOD1NAME;
  String? iMAGE;
  String? iSDROP;
  Image? pHOTO;
  String? comID;
  User_Model(
      {this.sTATUS,
      this.sMSG,
      this.eMPID,
      this.pWS,
      this.eMPNAME,
      this.dEPTID,
      this.dEPTNAME,
      this.uID,
      this.uNAME,
      this.dSGID,
      this.dSGNAME,
      this.dOJ,
      this.sVSR1,
      this.sVSR1NAME,
      this.hOD1,
      this.hOD1NAME,
      this.iMAGE,
      this.iSDROP,
      this.pHOTO,
      this.comID}
      );
  User_Model.fromJson(Map<String, dynamic> json) {
    sTATUS = json['STATUS'];
    sMSG = json['MSG'];
    eMPID = json['EMP_ID'];
    pWS = json['PWS'];
    eMPNAME = json['EMP_NAME'];
    dEPTID = json['DEPT_ID'];
    dEPTNAME = json['DEPT_NAME'];
    uID = json['U_ID'];
    uNAME = json['U_NAME'];
    dSGID = json['DSG_ID'];
    dSGNAME = json['DSG_NAME'];
    dOJ = json['DOJ'];
    sVSR1 = json['SVSR_1'];
    sVSR1NAME = json['SVSR_1_NAME'];
    hOD1 = json['HOD_1'];
    hOD1NAME = json['HOD_1_NAME'];
    iMAGE = json['IMAGE'];
    iSDROP = json['IS_DROP'];
  }
}
