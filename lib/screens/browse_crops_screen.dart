// lib/screens/browse_crops_screen.dart

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'crop_report_screen.dart'; // To view details

class BrowseCropsScreen extends StatelessWidget {
  const BrowseCropsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Browse Crop Market'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        // Query to get all crops, ordered by the newest first
        stream: FirebaseFirestore.instance
            .collection('crops')
            .orderBy('listedAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No crops are listed for sale right now."));
          }
          if (snapshot.hasError) {
            return const Center(child: Text("Something went wrong!"));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot document = snapshot.data!.docs[index];
              Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
              final imageUrl = data['imageUrl'] as String?;

              return Card(
                margin: const EdgeInsets.only(bottom: 16.0),
                clipBehavior: Clip.antiAlias, // Ensures the image respects the card's rounded corners
                child: InkWell(
                  onTap: () {
                    // Navigate to the same crop report screen for details
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CropReportScreen(cropId: document.id),
                      ),
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // --- Crop Image ---
                      if (imageUrl != null)
                        Image.network(
                          imageUrl,
                          height: 180,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => const SizedBox(
                            height: 180,
                            child: Center(child: Icon(Icons.error, color: Colors.red)),
                          ),
                        )
                      else
                        Container(
                          height: 180,
                          color: Colors.grey.shade200,
                          child: const Center(child: Icon(Icons.image_not_supported, size: 50, color: Colors.grey)),
                        ),

                      // --- Crop Details ---
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data['cropName'] ?? 'N/A',
                              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Price: ₹${data['price'] ?? 0}/kg',
                                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                      color: Colors.lightGreen.shade700,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                Text(
                                  '${data['quantity'] ?? 0} kg available',
                                  style: TextStyle(color: Colors.grey.shade700),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
