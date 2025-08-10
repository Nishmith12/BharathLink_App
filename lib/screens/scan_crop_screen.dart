import 'package:flutter/material.dart';
import 'dart:async';
import '../widgets/info_tip.dart';

class ScanCropScreen extends StatelessWidget {
  const ScanCropScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Your Crop'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Expanded(
              child: Card(
                color: Colors.lightGreen.shade50,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.camera_alt,
                        size: 80,
                        color: Colors.lightGreen.shade300,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Point camera at your crop',
                        style: TextStyle(
                          color: Colors.lightGreen.shade600,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Scanning Crop... (Mock)')),
                );
                // In a real app, this would trigger camera and process the result.
                // For now, just show a confirmation.
                Future.delayed(const Duration(seconds: 2), () {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Scan complete! View the report in "Crop Status".')),
                    );
                    Navigator.pop(context);
                  }
                });
              },
              child: const Text('SCAN NOW'),
            ),
            const SizedBox(height: 10),
            Text(
              'Ensure good lighting for better results.',
              style: TextStyle(color: Colors.grey.shade600),
            ),
            const SizedBox(height: 20),
            const InfoTip(
              icon: Icons.lightbulb_outline,
              text: 'Tip: Hold your camera steady for better quality checking.',
              color: Color(0xFFFFF9C4),
              iconColor: Colors.orange,
            ),
          ],
        ),
      ),
    );
  }
}
