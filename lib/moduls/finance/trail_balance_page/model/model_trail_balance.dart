class ModelTralBalance {
   String? grupID;
   String? grupCode;
   String? grupName;

   String? subGrupID;
   String? subGrupCode;
   String? subGrupName;

   String? ledgerID;
   String? ledgerCode;
   String ?ledgerNane;
   
     double? openingDr;
     double? openingCr;
     double? transDr;
     double? transCr;
     double? closingDr;
     double? closingCr;
   ModelTralBalance({ this.grupID,  this.grupCode,  this.grupName,  
   this.subGrupID,  this.subGrupCode,  this.subGrupName,  this.ledgerID,  this.ledgerCode,  this.ledgerNane, 
    this.openingDr,  this.openingCr,  this.transDr,  this.transCr,  this.closingDr,  this.closingCr});

    ModelTralBalance.fromJson(Map<String, dynamic> json) {
    grupID = json['GROUPID'];
    grupCode = json['GROUPCODE'];
     grupName = json['GROUPNAME'];

     subGrupID = json['SUBGROUPID'];
     subGrupCode = json['SUBGROUPCODE'];
     subGrupName = json['SUBGROUPNAME'];

     ledgerID = json['LEDGERID'];
     ledgerID = json['LEDGERCODE'];
     ledgerID = json['LEDGERNAME'];

    openingDr = json['OPENINGDR'];
    openingCr = json['OPENINGCR'];
    transDr = json['TRANDR'];
    transCr = json['TRANCR'];
    closingDr = json['CLOSINGDR'];
    closingCr = json['CLISINGCR'];
   
  }


}
