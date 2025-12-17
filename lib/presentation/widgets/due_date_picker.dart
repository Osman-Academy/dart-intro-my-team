import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Widget that shows a due date picker for selecting task due dates.
class DueDatePicker extends StatefulWidget {
  final DateTime? initialDate;
  final ValueChanged<DateTime?> onDateChanged;

  const DueDatePicker({
    super.key,
    this.initialDate,
    required this.onDateChanged,
  });

  @override
  State<DueDatePicker> createState() => _DueDatePickerState();
}

class _DueDatePickerState extends State<DueDatePicker> {
  late DateTime? _selectedDate = widget.initialDate;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Due Date',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              if (_selectedDate != null)
                Text(
                  DateFormat('MMM dd, yyyy').format(_selectedDate!),
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildQuickButton('Today', DateTime.now()),
            _buildQuickButton(
              'Tomorrow',
              DateTime.now().add(const Duration(days: 1)),
            ),
            _buildQuickButton(
              'Next Week',
              DateTime.now().add(const Duration(days: 7)),
            ),
            ElevatedButton(
              onPressed: () => _pickCustomDate(),
              child: const Text('Custom'),
            ),
          ],
        ),
        if (_selectedDate != null)
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: () {
                widget.onDateChanged(_selectedDate);
                Navigator.pop(context);
              },
              child: const Text('Set Due Date'),
            ),
          ),
        if (_selectedDate != null)
          TextButton(
            onPressed: () {
              setState(() => _selectedDate = null);
              widget.onDateChanged(null);
              Navigator.pop(context);
            },
            child: const Text('Clear Date'),
          ),
      ],
    );
  }

  Widget _buildQuickButton(String label, DateTime date) {
    final isSelected = _selectedDate?.day == date.day &&
        _selectedDate?.month == date.month &&
        _selectedDate?.year == date.year;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.blue : Colors.grey.shade200,
        foregroundColor: isSelected ? Colors.white : Colors.black,
      ),
      onPressed: () => setState(() => _selectedDate = date),
      child: Text(label),
    );
  }

  Future<void> _pickCustomDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }
}
