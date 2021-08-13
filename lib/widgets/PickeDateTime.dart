import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

typedef void DateTimeCallback(DateTime val);


class PickDateTimeWidget extends StatefulWidget {
  final DateTimeCallback callback;
  const PickDateTimeWidget({Key? key, required this.callback}) : super(key: key);

  @override
  _PickDateTimeWidgetState createState() => _PickDateTimeWidgetState();

}

class _PickDateTimeWidgetState extends State<PickDateTimeWidget> {
  DateTime dateTime = DateTime.now();

  String getText() {
    if (dateTime == null) {
      return 'Select DateTime';
    } else {
      return DateFormat('EEEE dd.MM\nkk:mm').format(dateTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Date',
          style: TextStyle(
            color: Colors.grey[800],
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          margin: const EdgeInsets.only(right : 80.0),
          padding: const EdgeInsets.symmetric(horizontal: 60.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size.fromHeight(40),
              primary: Colors.white,
            ),
            onPressed: () {pickDateTime(context);},
            child: FittedBox(
              child: Text(
                getText(),
                style: TextStyle(fontSize: 20, color: Colors.black,),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future pickDateTime(BuildContext context) async {
    final date = await pickDate(context);
    if (date == null) return;

    final time = await pickTime(context);
    if (time == null) return;

    setState(() {
      dateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
    widget.callback(dateTime);
  }

  Future<DateTime?> pickDate(BuildContext context) async {
    // final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: dateTime,
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    // if (newDate == null) return null;
    return newDate;
  }

  Future<TimeOfDay?> pickTime(BuildContext context) async {
    // final initialTime = TimeOfDay(hour: 12, minute: 0);
    final newTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay(hour: dateTime.hour, minute:dateTime.minute)
    );

    return newTime;
  }

}