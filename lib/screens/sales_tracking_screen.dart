import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../widgets/section_header.dart';
import '../widgets/quality_note.dart';

class SalesTrackingScreen extends StatefulWidget {
  const SalesTrackingScreen({super.key});

  @override
  _SalesTrackingScreenState createState() => _SalesTrackingScreenState();
}

class _SalesTrackingScreenState extends State<SalesTrackingScreen> {
  DateTime _currentMonth = DateTime.now();
  DateTime? _selectedSaleDate;

  // Mock data for sales
  final Map<DateTime, List<String>> _salesData = {
    DateTime(2025, 4, 27): ['₹8,000 for 300 kg Coconut'],
    DateTime(2025, 4, 28): ['₹12,000 for 500 kg Arecanut - 9AM-4PM'],
    DateTime(2025, 4, 30): ['₹5,000 for 200 kg Paddy'],
    DateTime(2025, 5, 5): ['₹10,000 for 400 kg Wheat'],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Track Your Next Crop Sale'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SectionHeader(
              icon: Icons.calendar_month,
              title: 'Upcoming Sale Schedule',
            ),
            const SizedBox(height: 15),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    // Calendar Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.chevron_left, color: Colors.lightGreen),
                          onPressed: () {
                            setState(() {
                              _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1, 1);
                            });
                          },
                        ),
                        Text(
                          DateFormat.yMMMM().format(_currentMonth),
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            color: Colors.lightGreen.shade800,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.chevron_right, color: Colors.lightGreen),
                          onPressed: () {
                            setState(() {
                              _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1, 1);
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
                    // Calendar Grid
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 7,
                        childAspectRatio: 1.0,
                      ),
                      itemCount: DateTime(_currentMonth.year, _currentMonth.month + 1, 0).day + DateTime(_currentMonth.year, _currentMonth.month, 1).weekday % 7,
                      itemBuilder: (context, index) {
                        final firstDayOfMonth = DateTime(_currentMonth.year, _currentMonth.month, 1);
                        final dayOffset = firstDayOfMonth.weekday % 7;
                        final day = index - dayOffset + 1;

                        if (day <= 0) {
                          return Container();
                        }

                        final currentDate = DateTime(_currentMonth.year, _currentMonth.month, day);
                        // Normalize dates for map lookup (remove time component)
                        final normalizedCurrentDate = DateTime(currentDate.year, currentDate.month, currentDate.day);
                        final hasSale = _salesData.keys.any((saleDate) =>
                        saleDate.year == normalizedCurrentDate.year &&
                            saleDate.month == normalizedCurrentDate.month &&
                            saleDate.day == normalizedCurrentDate.day);

                        final isSelected = _selectedSaleDate != null &&
                            currentDate.day == _selectedSaleDate!.day &&
                            currentDate.month == _selectedSaleDate!.month &&
                            currentDate.year == _selectedSaleDate!.year;


                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedSaleDate = hasSale ? normalizedCurrentDate : null;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: isSelected ? Colors.lightGreen : (hasSale ? Colors.lightGreen.shade100 : Colors.transparent),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: (isSelected || hasSale) ? Colors.lightGreen : Colors.grey.shade300,
                                width: isSelected ? 2 : 1,
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '$day',
                                  style: TextStyle(
                                    color: isSelected ? Colors.white : (hasSale ? Colors.lightGreen.shade800 : Colors.black87),
                                    fontWeight: isSelected || hasSale ? FontWeight.bold : FontWeight.normal,
                                  ),
                                ),
                                if (hasSale && !isSelected)
                                  Container(
                                    width: 5,
                                    height: 5,
                                    decoration: BoxDecoration(
                                      color: Colors.lightGreen.shade700,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    if (_selectedSaleDate != null && _salesData.containsKey(_selectedSaleDate!))
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Card(
                          color: Colors.lightGreen.shade50,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(color: Colors.lightGreen),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.lightGreen,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    DateFormat('dd\nMMM').format(_selectedSaleDate!),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const SizedBox(width: 15),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: _salesData[_selectedSaleDate!]!.map((saleDetail) =>
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 4.0),
                                          child: Text(
                                            saleDetail,
                                            style: TextStyle(color: Colors.lightGreen.shade800, fontSize: 16),
                                          ),
                                        )
                                    ).toList(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            const SectionHeader(
              icon: Icons.check_circle_outline,
              title: 'Crop Improvement Reminder',
            ),
            const SizedBox(height: 15),
            const QualityNote(
              icon: Icons.thumb_up_alt_outlined,
              title: 'Ensure proper drying for Arecanut before your next sale! Check quality suggestions for improvement.',
              description: '', // No separate description, title contains full text
              color: Color(0xFFFFF3E0),
              iconColor: Colors.orange,
              isTitleOnly: true,
            ),
            const SizedBox(height: 30),
            const SectionHeader(
              icon: Icons.warning_amber,
              title: 'Upcoming Crop Info & Suggested Improvements',
            ),
            const SizedBox(height: 15),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    _buildImprovementSuggestion(
                      context,
                      crop: 'Arecanut',
                      quantity: '500 kg',
                      suggestion: 'Ensure you harvest at the right time and dry properly for premium prices!',
                    ),
                    const Divider(),
                    _buildImprovementSuggestion(
                      context,
                      crop: 'Coconut',
                      quantity: '200 kg',
                      suggestion: 'Harvest when the water inside makes a sloshing sound for best quality.',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Scheduling a visit or scanning your crop... (Mock)')),
                );
                // Navigate to Scan Crop or Schedule Visit
              },
              icon: const Icon(Icons.error_outline),
              label: const Text('Schedule a Visit or Scan Your Crop'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImprovementSuggestion(BuildContext context, {required String crop, required String quantity, required String suggestion}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.check_circle_outline, color: Colors.lightGreen),
              const SizedBox(width: 8),
              Text(
                '$crop ($quantity)',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.lightGreen.shade800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.only(left: 32.0),
            child: Text(
              suggestion,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
