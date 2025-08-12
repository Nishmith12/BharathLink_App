// lib/screens/offers_screen.dart

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class OffersScreen extends StatelessWidget {
  const OffersScreen({super.key});

  // --- Function to handle accepting an offer ---
  Future<void> _acceptOffer(BuildContext context, DocumentSnapshot offerDoc) async {
    final offerData = offerDoc.data() as Map<String, dynamic>;
    final cropId = offerData['cropId'];
    final offerPrice = offerData['offerPrice'];
    final cropName = offerData['cropName'] // Assuming you add this when creating the offer
        ?? 'Unknown Crop';

    // 1. Update the offer status to "accepted"
    await offerDoc.reference.update({'status': 'accepted'});

    // 2. Create a payment record
    await FirebaseFirestore.instance.collection('payments').add({
      'userId': offerData['farmerId'],
      'cropName': cropName,
      'amount': offerPrice, // This should be the total amount, you might need to fetch quantity
      'transactionDate': FieldValue.serverTimestamp(),
      'status': 'completed',
    });

    // 3. Mark the crop as sold
    await FirebaseFirestore.instance.collection('crops').doc(cropId).update({
      'status': 'sold',
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Offer accepted and payment recorded!")),
    );
  }

  // --- Function to handle declining an offer ---
  Future<void> _declineOffer(BuildContext context, DocumentSnapshot offerDoc) async {
    await offerDoc.reference.update({'status': 'declined'});
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Offer has been declined.")),
    );
  }


  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      return const Scaffold(
        body: Center(child: Text("Please log in to see your offers.")),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Offers Received'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('offers')
            .where('farmerId', isEqualTo: currentUser.uid)
            .where('status', isEqualTo: 'pending') // Only show pending offers
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("You have no pending offers."));
          }
          if (snapshot.hasError) {
            return const Center(child: Text("Something went wrong!"));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final offerDoc = snapshot.data!.docs[index];
              final offerData = offerDoc.data() as Map<String, dynamic>;
              final timestamp = offerData['timestamp'] as Timestamp?;

              return FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance.collection('crops').doc(offerData['cropId']).get(),
                builder: (context, cropSnapshot) {
                  if (!cropSnapshot.hasData) {
                    return const Card(
                      margin: EdgeInsets.only(bottom: 16),
                      child: ListTile(title: Text("Loading crop details...")),
                    );
                  }
                  final cropData = cropSnapshot.data!.data() as Map<String, dynamic>;

                  return Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Offer for: ${cropData['cropName'] ?? 'N/A'}',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Offer Price: ₹${offerData['offerPrice']}/kg',
                            style: TextStyle(
                              color: Colors.green.shade800,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Received on: ${timestamp != null ? DateFormat.yMMMd().format(timestamp.toDate()) : ''}',
                            style: const TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                          const Divider(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () => _declineOffer(context, offerDoc),
                                child: const Text('Decline', style: TextStyle(color: Colors.red)),
                              ),
                              const SizedBox(width: 8),
                              ElevatedButton(
                                onPressed: () => _acceptOffer(context, offerDoc),
                                child: const Text('Accept'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
