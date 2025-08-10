import 'package:flutter/material.dart';
import 'scan_crop_screen.dart';
import 'schedule_visit_screen.dart';
import 'crop_report_screen.dart';
import '../widgets/section_header.dart';

class SellCropFlowScreen extends StatelessWidget {
  const SellCropFlowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sell Your Crops Directly'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Fast, Fair & Transparent Crop Selling',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.lightGreen.shade800,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 25),

            // Scan Your Crop Card
            _SellCropFlowCard(
              icon: Icons.camera_alt,
              iconColor: Colors.lightGreen,
              title: 'Scan Your Crop',
              description: 'Point your camera at the crop for quick assessment',
              buttonText: 'Scan Now',
              onButtonPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const ScanCropScreen()));
              },
            ),
            const SizedBox(height: 20),

            // Schedule a Visit Card
            _SellCropFlowCard(
              icon: Icons.calendar_month,
              iconColor: Colors.brown.shade700,
              title: 'Schedule a Visit for Quality Assessment',
              description: 'Choose visit date for physical verification',
              buttonText: 'Choose Visit Date',
              buttonColor: Colors.brown.shade700,
              onButtonPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const ScheduleVisitScreen()));
              },
            ),
            const SizedBox(height: 20),

            // Instant Payment Card
            _SellCropFlowCard(
              icon: Icons.currency_rupee,
              iconColor: Colors.lightGreen,
              title: 'Instant Payment',
              description: 'Receive immediate payment upon sale confirmation',
              buttonText: 'Learn More',
              onButtonPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Instant Payment details (Feature Coming Soon)')),
                );
              },
            ),
            const SizedBox(height: 30),

            // Track Your Crop Sale Status
            const SectionHeader(icon: Icons.track_changes, title: 'Track Your Crop Sale Status'),
            const SizedBox(height: 15),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        _ProgressBarStep(step: 1, label: '1', isActive: true),
                        Expanded(child: Divider(color: Colors.lightGreen, thickness: 2)),
                        _ProgressBarStep(step: 2, label: '2', isActive: false),
                        Expanded(child: Divider(color: Colors.grey, thickness: 2)),
                        _ProgressBarStep(step: 3, label: '3', isActive: false),
                        Expanded(child: Divider(color: Colors.grey, thickness: 2)),
                        _ProgressBarStep(step: 4, label: '4', isActive: false),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Step 1: Crop Scanned - Pending Assessment',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.lightGreen.shade800,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Quality Report Link
            _SellCropFlowCard(
              icon: Icons.assignment_turned_in,
              iconColor: Colors.lightGreen,
              title: 'Quality Report',
              description: 'See detailed crop quality metrics',
              buttonText: 'View Report',
              onButtonPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const CropReportScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _SellCropFlowCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String description;
  final String buttonText;
  final Color? buttonColor;
  final VoidCallback onButtonPressed;

  const _SellCropFlowCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.description,
    required this.buttonText,
    this.buttonColor,
    required this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: iconColor.withOpacity(0.1),
                  child: Icon(icon, size: 30, color: iconColor),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.lightGreen.shade800,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        description,
                        style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                onPressed: onButtonPressed,
                child: Text(buttonText),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProgressBarStep extends StatelessWidget {
  final int step;
  final String label;
  final bool isActive;

  const _ProgressBarStep({
    required this.step,
    required this.label,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 15,
          backgroundColor: isActive ? Colors.lightGreen : Colors.grey.shade400,
          child: Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          'Step $step',
          style: TextStyle(
            fontSize: 10,
            color: isActive ? Colors.lightGreen : Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}
