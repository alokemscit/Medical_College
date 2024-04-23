//import 'dart:convert';
import 'dart:html' as html;
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:excel/excel.dart' as excel;

Future<List<Map<String, dynamic>>> excelFilePicker() async {
  var excelData = [];
  List<Map<String, dynamic>> jsonData = [];

  try {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
    );

    if (result != null) {
      PlatformFile file = result.files.first;
      Uint8List fileBytes = file.bytes as Uint8List;

      // Read Excel data and convert to JSON
      excelData = await _parseExcel(fileBytes);
      List<dynamic> col = excelData.first;
      for (int i = 1; i < excelData.length; i++) {
        List<dynamic> row = excelData[i];
        Map<String, dynamic> rowData = {};
        for (int j = 0; j < col.length; j++) {
          rowData['"${col[j]}"'] = '"${row[j].toString()}"';
        }
        jsonData.add(rowData);
      }
    }
  } catch (e) {
    print(e);
  }
 // exportJsonToExcel(jsonData);
  //var x = jsonEncode(jsonData);
  // print(jsonData);

  return jsonData;
}

Future<List<dynamic>> _parseExcel(Uint8List fileBytes) async {
  // Decode Excel data
  excel.Excel excelFile = excel.Excel.decodeBytes(fileBytes);
  // Get the first sheet
  var sheet = excelFile.tables.keys.first;
  // Get the rows of the sheet
  var table = excelFile.tables[sheet];
  //print(table);
  // Extract data from all cells

  var excelData = [];
  // var i = 0;

  try {
    for (var row in table!.rows) {
      List<dynamic> rowData = [];
      for (var cell in row) {
        rowData.add(cell!.value == null ? '' : cell.value);
      }
      excelData.add(rowData);
    }
  } catch (e) {
    print(e.toString());
  }
  return excelData;
}

void exportJsonToExcel(List<dynamic> jsonData,
    [String filename = 'excelFile']) {
  // Convert JSON data to CSV format
  String csv = _jsonToCsv(jsonData);

  // Create a Blob containing the CSV data
  final blob = html.Blob([csv], 'text/csv');

  // Create download link
  final url = html.Url.createObjectUrlFromBlob(blob);
  final anchor = html.AnchorElement(href: url)
    ..setAttribute("download", "$filename.csv")
    ..click();

  // Clean up
  html.Url.revokeObjectUrl(url);
}

String _jsonToCsv(List<dynamic> jsonData) {
  if (jsonData.isEmpty) return '';

  // Extract headers from the first JSON object
  List<String> headers = [];
  jsonData[0].forEach((key, value) {
    headers.add(key.toString());
  });

  // Extract values for each JSON object
  List<String> rows = [];
  for (var jsonObject in jsonData) {
    List<String> row = [];
    jsonObject.forEach((key, value) {
      row.add(value.toString());
    });
    rows.add(row.join(','));
  }

  // Combine headers and rows
  String csv = '${headers.join(',')}\n${rows.join('\n')}';

  return csv;
}
