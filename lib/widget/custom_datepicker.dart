 
import 'package:agmc/core/config/colors.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class CustomDatePicker extends StatefulWidget {
  // ignore: non_constant_identifier_names
  final TextEditingController date_controller;
  final String? label;
  final Color? bgColor;
  final double? height;
  final double? width;
  final bool? isBackDate;
  final Color borderColor;
  final Color fontColor;
  final TextAlign? textAlign;
  final bool isFilled;
  final Color labelTextColor;
  final Color hintTextColor;
  final double borderRadious;
  final Color focusedBorderColor;
  final double focusedBorderWidth;
  final Color enabledBorderColor;
  final double enabledBorderwidth;
  final bool isInputMode;
   
  final FocusNode? focusNode;
  const CustomDatePicker(
      {super.key,
      // ignore: non_constant_identifier_names
      required this.date_controller,
      this.label = 'Select Date',
      this.bgColor = const Color.fromARGB(255, 218, 216, 216),
      this.height = 28,
      this.width = 140,
      this.borderColor = appColorGrayLight,
      this.isBackDate = false,
      this.isFilled = false,
      this.fontColor = Colors.black87,
      this.textAlign = TextAlign.start,
      this.labelTextColor = Colors.black,
      this.hintTextColor = Colors.black,
      this.borderRadious = 2,
      this.focusedBorderColor = Colors.black,
      this.focusedBorderWidth = 0.3,
      this.enabledBorderColor = Colors.grey,
      this.enabledBorderwidth = 0.4,
      this.isInputMode = false,
      this.focusNode});

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  @override
  void initState() {
    super.initState();

    // widget.date_controller.text =
    //     DateFormat('dd/MM/yyyy').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    //String formattedDate =DateFormat('dd/MM/yyyy').format(DateTime.now());
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.borderRadious),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                blurRadius: 0, spreadRadius: 0.01, color: widget.borderColor)
          ]),
      width: widget.width,
      height: widget.height,
      child: TextFormField(
        focusNode: widget.focusNode,
        onTap: () {
          getDates();
        },
        controller: widget.date_controller,
        style: TextStyle(
            fontFamily: "Muli",
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: widget.fontColor),
        textAlignVertical: TextAlignVertical.center,
        textAlign: widget.textAlign!,
        decoration: InputDecoration(
          fillColor: Colors
              .white, // Color.fromARGB(255, 253, 253, 255), //Colors.white,
          filled: widget.isFilled,
          labelText: widget.label,
          labelStyle: TextStyle(
              color: widget.labelTextColor,
              fontWeight: FontWeight.w300,
              fontSize: 13),
          hintStyle: TextStyle(
              color: widget.hintTextColor, fontWeight: FontWeight.w300),
          counterText: '',
          border: OutlineInputBorder(
              borderRadius:
                  BorderRadius.all(Radius.circular(widget.borderRadious)),
              borderSide: const BorderSide(color: Colors.white)),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadious),
            borderSide: BorderSide(
                color: widget.focusedBorderColor,
                width: widget.focusedBorderWidth),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadious),
            borderSide: BorderSide(
                color: widget.enabledBorderColor,
                width: widget.enabledBorderwidth),
          ),
          // contentPadding:
          //   const EdgeInsets.symmetric(vertical: 0, horizontal: 4),

          contentPadding: const EdgeInsets.only(
              bottom: 8,
              left: 6,
              right: 6) //.symmetric(vertical: 8, horizontal: 6),
          ,

          suffixIcon: InkWell(
              child: const Icon(Icons.calendar_month_outlined),
              onTap: () async {
                getDates();
              }),
        ),
        readOnly: true,
      ),
    );
  }

  Future<void> getDates() async {
    DateTime? pickedDate = await showDatePicker(
      locale: const Locale('en', 'GB'),
      context: context, // Pass the correct BuildContext.
      initialDate: DateTime.now(),
      firstDate: widget.isBackDate! ? DateTime(1800) : DateTime.now(),
      lastDate: DateTime(2101),
      fieldHintText: 'dd/mm/yyyy',

      // datePickerEntryMode : DatePickerEntryMode.input
      // initialentrymode: datepickerentrymode.input,
      initialEntryMode: widget.isInputMode
          ? DatePickerEntryMode.input
          : DatePickerEntryMode.calendar,
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
      setState(() {
        widget.date_controller.text = formattedDate;
      });
    } else {
      // print("Date is not selected");
      setState(() {
        widget.date_controller.text =
            DateFormat('dd/MM/yyyy').format(DateTime.now());
      });
    }
  }
}
