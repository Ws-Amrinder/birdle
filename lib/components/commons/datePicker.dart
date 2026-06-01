import 'package:flutter/material.dart';

class DatePicker extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;
  final DateTime? initialDate;

  const DatePicker({
    super.key,
    required this.controller,
    this.hintText = 'DD/MM/YYYY',
    this.validator,
    this.initialDate,
  });

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    if (widget.initialDate != null) {
      selectedDate = widget.initialDate;
      widget.controller.text = _formatDate(widget.initialDate!);
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  Future<void> _selectDate() async {
    final now = DateTime.now();
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? widget.initialDate ?? now,
      // firstDate: DateTime(now.year - 5),
      firstDate: DateTime.now(),
      lastDate: DateTime(now.year + 5),

    );

    if (pickedDate == null) return;

    setState(() {
      selectedDate = pickedDate;
      widget.controller.text = _formatDate(pickedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      onTap: _selectDate,
      controller: widget.controller,
      validator: widget.validator,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFFD3D1C7), width: 1),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFFD3D1C7), width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
        hintText: widget.hintText,
      ),
    );
  }
}
