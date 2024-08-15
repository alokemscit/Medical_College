// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:agmc/core/config/const.dart';
import 'package:agmc/core/config/delta_to_html_converter.dart';
import 'package:agmc/core/shared/user_data.dart';
import 'package:agmc/model/model_status.dart';

import 'package:agmc/widget/pdf_widget/invoice.dart';
import 'package:equatable/equatable.dart';

import 'package:htmltopdfwidgets/htmltopdfwidgets.dart';

import 'package:pdf/widgets.dart' as pw;

import 'package:quill_html_editor/quill_html_editor.dart';

import 'package:flutter/services.dart' show Uint8List, rootBundle;

import '../../../../widget/custom_snakbar.dart';
import '../../lab_outsource_result_entry/model/lab_model_outsource_result.dart';
import '../../lab_outsource_result_entry/model/lab_model_outsource_test_data.dart';
 

class LabOutSourceResultVerifyController extends GetxController
    with MixInController, _MyUI {
  final TextEditingController txt_fdate = TextEditingController();
  final TextEditingController txt_tdate = TextEditingController();
  final TextEditingController txt_search = TextEditingController();

  final QuillEditorController Qcontroller = QuillEditorController();
  var isShowLeftPanel = true.obs;
  //var selectedMrrID = ModelMrrDetailsList().obs;
  var isShowPatientDetails = true.obs;
  //final String b64_header =
  //  'iVBORw0KGgoAAAANSUhEUgAAAGQAAAAfCAIAAACeZf8BAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAwRSURBVGhD7VkJVFZlGn7Yd1ldMQPTbBGz1Fwml9IzmmZiWqaN1WS551I2iopgoGCJ43YwzVwKMctMSwX3cM0d0UAUQREFREFBVoF/nvfe7//5WXKaOWfOnMPMc67X777f8n/3+d71YmEwGPB//DH8C2RtP4+By4ESvNoF3VriQQVm91dd/yP4dzTreh5Gb8CeJFSUo/eTiBiKZ5qrrvqNh5E1LwbJWdh4GvY2SnK/FOGDhKCOLVD8AKOisCMBFQZ0fBRR76K5uxpWX1E3WYE/IzQGTRvAxgr21kJHWTlKy6WroFQMsH1zrBguHJHQRfvgYo9rt3EyQCT1GHWQ1XkBUm/DwwnsqKjEvSI0cMCLrTGoPUofwMYaB1Pw3SncuIVpA/D5a9h0Ch9sQBNXpNzCkU/Q1VetU/9Qjaz4DAxZKYrjYAuKaXTUrGXD8Go7NcAc9PeRB3ExC6khGB2N7QmiXyk5ODAFPVqrMfUM1cjq8hlu3lVM5RXh9ecQOVx1meP9KFhY4Mu3pP36KnFhY7vD6xO4OcDKApduITcC7o7a0LpQWCp3JzvtwYiSB3KvNMDRVns2Q1EZLC2kQTWvMYsorxD/UENOYVmFzKpzQXPU3oy+oJ01rK2UxDSmiqxpP+Dr49pLGpBdgPE9MX+Q3lMNbUOQUyBkNbDHpbkioXcb0x1ujnCZgkfdZZfuTjgToI2uBf6w8wT5CcNXSqLDYjy3CViirTfOByphTCKCfsbJNBkvsMS73bB2pNY2YtFefPw9/B5BwmwlIcJ3IWCbnFwF3WsLnJ2p5LVhMUru5puRuZsQNgwz+iqJxXtyN6zh7xvx932KqfwyvN+tGlPZ+apBkBRrS/H6N+4qyeyXsfoobCwx4nkJkbbWuJKDX/mGdWHBbjTxRGMvaZjA/XF6Whhm9kdSNtJzRXgpG/2XiR+cPQAHp+FYAJ73wbo4LI/T5hjBA27uicu31KMOZzu42GHhEAS9Iqu1DVXyGpjzs+ykoSeW7FcSgnMdG8jdBD7yIhRZ83ehsfbMwGeowMKhmlTD5rNoMg1PBqvH2Aniy5lM5C5UEiLgz3Jv7y3+jvB0wthoadRGyHY0c5MBKw8pCUF7oaomZWLeq0gLQQsPEY7dCEtL0bKQgejeGl18cHw6fpiAiT21ORoOXcblHPh5i43M3KqEOqjgnX0Q/IrY1G8ZSlgD82PR1FWC/vpfleThUGSt+EXZdmFZzbycrHu64mK6enS2x+kAXAyGnTH5MmFcDxRprofWTuWitdbAoRTY2mJaH0x6UQ78aKqS0+VRqQdESmB9xJisHUjC+B7wdlOPOl57VjV0ROxDUSl2TpDNh8UqoQ4nTTJpk8So4Z2U0Bxxl+SEggbgoz44l4FfLin5Q6DIul0IK63J357YSxMZsWcS3uyAM5p76rsMI9epa2CkuE9zcFvllWLIdMfkdF2t4xoTLSbMrdPHcaNb45WcqUlmOJq54i/r4P+FEhKdjFlb2m28vBzDVmPEGgxdhc1nlHxbvPBORP0V1tbYd1GTauBmzt/E92fwVBOseVsJzfFpjGi0/zN4p4u4DnO38HtQZFHhdcjbVgd9Ew2BRnqvGOduYMd5xF2W6/AVfF77B0ifFrkIV3vV0MFYdi1XwsLb6+TydMbCvaqLIHcZYbL1nRckKSHs7bBgj9YHse7MexKgqbDsZYZMrDsGD2ecvS4krjkCVwd8YWbanNKztRjjgHZVFYg5jlwRdR65VjbDufuTlfwhMJKkgYGRmzbH2mNoHYTH5uDpT+E2FlnhGPWCDHOwkR3UDuQm2FkhNlG1dQTtkCldW+LmPbm6+UpepvNCbxWyUxrR74GHlZwt7en9xMevPiztxxsjfhZ2TxIKGrpIJCEYFqgRDDh3CpGVD19P/HhO5DroTxjO6F5nVfdlOhjNaLndWiIzX9tMSzHbLw6qXsKxLn6NZGkGRabMsi7BT+fEiXi5yOSwEdhxAT1aycFWH2UGcq310aNtS9AkRoTHwtoCW8Zg72S52MhngrJRup4Lk/yDJtb1M5nuozn44P7wdhU37xeK17/EkFV4ai7OXsX6d6SXlkhO33oeP42T1WI/xKKhkih8rimj5EoPxCZWankiy/4aWLgHeferbYZqy9KN4FzmHMy3X4lEp3CRcClehCKLjlnRVF2zMgvEl1F2t0QOakBbDPTD/bIao6ogcq2P7ozB24TDKXJ6LAbMsXi4nARfqXgp+jyJjSdxpwhL38CQ59QA1gZL3oCHI36MFwfs44WrYXipjXRRxaikC/y1cRq6t5LrrBb4GBYYQKnIL7TC1N4iZNFmAjfTshGWV8+3l78p659Oh6+XrPOIh3g0Oj5CX5lQSemMrYg6LmZFfc6LUBkz4RciPNIrZ9xF4WIldJosHxjySzCrX7VowNMe/62WrEFKpUm9MN2Y1/0R5NxHQ2fVrgEqEd/B1phS/7cgmnXyKgY/I69HE6ADNk+RmGSSN9LJLJSJHz00wVMVhg2iseag12eVIDDUrDNWHJSLaDJde2bCtRNtgsUbfq0FTfqdvkvRJkg8CNEuFD6zcPu+tJvNQJvGeCwQvRdXTZ/8HaJPqbZp8f80hCzqSGdfiXdlleKbGGX0cENcuS47pg7zzR8PxPFURJ9E7yeQkSc66OOphhHM/Zhn6gSRycpKuDlpHRq4CEs8IvuG3Ncfk9c7NQPxMzH1e9wqwMHLaOSCsMHKeM+n4uo8NNfKlEzNsn6bg/3nVYF1twixSZj4rbQJLq7TShTgbjEK9XYaqlKJBBzlPVEUQ8JeOi7nIvsqLuYh5w6yOIvCZZiRiWts0Lr40iUoSsEFPpaipAByhspn8eWTgyU88z0ZQRhNddxcjPR5Uk7TUwzpgDc6YkQnxEwUb3IzHP7t1TBi3EZVA+igTY3UYpYOUkCX2WcJrFzlMT0PM/tJNOQ1dyCWHsDg9sLv0SsiIeyc4BuIKM2XQ9NWqjyLR7lDUgR6qzaNkF8sj/SqepJIrEbIacRFYModZKcj+RtEUPgNFj6NzpGY/RQ6rUTwj1hVhhLWsisQ6I6GARhWDnHgWUhvikc3YNF6LOC1EkGt0Jbj5+GDw9jOAfIj1JSWc/g/tnyAtFw4WGPvRXy0WSSsBpgxDnlWYtDm0SLRQULZZQK1JvqE5BM6GLbJhTlKHgh3jDsVmqNlNheXonUwU7+kWN49WVbQQ1JpodQ9QztIuwpGTxq6E2M2iE8Yv0l7NsDZaPJTEeENX2oEC1Aqzkh8TKEbvDjoWfRgm72DMToeR7JwvRckQHTCS7YQfWaDd3c08sETfuhaBrEFtjvgxY5al3LwzAmiTmDje9iViH5LJS7Qr3s44dT0hyVTPyXIp67iMjQLgJeTymy5HKvfykhthBEzt8mxhA6CxWswbBEJfRAdIgc3sEPyXJy4is5hsLVBzIeixaZhhKmtN5YcwNl0rH1bEh0Lfxi2ImyXfNpt5SVFWBqSUpHoAjfaEfXFGtaVqLSHUx5ukTIqFGtfKuIDlNnDkb00Qxe4F6HABnb2cKDpcXA5ypzg+hVCh2KcAxy5ydvI9Meoqk80PoHo+wRWal+pOobLCzPl41Ez8AX2l++fTHN1sKpIzJK9sqalTtEBszA2ff3JLRQ5y31z6E6QC7IMMK1TUKKRZUz0+UjoZmg+zNTWG/Jhw0rZHb0tp1NPqbl8D86lw+KbW2gWQzJJjYwza+sN80etnw9qJKFiGhxLUazLybgXmlSRxUqi1XQ05PkEiU4xr9mTJIfGAMdXZUJgYYmSMgkFLTywRvuoxNJn5Hrp0nMxorBUPiqcMMaseoYqsoijqfjTZ2jYQIr7qS9JwNZxLBUXMiW98DLmQSws/rZFlIi0ijloQh5vcw8c+qgqTatnqEYWceqa5Pj036KXBsz3Fz23spKPc0wOqEHUpphE4YUWwbJAryW5BCVFpYj7GE831Raqj6hJFpFwQ76TMEclTYxrjOjmoFXS9ZAmTtOZosvIKYBfM/nTTv1GHWTpWLIfU74TFWNJbGeleTmOVv8U6N3plZlb7JggZNV7/C5ZOhbvw55k7E4ULaNCmcB0gTS9/wIm9EQ7byWs9/gnZJlwLkP+BiF8GVBcLt9Ganzbq/8A/gHZ1rR+/J2nCgAAAABJRU5ErkJggg==';
  //var imgFooter = Rxn<pw.ImageProvider>();
  var rType = ''.obs;

  var list_test_data_master = <ModelOutSourceTestData>[].obs;
  var list_test_data_temp = <ModelOutSourceTestData>[].obs;
  var isShowFilter = false.obs;
  var selectedRadioValue = 1.obs;
  var selected_mrr = ModelOutSourceTestData().obs;
  var list_mrr_master = <_mrr>[].obs;
  var list_mrr_master_temp = <_mrr>[].obs;
  var list_result = <ModelOutSourceResult>[].obs;

  void setMrr(ModelOutSourceTestData a) async {
    loader = CustomBusyLoader(context: context);
    loader.show();
    list_result.clear();
    Qcontroller.clear();
    selected_mrr.value = a;
    try {
      var x = await api.createLead([
        {
          "tag": "40",
          "p_mr_id": a.mrId,
          "p_sample_id": a.sampleId,
          "p_test_id": a.testId
        }
      ], 'getdata_drs');
      //print(x);
      loader.close();
      if (checkJson(x)) {
        list_result.addAll(x.map((e) => ModelOutSourceResult.fromJson(e)));
        if (list_result.isNotEmpty) {
          ModelOutSourceResult s = list_result.first;
          var r = jsonDecode(s.delta!);
          Future.delayed(const Duration(seconds: 2), () {
            Qcontroller.setDelta(r);
          });
          // Qcontroller.
          //print(s.delta);
          // Qcontroller.setDelta(r);
        }
      }
    } catch (e) {
      loader.close();
    }
  }

  void undo_panel() {
    selected_mrr.value = ModelOutSourceTestData();
    txt_search.text = '';
    selected_mrr.refresh();
  }

  void search() {
    list_test_data_temp.clear();
    list_test_data_temp.addAll(list_test_data_master.where((e) =>
        e.mrId!.toUpperCase().contains(txt_search.text.toUpperCase()) ||
        e.sampleId!.toUpperCase().contains(txt_search.text.toUpperCase())));
    list_test_data_temp.refresh();
    dataManipulate();
  }

  void clickRadioButtpn() {
    selected_mrr.value = ModelOutSourceTestData();
    txt_search.text = '';
    list_test_data_temp.clear();
    // list_config_data.clear();
    // list_group.clear();
    // list_attr.clear();
    list_test_data_temp.addAll(list_test_data_master.where((e) =>
        e.mrType ==
        (selectedRadioValue.value == 1
            ? e.mrType
            : selectedRadioValue.value == 2
                ? 'O'
                : selectedRadioValue.value == 3
                    ? 'I'
                    : 'E')));
    list_test_data_temp.refresh();
    dataManipulate();
  }

  void dataManipulate() {
    list_mrr_master.clear();
    list_mrr_master_temp.clear();
    var mr = <_mrr>[];
    // var sm = <_mrr>[];
    list_test_data_temp.forEach((a) {
      mr.add(_mrr(id: a.mrId, name: a.mrId));
      // sm.add(_mrr(id: a.mrId, name: a.sampleId));
    });
    list_mrr_master.addAll(mr.toSet().toList());
    list_mrr_master_temp.addAll(list_mrr_master);
  }

  Future<String> _getHtmlText() async {
    Map<dynamic, dynamic> l = await Qcontroller.getDelta();

    var y = Delta.fromJson(l['ops']);

    var k = y.toHtml(options: ConverterOptions.forEmail());
    //print(k);
    var k1 = k
        .replaceAll('<table>',
            '<table style="width:100%;border: 1px solid black;border-collapse: collapse;">')
        .replaceAll('<tr>', '<tr style="border: 1px solid black;">')
        .replaceAll('<td',
            '<td style="border: 1px solid black; padding-left: 10px; margin-left:10px;"')
        .replaceAll('class="ql-align-center"', 'style="text-align:center"')
        .replaceAll('class="ql-align-right"', 'style="text-align:right"')
        .replaceAll('class="ql-size-small"', 'style="font-size:small"')
        .replaceAll('class="ql-size-large"', 'style="font-size:large"')
        .replaceAll('class="ql-size-huge"', 'style="font-size:x-large"')
        .replaceAll('<br/>', '<br/>\n')
        .replaceAll('<br>', '<br>\n')
        .replaceAll('class="ql-align-right"', 'style="text-align:right"');
    // print(k1);
    return k1;
  }

  void priview() async {
    var k1 = await _getHtmlText();
    Uint8List imageData = base64Decode(footerBase64);
    final image_footer = pw.MemoryImage(imageData);

    showPDF(k1, image_footer, this);
  }

  void save() async {
    loader = CustomBusyLoader(context: context);
    dialog = CustomAwesomeDialog(context: context);
    loader.show();
    try {
      Map<dynamic, dynamic> l = await Qcontroller.getDelta();

      var deltaJson = jsonEncode(l);
      var k1 = await _getHtmlText();

      var x = await api.createLead([
        {
          "p_result_id": " ",
          "p_mr_id": selected_mrr.value.mrId,
          "p_sample_id": selected_mrr.value.sampleId,
          "p_test_id": selected_mrr.value.testId,
          "p_delta": deltaJson,
          "p_html": k1,
          "p_pdf": "",
          "p_emp_id": user.value.eMPID,
          "p_is_final": "0"
        }
      ], 'outsource_result_save');
      loader.close();
      if (checkJson(x)) {
        var s = x.map((e) => ModelStatus.fromJson(e)).first;
        if (s.status != '1') {
          CustomSnackbar(
              context: context, message: s.msg!, type: MsgType.error);
        } else {
          CustomSnackbar(
              context: context, message: s.msg!, type: MsgType.success);

          Future.delayed(const Duration(seconds: 1), () {
            Uint8List imageData = base64Decode(footerBase64);
            final image_footer = pw.MemoryImage(imageData);
            //imageData = base64Decode(b64_header);
            //   final image_header = pw.MemoryImage(imageData);
            showPDF(k1, image_footer, this);
          });
        }
      } else {
        CustomSnackbar(
            context: context,
            message: 'Error to save data!',
            type: MsgType.error);
      }
      // ModelStatus s = await getStatusWithDialog(x, dialog);
      // if (s.status == '1') {
      // dialog
      //   ..dialogType = DialogType.success
      //   ..message = 's.msg'
      //   ..show();
      // }
    } catch (e) {
      loader.close();
      CustomSnackbar(
          context: context, message: e.toString(), type: MsgType.error);
      // dialog
      //   ..dialogType = DialogType.error
      //   ..message = e.toString()
      //   ..show();
    }
  }

  void showFilterData() async {
    loader = CustomBusyLoader(context: context);
    dialog = CustomAwesomeDialog(context: context);
    loader.show();
    list_test_data_master.clear();
    list_test_data_temp.clear();
    list_mrr_master.clear();
    list_mrr_master_temp.clear();
    if (!isValidDateRange(txt_fdate.text, txt_tdate.text)) {
      loader.close();
      dialog
        ..dialogType = DialogType.warning
        ..message = 'Valid Date Range Required'
        ..show();
      return;
    }
    try {
      var x = await api.createLead([
        {
          "tag": "39",
          "fdate": txt_fdate.text,
          "tdate": txt_tdate.text,
          "p_type": "E"
        }
      ], 'getdata_drs');
      //print(x);
      loader.close();
      if (checkJson(x)) {
        list_test_data_master
            .addAll(x.map((e) => ModelOutSourceTestData.fromJson(e)));
        list_test_data_temp.addAll(list_test_data_master);
        dataManipulate();
      }
    } catch (e) {
      loader.close();
      dialog
        ..dialogType = DialogType.error
        ..message = e.toString()
        ..show();
    }
  }

  @override
  void onInit() async {
    super.onInit();
    isLoading.value = true;
    user.value = await getUserInfo();
    if (user.value.eMPID == null) {
      isLoading.value = false;
      isError.value = true;
      errorMessage.value = 'Re-Loing Required!';
      return;
    }
    try {
      api = data_api();
      var x = await api.createLead([
        {"tag": "39", "fdate": " ", "tdate": " ", "p_type": "E"}
      ], 'getdata_drs');
      //print(x);
      if (checkJson(x)) {
        list_test_data_master
            .addAll(x.map((e) => ModelOutSourceTestData.fromJson(e)));
        list_test_data_temp.addAll(list_test_data_master);
        dataManipulate();
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      isError.value = true;
      errorMessage.value = e.toString();
    }
  }

  @override
  void onClose() {
    Qcontroller.dispose();
    super.onClose();
  }
}

class _mrr extends Equatable {
  String? id;
  String? name;
  _mrr({
    this.id,
    this.name,
  });

  @override
  List<Object?> get props => [id, name];
}

mixin _MyUI {
  void showPDF(
      String body, pw.MemoryImage image_footer, dynamic controller) async {
    // var body = k1;

    final pdf = pw.Document();
    final fontData =
        await rootBundle.load('assets/fonts/openSans/OpenSans-Regular.ttf');
    final fontData1 =
        await rootBundle.load('assets/fonts/openSans/OpenSans-Bold.ttf');
    var font = pw.Font.ttf(fontData);
    List<Font> lfont = [];
    lfont.add(font);
    font = pw.Font.ttf(fontData1);
    final widgets = await HTMLToPdf().convert(body, fontFallback: lfont);
    lfont.add(font);

 
    // print(widgets.toString());
    pdf.addPage(
      pw.MultiPage(
        pageFormat:PdfPageFormat.a4 ,
        margin: const pw.EdgeInsets.only(left: 8,right: 8,bottom: 52,top: 8),
        header: (pw.Context context) {
          return header(controller);
        },
        footer: (context) {
          return footer(image_footer, controller);
        },
        build: (context) => widgets,
      ),
    );
    PdfInvoiceApi.openPdFromFile(pdf);
  }

  pw.Widget header(LabOutSourceResultVerifyController controller) => pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 2),
      child: pw.Table(
          border: pw.TableBorder.all(
              width: 0.4, color: const PdfColor.fromInt(0xFF30384D)),
          columnWidths: {
            0: const pw.FixedColumnWidth(40.0),
            1: const pw.FixedColumnWidth(60.0), // Third column width
          },
          children: [
            pw.TableRow(
                verticalAlignment: pw.TableCellVerticalAlignment.middle,
                children: [
                  pw.Padding(
                      padding: const pw.EdgeInsets.all(8),
                      child: pw.SizedBox(height: 40, width: 160)),
                  //pw.Image(image_header, height: 40, width: 160)),
                  pw.Padding(
                      padding: const pw.EdgeInsets.all(8),
                      child: pw.Align(
                          alignment: pw.Alignment.topLeft,
                          child: pw.Table(columnWidths: {
                            0: const pw.FixedColumnWidth(60.0),
                            1: const pw.FixedColumnWidth(40.0),
                          }, children: [
                            pw.TableRow(children: [
                              pw.Column(children: [
                                _headerRow("Name  : ",
                                    controller.selected_mrr.value.pname ?? ''),
                                pw.SizedBox(height: 2),
                                _headerRow("Age     : ",
                                    controller.selected_mrr.value.age ?? ''),
                                pw.SizedBox(height: 2),
                                _headerRow(
                                    "Dept    : ",
                                    controller.selected_mrr.value.department ??
                                        ''),
                                pw.SizedBox(height: 2),
                                _headerRow("Unit     : ",
                                    controller.selected_mrr.value.unit ?? ''),
                                pw.SizedBox(height: 2),
                                _headerRow(
                                    "Ref By : ",
                                    controller.selected_mrr.value.docName ??
                                        ''),
                                pw.SizedBox(height: 2),
                              ]),
                              pw.Column(children: [
                                _headerRow("MR No   : ",
                                    controller.selected_mrr.value.mrId ?? ''),
                                pw.SizedBox(height: 2),
                                _headerRow("HCN       : ",
                                    controller.selected_mrr.value.hcn ?? ''),
                                pw.SizedBox(height: 2),
                                _headerRow("Adm No : ",
                                    controller.selected_mrr.value.regId ?? ''),
                                pw.SizedBox(height: 2),
                                _headerRow("Gender  : ",
                                    controller.selected_mrr.value.psex ?? ''),
                                pw.SizedBox(height: 2),
                                _headerRow("Bed No  : ",
                                    controller.selected_mrr.value.bedno ?? ''),
                                pw.SizedBox(height: 2),
                              ])
                            ])
                          ])))
                ]),
          ]));

  pw.Widget _headerRow(String caption, String value) =>
      pw.Row(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
        pw.Text(caption,
            style: pw.TextStyle(fontSize: 9, fontWeight: FontWeight.bold)),
        pw.Text(value,
            style: pw.TextStyle(fontSize: 9, fontWeight: FontWeight.normal))
      ]);

  pw.TableRow _footerRow(
          String cap1, String value1, String cap2, String value2) =>
      pw.TableRow(
          verticalAlignment: pw.TableCellVerticalAlignment.middle,
          children: [
            pw.Row(children: [
              pw.Text(cap1,
                  style:
                      pw.TextStyle(fontSize: 9, fontWeight: FontWeight.bold)),
              pw.SizedBox(width: 8),
              pw.Text(value1,
                  style:
                      pw.TextStyle(fontSize: 9, fontWeight: FontWeight.normal)),
            ]),
            pw.Row(mainAxisAlignment: pw.MainAxisAlignment.end, children: [
              pw.Text(cap2,
                  style:
                      pw.TextStyle(fontSize: 9, fontWeight: FontWeight.bold)),
              pw.SizedBox(width: 8),
              pw.Text(value2,
                  style:
                      pw.TextStyle(fontSize: 9, fontWeight: FontWeight.normal)),
            ])
          ]);

  pw.Widget footer(pw.MemoryImage image_footer,
          LabOutSourceResultVerifyController controller) =>
      pw.Column(children: [
        pw.Table(children: [
          pw.TableRow(children: [
            pw.Container(
              height: 0.8,
              color: const PdfColor.fromInt(0xFF30384D),
            ),
          ]),
          pw.TableRow(children: [
            pw.Container(
                child: pw.Table(children: [
              _footerRow(
                  "Verify By      : ",
                  controller.selected_mrr.value.verifyBy ?? '',
                  "Finalized By : ",
                  controller.selected_mrr.value.finalizedBy ?? ''),
              pw.TableRow(children: [pw.Container(height: 2)]),
              _footerRow(
                  "Verify Date   : ",
                  controller.selected_mrr.value.verifyDate ?? '',
                  "Finalized Date : ",
                  '      ${controller.selected_mrr.value.finalizedDate ?? ''}'),
            ])),
          ]),
          pw.TableRow(children: [
            pw.Container(
              height: 0.5,
              color: const PdfColor.fromInt(0xFF30384D),
            ),
          ]),
        ]),
        pw.Table(children: [
          pw.TableRow(children: [pw.Container(height: 2)]),
          pw.TableRow(
              verticalAlignment: pw.TableCellVerticalAlignment.middle,
              children: [
                pw.Row(children: [
                  pw.Text("115/7/A Distillery Road, Gendaria, Dhaka-1204",
                      style: pw.TextStyle(
                          fontSize: 6, fontWeight: FontWeight.bold)),
                  pw.SizedBox(width: 8),
                  // pw.Text("10/08/24 ",style: pw.TextStyle(fontSize: 11,fontWeight:FontWeight.normal))
                ]),
                pw.Row(mainAxisAlignment: pw.MainAxisAlignment.end, children: [
                  pw.Text("Email:info@agh.com,admin@agh.com ",
                      style: pw.TextStyle(
                          fontSize: 6, fontWeight: FontWeight.bold)),
                  pw.SizedBox(width: 8),
                  pw.Text("Web: www.agh.com,www.citygroupbd.com",
                      style: pw.TextStyle(
                          fontSize: 5.5, fontWeight: FontWeight.normal))
                ])
              ]),
          pw.TableRow(children: [pw.Container(height: 2)]),
          pw.TableRow(
              verticalAlignment: pw.TableCellVerticalAlignment.middle,
              children: [
                pw.Row(children: [
                  pw.Text("Powered by :",
                      style: pw.TextStyle(
                          fontSize: 6, fontWeight: FontWeight.bold)),
                  pw.SizedBox(width: 8),
                  pw.Text("AAH, IT-Software Team",
                      style: pw.TextStyle(
                          fontSize: 5.5, fontWeight: FontWeight.bold))
                ]),
                pw.Row(mainAxisAlignment: pw.MainAxisAlignment.end, children: [
                  pw.SizedBox(width: 8),
                  pw.Image(image_footer, height: 8, width: 60),
                ])
              ])
        ])
      ]);
}
