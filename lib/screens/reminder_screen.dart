import 'package:flutter/material.dart';
import '../widgets/reminder_dropdown.dart';

class ReminderScreen extends StatefulWidget {
  const ReminderScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ReminderScreenState createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  String? _selectedDay;
  String? _selectedActivity;
  DateTime _selectedTime = DateTime.now();

  final List<String> daysOfWeek = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  final List<String> activities = [
    'Wake up',
    'Go to gym',
    'Breakfast',
    'Meetings',
    'Lunch',
    'Quick nap',
    'Go to library',
    'Dinner',
    'Go to sleep',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reminder App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            ReminderDropdown(
              options: daysOfWeek,
              selectedOption: _selectedDay,
              onChanged: (value) {
                setState(() {
                  _selectedDay = value;
                });
              },
            ),
            const SizedBox(height: 20.0),
            ReminderDropdown(
              options: activities,
              selectedOption: _selectedActivity,
              onChanged: (value) {
                setState(() {
                  _selectedActivity = value;
                });
              },
            ),
            const SizedBox(height: 20.0),
            Row(
              children: [
                const Text('Select Time: '),
                const SizedBox(width: 10.0),
                TextButton(
                  onPressed: () {
                    _selectTime(context);
                  },
                  child: Text(
                    '${_selectedTime.hour}:${_selectedTime.minute}',
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Add reminder functionality here
                // You can use _selectedDay, _selectedActivity, and _selectedTime to create a reminder
              },
              child: const Text('Set Reminder'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_selectedTime),
    );
    if (pickedTime != null) {
      setState(() {
        _selectedTime = DateTime(
          _selectedTime.year,
          _selectedTime.month,
          _selectedTime.day,
          pickedTime.hour,
          pickedTime.minute,
        );
      });
    }
  }
}
