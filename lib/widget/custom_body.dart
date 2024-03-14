// ignore_for_file: non_constant_identifier_names

import 'package:agmc/core/config/const.dart';
import 'package:agmc/core/config/responsive.dart';
import 'package:flutter/cupertino.dart';

CustomCommonBody(bool isLoading, bool isError, String errorMessage, Widget mobile,
    Widget tablet, Widget desktop) {
  if (isLoading) {
    return const Center(child: CupertinoActivityIndicator());
  }
  if (isError) {
    return Text(
      errorMessage,
      style: const TextStyle(color: Colors.red),
    );
  }
  return Responsive(
    mobile: mobile,
    tablet: tablet,
    desktop: desktop,
  );
}
