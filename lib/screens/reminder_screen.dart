// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:test_project/models/reminder.dart';
import '../widgets/reminder_dropdown.dart';

class ReminderScreen extends StatefulWidget {
  const ReminderScreen({super.key});

  @override
  _ReminderScreenState createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  String? _selectedDay;
  String? _selectedActivity;
  DateTime _selectedTime = DateTime.now();
  List<Reminder> reminders = [];

  String? _dayError;
  String? _activityError;

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
                  _dayError = null;
                });
              },
            ),
            _dayError != null
                ? Text(_dayError!, style: const TextStyle(color: Colors.red))
                : const SizedBox(),
            const SizedBox(height: 20.0),
            ReminderDropdown(
              options: activities,
              selectedOption: _selectedActivity,
              onChanged: (value) {
                setState(() {
                  _selectedActivity = value;
                  _activityError = null;
                });
              },
            ),
            _activityError != null
                ? Text(_activityError!,
                    style: const TextStyle(color: Colors.red))
                : const SizedBox(),
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
                    '${_selectedTime.hour}:${_selectedTime.minute.toString().padLeft(2, '0')}',
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                _validateAndSetReminder();
              },
              child: const Text('Set Reminder'),
            ),
            const SizedBox(height: 20.0),
            Expanded(
              child: ListView.builder(
                itemCount: reminders.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      reminders[index] as String,
                      style: const TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _validateAndSetReminder() {
    setState(() {
      if (_selectedDay == null) {
        _dayError = 'Please select a day of the week';
      }
      if (_selectedActivity == null) {
        _activityError = 'Please select an activity';
      }

      if (_selectedDay != null && _selectedActivity != null) {
        _scheduleReminder();
      }
    });
  }

  void _scheduleReminder() {
    final now = DateTime.now();
    final reminderTime = DateTime(
      now.year,
      now.month,
      now.day,
      _selectedTime.hour,
      _selectedTime.minute,
    );

    final difference = reminderTime.difference(now).inSeconds;
    if (difference > 0) {
      setState(() {
        reminders.add(
            'Reminder set for $_selectedActivity on $_selectedDay at ${_selectedTime.hour}:${_selectedTime.minute.toString().padLeft(2, '0')}'
                as Reminder);
      });

      Future.delayed(Duration(seconds: difference), () {
        _playSound();
        // Show notification or alert dialog here
      });
    }
  }

  void _playSound() {
    FlutterRingtonePlayer().playNotification();
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
