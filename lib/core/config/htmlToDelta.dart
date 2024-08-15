import 'package:agmc/core/config/delta_to_html_converter.dart';
import 'package:flutter_quill/flutter_quill.dart';

Delta getDeltaFromHtml(String html) {
  Document d = Document.fromHtml(html);
  return d.toDelta();
}
