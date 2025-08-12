// lib/screens/visit_requests_screen.dart

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class VisitRequestsScreen extends StatelessWidget {
  const VisitRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scheduled Visits'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        // For a real app with many users, you'd filter this by farmerId.
        // For now, we'll show all visits for demonstration.
        stream: FirebaseFirestore.instance
            .collection('visits')
            .orderBy('visitDate', descending: false)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No visits have been scheduled yet."));
          }
          if (snapshot.hasError) {
            return const Center(child: Text("Something went wrong!"));
          }

          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
              final visitDate = data['visitDate'] as Timestamp?;

              return Card(
                margin: const EdgeInsets.only(bottom: 16.0),
                child: ListTile(
                  leading: const CircleAvatar(
                    child: Icon(Icons.calendar_today),
                  ),
                  title: Text(
                    'Visit on: ${visitDate != null ? DateFormat.yMMMMd().format(visitDate.toDate()) : 'N/A'}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Text('Time Slot: ${data['timeSlot'] ?? 'N/A'}'),
                      const SizedBox(height: 4),
                      Text('Address: ${data['address'] ?? 'N/A'}'),
                    ],
                  ),
                  isThreeLine: true,
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
