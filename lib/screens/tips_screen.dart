import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class TipsScreen extends StatelessWidget {
  const TipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Farming Tips & Guidance'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('tips')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No tips available right now."));
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
                    child: const Icon(Icons.lightbulb_outline, color: Colors.lightGreen),
                  ),
                  title: Text(
                    data['title'] ?? 'No Title', // Provide a default value if title is null
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(data['content'] ?? 'No Content'), // Provide a default value if content is null
                  ),
                  trailing: Text(
                    data['createdAt'] == null
                        ? ''
                        : DateFormat.yMMMd().format((data['createdAt'] as Timestamp).toDate()),
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
