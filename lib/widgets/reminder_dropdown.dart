import 'package:flutter/material.dart';

class ReminderDropdown extends StatelessWidget {
  final List<String> options;
  final String? selectedOption;
  final ValueChanged<String?> onChanged;
  const ReminderDropdown({
    super.key,
    required this.options,
    required this.selectedOption,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: selectedOption,
      onChanged: onChanged,
      items: options.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
