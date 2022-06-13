import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/sizes.dart';

class DateTimePicker extends StatefulWidget {
  DateTimePicker({Key? key, this.callback, this.date}) : super(key: key);
  Function(String)? callback;
  DateTime? date;
  @override
  State<DateTimePicker> createState() => _DateTimePickeerState();
}

class _DateTimePickeerState extends State<DateTimePicker> {
  DateTime dateTime = DateTime.now();
  showDateTime() async {
    DateTime? newDate = await showDatePicker(
        context: context,
        initialDate: dateTime,
        firstDate: DateTime.now(),
        lastDate: DateTime(2030));
    if (newDate == null) return;

    TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: dateTime.hour, minute: dateTime.minute),
    );
    if (newTime == null) return;
    final newDateTime = DateTime(
        newDate.year, newDate.month, newDate.day, newTime.hour, newTime.minute);
    setState(() {
      dateTime = newDateTime;
      widget.date = dateTime;
      widget.callback!(dateTime.toIso8601String());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(
        '${widget.date!.year}-${widget.date!.month}-${widget.date!.day} ${widget.date!.hour}:${widget.date!.minute}',
        style: const TextStyle(
            color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
      ),
      SizedBox(
        height: setHeight(context) * 0.015,
      ),
      GestureDetector(
        onTap: showDateTime,
        child: Container(
          width: setWidth(context) * 0.70,
          height: setHeight(context) * 0.08,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25), color: MyColors.myBlue),
          child: const Center(
            child: Text(
              'Select Ready Date & Time',
              style: TextStyle(
                  color: MyColors.myWhite,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
        ),
      ),
    ]);
  }
}
