// lib/screens/browse_crops_screen.dart

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'crop_report_screen.dart';
import 'chat_screen.dart'; // Import the new chat screen

class BrowseCropsScreen extends StatelessWidget {
  const BrowseCropsScreen({super.key});

  // ... (keep the _showMakeOfferDialog function as it is)
  void _showMakeOfferDialog(BuildContext context, String cropId, String farmerId, String cropName) {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please log in to make an offer.")),
      );
      return;
    }
    if (currentUser.uid == farmerId) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("You cannot make an offer on your own crop.")),
      );
      return;
    }

    final offerController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Make an Offer for $cropName'),
          content: Form(
            key: formKey,
            child: TextFormField(
              controller: offerController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Your Price (₹/kg)',
                prefixIcon: Icon(Icons.currency_rupee),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a price';
                }
                if (double.tryParse(value) == null) {
                  return 'Please enter a valid number';
                }
                return null;
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Submit Offer'),
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  await FirebaseFirestore.instance.collection('offers').add({
                    'cropId': cropId,
                    'farmerId': farmerId,
                    'buyerId': currentUser.uid,
                    'offerPrice': double.parse(offerController.text),
                    'status': 'pending',
                    'timestamp': FieldValue.serverTimestamp(),
                  });

                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Offer submitted successfully!")),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Browse Crop Market'),
      ),
      body: StreamBuilder<QuerySnapshot>(
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
              final farmerId = data['ownerId'] as String;
              final cropName = data['cropName'] as String? ?? 'N/A';
              final listedAt = data['listedAt'] as Timestamp?;

              final bool isNew = listedAt != null && DateTime.now().difference(listedAt.toDate()).inHours < 24;

              return Card(
                margin: const EdgeInsets.only(bottom: 16.0),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => CropReportScreen(cropId: document.id),
                          ),
                        );
                      },
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (imageUrl != null)
                                Image.network(
                                  imageUrl,
                                  height: 180,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                )
                              else
                                Container(
                                  height: 180,
                                  color: Colors.grey.shade200,
                                  child: const Center(child: Icon(Icons.image_not_supported)),
                                ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      cropName,
                                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 8),
                                    FutureBuilder<DocumentSnapshot>(
                                      future: FirebaseFirestore.instance.collection('users').doc(farmerId).get(),
                                      builder: (context, userSnapshot) {
                                        if (!userSnapshot.hasData) {
                                          return const Text("Loading farmer info...");
                                        }
                                        final userData = userSnapshot.data!.data() as Map<String, dynamic>;
                                        final farmerName = userData['fullName'] ?? 'Anonymous Farmer';
                                        final city = userData['city'] ?? 'Unknown';
                                        final state = userData['state'] ?? 'Location';

                                        return Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Sold by: $farmerName',
                                              style: TextStyle(color: Colors.grey.shade700, fontStyle: FontStyle.italic),
                                            ),
                                            const SizedBox(height: 4),
                                            Row(
                                              children: [
                                                Icon(Icons.location_on, size: 16, color: Colors.grey.shade600),
                                                const SizedBox(width: 4),
                                                Text(
                                                  '$city, $state',
                                                  style: TextStyle(color: Colors.grey.shade700),
                                                ),
                                              ],
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                    const Divider(height: 20),
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
                          if (isNew)
                            Positioned(
                              top: 10,
                              left: 10,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: const Text('NEW', style: TextStyle(color: Colors.white)),
                              ),
                            ),
                        ],
                      ),
                    ),
                    // --- UPDATED ACTION BUTTONS ---
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              icon: const Icon(Icons.local_offer),
                              label: const Text('Make Offer'),
                              onPressed: () => _showMakeOfferDialog(context, document.id, farmerId, cropName),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange.shade700,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 12),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: ElevatedButton.icon(
                              icon: const Icon(Icons.chat_bubble_outline),
                              label: const Text('Contact'),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => ChatScreen(
                                      receiverId: farmerId,
                                      receiverName: 'Farmer', // We'll fetch the real name on the chat screen
                                    ),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.lightGreen,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 12),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
