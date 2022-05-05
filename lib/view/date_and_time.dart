import 'package:flutter/material.dart';

class DateTimeDemo extends StatefulWidget {
  const DateTimeDemo({Key? key}) : super(key: key);

  @override
  State<DateTimeDemo> createState() => _DateTimeDemoState();
}

class _DateTimeDemoState extends State<DateTimeDemo> {
  DateTime _dateTime = DateTime.now();

  TimeOfDay? time = TimeOfDay.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${_dateTime.day}/${_dateTime.month}/${_dateTime.year}",
                style: const TextStyle(fontSize: 30),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () async {
                    DateTime? _newDate = await showDatePicker(
                      context: context,
                      initialDate: _dateTime,
                      firstDate: DateTime(1900),
                      lastDate: DateTime(3100),
                    );

                    if (_newDate != null) {
                      setState(() {
                        _dateTime = _newDate;
                      });
                    }
                  },
                  child: const Text("Choose Date")),
              const SizedBox(
                height: 30,
              ),
              Text(
                "${time!.hour}:${time!.minute}",
                style: const TextStyle(fontSize: 30),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  TimeOfDay? newTime = await showTimePicker(
                      context: context, initialTime: time!);

                  if (newTime != null) {
                    setState(() {
                      time = newTime;
                    });
                  }
                },
                child: const Text("Choose Time"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
