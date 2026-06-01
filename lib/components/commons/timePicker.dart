import 'package:birdle/utils/theme/theme.dart';
import 'package:flutter/material.dart';

class TimePicker extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;
  final TimeOfDay? initialTime;

  const TimePicker({
    super.key,
    required this.controller,
    this.hintText = 'HH:MM',
    this.validator,
    this.initialTime,
  });

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  TimeOfDay? selectedTime;

  @override
  void initState() {
    super.initState();
    if (widget.initialTime != null) {
      selectedTime = widget.initialTime;
      widget.controller.text = widget.initialTime!.format(context);
    }
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? widget.initialTime ?? TimeOfDay.now(),
      // firstTime: TimeOfDay.now()
      initialEntryMode: TimePickerEntryMode.input,
    );

    if (picked == null) return;

    setState(() {
      selectedTime = picked;
      widget.controller.text = picked.format(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      readOnly: true,
      onTap: _pickTime,
      validator: widget.validator,
      decoration: TAppTheme.fieldDecoration(hintText: widget.hintText),
    );
  }
}
