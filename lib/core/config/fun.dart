// import 'dart:convert';
// import 'dart:typed_data';
// import 'dart:html' as html;
// import 'package:flutter/material.dart';
// import 'package:excel/excel.dart' as excel;

// Future< void>  exportExcelData(List<dynamic> data,[String filename='excelFile']) async{
//  excel.Excel excelFile = excel.Excel.createExcel();
//     excel.Sheet sheetObject = excelFile['Sheet1'];


// List<Map<String, dynamic>> jsonData = [
//       {'Name': 'John', 'Age': 30, 'Country': 'USA'},
//       {'Name': 'Alice', 'Age': 25, 'Country': 'UK'},
//       {'Name': 'Bob', 'Age': 35, 'Country': 'Canada'},
//     ];

//     // Convert JSON data to a list of lists (rows)
//     List<dynamic> excelData = [
//       ['Name', 'Age', 'Country'], // Header row
//       for (var entry in jsonData)
//         [entry['Name'], entry['Age'], entry['Country']] // Data rows
//     ];


//     // Add data to the Excel file
//     for (var row in excelData) {
//       sheetObject.appendRow(row);
//     }

//     // Save Excel file as bytes
//     List<int>? excelBytes = excelFile.encode();

//     // Convert bytes to Uint8List
//     Uint8List excelUint8List = Uint8List.fromList(excelBytes!);

//     // Create a Blob from Uint8List
//     final blob = html.Blob([excelUint8List]);

//     // Create a download link
//     final url = html.Url.createObjectUrlFromBlob(blob);
//     final anchor = html.AnchorElement(href: url)
//       ..setAttribute("download", "data.xlsx")
//       ..click();

//     // Cleanup
//     html.Url.revokeObjectUrl(url);
// }