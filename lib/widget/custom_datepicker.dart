 
import 'package:agmc/core/config/const.dart';
 

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
  final bool isShowCurrentDate;
  final FontWeight textfontWeight;
  final double textfontSize;
  final bool isOnleClickDate;

  final FocusNode? focusNode;
  const CustomDatePicker({
    super.key,
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
    this.labelTextColor = Colors.black87,
    this.hintTextColor = Colors.black,
    this.borderRadious = 2,
    this.focusedBorderColor = Colors.black,
    this.focusedBorderWidth = 0.3,
    this.enabledBorderColor = Colors.grey,
    this.enabledBorderwidth = 0.4,
    this.isInputMode = false,
    this.focusNode,
    this.isShowCurrentDate = false,
    this.textfontWeight = FontWeight.w500,
    this.textfontSize = 13,  this.isOnleClickDate=false,
  });

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  @override
  void initState() {
    super.initState();
    if (widget.isShowCurrentDate) {
      widget.date_controller.text =
          DateFormat('dd/MM/yyyy').format(DateTime.now());
    }
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
        onTap: () async {
          !widget.isOnleClickDate?
           await  getDates():
          await _showDatePicker(context);
        },
        controller: widget.date_controller,
        style: TextStyle(
            fontFamily: "Muli",
            fontSize: widget.textfontSize,
            fontWeight: widget.textfontWeight,
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
               // getDates();
               !widget.isOnleClickDate?
           await  getDates():
          await _showDatePicker(context);
              }),
        ),
        readOnly: true,
        enableInteractiveSelection: false,
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

    // print('Selected date: $pickedDate');

    if (pickedDate != null) {
     // print(pickedDate);
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

  Future<void> _showDatePicker(BuildContext context) async {
    bool isMonth = false;
    final DateTime? selectedDate = await showDialog<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Select a Date',
            style: customTextStyle.copyWith(fontSize: 11),
          ),
          content: SingleChildScrollView(
            child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                DateTime selectedDate =
                    DateTime.now(); // Default to current date
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 200,
                      width: 280,
                      child: CalendarDatePicker(
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                        onDisplayedMonthChanged: (DateTime newDate) {
                          // print(newDate);
                          //print('1');
                          //if (selectedDate != newDate) {
                          isMonth = true;
                          // }
                        },
                        onDateChanged: (DateTime newDate) {
                          DateTime fromDate = DateFormat('dd/MM/yyyy')
                              .parse(widget.date_controller.text);
                          if (newDate.day != fromDate.day &&
                              newDate.month != fromDate.month &&
                              isMonth) {
                            isMonth = false;
                            //return;
                          }

                          // print(newDate.day);
                          // if (newDate.day == 1 && isMonth) {
                          //   isMonth = false;
                          //   print('in2');
                          //   return;
                          // }
                          // print('2');
                          String formattedDate =
                              DateFormat('dd/MM/yyyy').format(newDate);

                          //  print(formattedDate);
                          setState(() {
                            selectedDate = newDate;
                            widget.date_controller.text = formattedDate;
                            if (!isMonth) {
                              Navigator.of(context).pop(selectedDate);
                            }
                            isMonth = false;
                          });
                        },
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: TextButton(
                        onPressed: () {
                          //String formattedDate =
                          //  DateFormat('dd/MM/yyyy').format(selectedDate);
                          // setState(() {
                          // widget.date_controller.text = formattedDate;
                          Navigator.of(context).pop(selectedDate);
                          // });
                        },
                        child: Text(
                          'ok',
                          style: customTextStyle.copyWith(
                              color: appColorBlue,
                              fontSize: 13,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
