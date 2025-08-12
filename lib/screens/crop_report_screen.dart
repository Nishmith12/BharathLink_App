// lib/screens/crop_report_screen.dart

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/section_header.dart';
import '../widgets/info_tip.dart';
import '../widgets/quality_note.dart'; // We'll reuse this widget

class CropReportScreen extends StatelessWidget {
  final String cropId;

  const CropReportScreen({super.key, required this.cropId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crop Report'),
      ),
      // Use a StreamBuilder to listen for real-time updates
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('crops').doc(cropId).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text("Crop not found."));
          }
          if (snapshot.hasError) {
            return const Center(child: Text("Something went wrong!"));
          }

          Map<String, dynamic> cropData = snapshot.data!.data()! as Map<String, dynamic>;
          final imageUrl = cropData['imageUrl'] as String?;
          final qualityAnalysis = cropData['qualityAnalysis'] as Map<String, dynamic>?;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (imageUrl != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image.network(
                      imageUrl,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const SizedBox(
                          height: 200,
                          child: Center(child: CircularProgressIndicator()),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return const SizedBox(
                          height: 200,
                          child: Center(child: Icon(Icons.error, color: Colors.red)),
                        );
                      },
                    ),
                  ),
                const SizedBox(height: 20),

                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          cropData['cropName'] ?? 'N/A',
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.lightGreen.shade800,
                          ),
                        ),
                        const SizedBox(height: 10),
                        _buildDetailRow(
                          icon: Icons.scale,
                          title: 'Quantity',
                          value: '${cropData['quantity'] ?? 0} kg',
                        ),
                        _buildDetailRow(
                          icon: Icons.currency_rupee,
                          title: 'Price',
                          value: '₹${cropData['price'] ?? 0.0}/kg',
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // --- DYNAMIC Quality Summary ---
                const SectionHeader(
                  icon: Icons.bar_chart,
                  title: 'Quality Summary',
                ),
                const SizedBox(height: 15),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    // Check if the analysis data exists
                    child: qualityAnalysis == null
                        ? const InfoTip(
                      icon: Icons.hourglass_empty,
                      text: 'Analyzing your crop... The report will be available here shortly.',
                      color: Color(0xFFFFF9C4),
                      iconColor: Colors.orange,
                    )
                        : _buildQualityReport(context, qualityAnalysis),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // A new widget to build the quality report from the analysis data
  Widget _buildQualityReport(BuildContext context, Map<String, dynamic> analysisData) {
    final int score = analysisData['score'] ?? 0;
    final String status = analysisData['status'] ?? 'N/A';
    final String defect = analysisData['defect'] ?? 'None';
    final String suggestion = analysisData['suggestion'] ?? 'No suggestions.';
    final statusColor = status == "Excellent" ? Colors.green : Colors.amber.shade700;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Overall Score',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              '$score%',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: statusColor,
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
        const Divider(height: 40),
        QualityNote(
          icon: Icons.warning_amber,
          title: 'Defects Detected',
          description: defect,
          color: Colors.orange.shade50,
          iconColor: Colors.orange,
        ),
        const SizedBox(height: 15),
        QualityNote(
          icon: Icons.lightbulb_outline,
          title: 'Our Suggestion',
          description: suggestion,
          color: Colors.lightGreen.shade50,
          iconColor: Colors.lightGreen,
        ),
      ],
    );
  }

  Widget _buildDetailRow({required IconData icon, required String title, required String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey.shade600, size: 20),
          const SizedBox(width: 16),
          Text(
            '$title: ',
            style: TextStyle(color: Colors.grey.shade700, fontSize: 16),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
