import 'package:flutter/material.dart';
import '../widgets/section_header.dart';
import '../widgets/quality_note.dart';
import '../widgets/info_tip.dart';

class CropReportScreen extends StatelessWidget {
  const CropReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Crop Quality Report & Payment Details'),
        toolbarHeight: 80, // Adjust height to fit longer title
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SectionHeader(
              icon: Icons.bar_chart,
              title: 'Crop Quality Summary',
            ),
            const SizedBox(height: 15),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    _buildCropQualityItem(
                      context,
                      crop: 'Coconut',
                      score: 92,
                      status: 'Excellent',
                      suggestion: 'Quality Score: 92% - Slightly high moisture detected. Suggest drying 2 extra days.',
                      statusColor: Colors.green,
                    ),
                    const Divider(),
                    _buildCropQualityItem(
                      context,
                      crop: 'Paddy',
                      score: 84,
                      status: 'Good',
                      suggestion: 'Quality Score: 84% - Good grain quality. Maintain current storage conditions.',
                      statusColor: Colors.orange,
                    ),
                    const Divider(),
                    _buildCropQualityItem(
                      context,
                      crop: 'Arecanut',
                      score: 78,
                      status: 'Needs Improvement',
                      suggestion: 'Quality Score: 78% - Some unripe nuts detected.',
                      statusColor: Colors.red,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            const SectionHeader(
              icon: Icons.bug_report,
              title: 'Defects Detected',
            ),
            const SizedBox(height: 15),
            const Card(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    QualityNote(
                      icon: Icons.warning_amber,
                      title: 'Coconut Quality Note',
                      description: 'Slightly high moisture detected (12.5%). Suggest drying 2 extra days to reach optimal 10% moisture level for better pricing.',
                      color: Color(0xFFF1F8E9),
                      iconColor: Colors.lightGreen,
                    ),
                    SizedBox(height: 15),
                    QualityNote(
                      icon: Icons.warning_amber,
                      title: 'Arecanut Quality Note',
                      description: 'Some unripe nuts detected (15%). Suggest delayed harvest by 7-10 days for more uniform maturity and better market value.',
                      color: Color(0xFFFFF3E0),
                      iconColor: Colors.orange,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            const SectionHeader(
              icon: Icons.payments,
              title: 'Payment Summary',
            ),
            const SizedBox(height: 15),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: _buildPaymentDetailTile(
                            context,
                            label: 'Amount',
                            value: '₹15,000',
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: _buildPaymentDetailTile(
                            context,
                            label: 'Date',
                            value: '2025-04-26',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: _buildPaymentDetailTile(
                            context,
                            label: 'Transaction ID',
                            value: '#BLink20250426',
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: _buildPaymentDetailTile(
                            context,
                            label: 'Payment Method',
                            value: 'UPI',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.lightGreen.shade50,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.check_circle_outline, color: Colors.lightGreen, size: 20),
                          SizedBox(width: 8),
                          Text(
                            'Payment Confirmed',
                            style: TextStyle(color: Colors.lightGreen, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            const InfoTip(
              icon: Icons.info_outline,
              text: 'Farmer\'s Tip\nDry coconut under full sunlight for 2 extra days for premium prices!',
              color: Color(0xFFE3F2FD),
              iconColor: Colors.blue,
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Learning how to improve crop quality... (Mock)')),
                );
              },
              icon: const Icon(Icons.book),
              label: const Text('Learn How to Improve Crop Quality'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCropQualityItem(BuildContext context, {required String crop, required int score, required String status, required String suggestion, required Color statusColor}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(_getCropIcon(crop), color: Colors.lightGreen.shade700, size: 24),
                const SizedBox(width: 8),
                Text(
                  crop,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.lightGreen.shade800,
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                status,
                style: TextStyle(
                  color: statusColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        LinearProgressIndicator(
          value: score / 100,
          backgroundColor: Colors.grey.shade200,
          valueColor: AlwaysStoppedAnimation<Color>(statusColor),
          minHeight: 8,
        ),
        const SizedBox(height: 5),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            '$score%',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey.shade700),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          suggestion,
          style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
        ),
        const SizedBox(height: 15), // Spacer for next item
      ],
    );
  }

  IconData _getCropIcon(String crop) {
    switch (crop.toLowerCase()) {
      case 'coconut':
        return Icons.grass; // Using a generic farm icon
      case 'paddy':
        return Icons.rice_bowl; // Represents grain
      case 'arecanut':
        return Icons.local_florist; // Represents a natural product
      default:
        return Icons.grain;
    }
  }

  Widget _buildPaymentDetailTile(BuildContext context, {required String label, required String value}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(color: Colors.grey.shade700, fontSize: 13),
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
