import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../widgets/info_tip.dart';

class ScheduleVisitScreen extends StatefulWidget {
  const ScheduleVisitScreen({super.key});

  @override
  _ScheduleVisitScreenState createState() => _ScheduleVisitScreenState();
}

class _ScheduleVisitScreenState extends State<ScheduleVisitScreen> {
  DateTime _selectedDate = DateTime.now();
  String? _selectedTimeSlot;
  final TextEditingController _addressController = TextEditingController();

  final List<String> _timeSlots = [
    '9 AM - 10 AM',
    '10 AM - 11 AM',
    '11 AM - 12 PM',
    '1 PM - 2 PM',
    '2 PM - 3 PM',
    '3 PM - 4 PM',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Schedule Farm Visit'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Calendar Header (Mock)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.chevron_left, color: Colors.lightGreen),
                          onPressed: () {
                            setState(() {
                              _selectedDate = DateTime(_selectedDate.year, _selectedDate.month - 1, _selectedDate.day);
                            });
                          },
                        ),
                        Text(
                          DateFormat.yMMMM().format(_selectedDate),
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            color: Colors.lightGreen.shade800,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.chevron_right, color: Colors.lightGreen),
                          onPressed: () {
                            setState(() {
                              _selectedDate = DateTime(_selectedDate.year, _selectedDate.month + 1, _selectedDate.day);
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Days of the week header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']
                          .map((day) => Text(day, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey.shade700)))
                          .toList(),
                    ),
                    const SizedBox(height: 10),
                    // Calendar Grid (Simplified)
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 7,
                        childAspectRatio: 1.0,
                      ),
                      itemCount: DateTime(_selectedDate.year, _selectedDate.month + 1, 0).day + DateTime(_selectedDate.year, _selectedDate.month, 1).weekday % 7,
                      itemBuilder: (context, index) {
                        final firstDayOfMonth = DateTime(_selectedDate.year, _selectedDate.month, 1);
                        final dayOffset = firstDayOfMonth.weekday % 7; // 0 for Sunday, 1 for Monday
                        final day = index - dayOffset + 1;

                        if (day <= 0) {
                          return Container(); // Empty cells for days before the 1st
                        }

                        final currentDate = DateTime(_selectedDate.year, _selectedDate.month, day);
                        final isSelected = currentDate.day == _selectedDate.day &&
                            currentDate.month == _selectedDate.month &&
                            currentDate.year == _selectedDate.year;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedDate = currentDate;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: isSelected ? Colors.lightGreen : Colors.transparent,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: currentDate.isBefore(DateTime.now().subtract(const Duration(days: 1)))
                                    ? Colors.transparent
                                    : (isSelected ? Colors.lightGreen : Colors.grey.shade300),
                                width: 1,
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              '$day',
                              style: TextStyle(
                                color: isSelected
                                    ? Colors.white
                                    : (currentDate.isBefore(DateTime.now().subtract(const Duration(days: 1)))
                                    ? Colors.grey
                                    : Colors.black87),
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Select Time Slot',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.lightGreen.shade700,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: _selectedTimeSlot,
                    hint: Text('-- Select a time slot --', style: TextStyle(color: Colors.grey.shade600)),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedTimeSlot = newValue;
                      });
                    },
                    items: _timeSlots.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Enter your Farm Address',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.lightGreen.shade700,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextFormField(
                  controller: _addressController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    hintText: 'Enter address or pin your location',
                    border: InputBorder.none, // Remove default border
                    contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const InfoTip(
              icon: Icons.lightbulb_outline,
              text: 'Tip: Ensure someone is present at the farm during the visit for smooth quality checking!',
              color: Color(0xFFFFF9C4),
              iconColor: Colors.orange,
            ),
            const SizedBox(height: 30),
              icon: const Icon(Icons.event_available),
              label: const Text('Confirm Visit'),
            ),
          ],
        ),
      ),
    );
  }
}
