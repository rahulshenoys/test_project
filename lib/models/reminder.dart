class Reminder {
  String dayOfWeek;
  String activity;
  DateTime time;
  Reminder(this.dayOfWeek, this.activity, this.time);

  String get formattedTime {
    return '${time.hour}:${time.minute.toString().padLeft(2, '0')}';
  }
}
