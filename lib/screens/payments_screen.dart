import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class PaymentsScreen extends StatelessWidget {
  const PaymentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Payments'),
      ),
      body: user == null
          ? const Center(child: Text("Please log in to see your payment history."))
          : StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('payments')
            .where('userId', isEqualTo: user.uid)
            .orderBy('transactionDate', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("You have no payment history."));
          }
          if (snapshot.hasError) {
            return const Center(child: Text("Something went wrong!"));
          }

          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
              return Card(
                margin: const EdgeInsets.only(bottom: 16.0),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.lightGreen.shade100,
                    child: const Icon(Icons.currency_rupee, color: Colors.lightGreen),
                  ),
                  title: Text(
                    'Payment for ${data['cropName'] ?? 'N/A'}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    'Amount: ₹${data['amount'] ?? 0}',
                  ),
                  trailing: Text(
                    data['transactionDate'] == null
                        ? ''
                        : DateFormat.yMMMd().format((data['transactionDate'] as Timestamp).toDate()),
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
