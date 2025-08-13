// lib/screens/my_chats_screen.dart

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chat_screen.dart';

class MyChatsScreen extends StatelessWidget {
  const MyChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      return const Scaffold(
        body: Center(child: Text("Please log in to see your chats.")),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Chats'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        // --- CORRECTED QUERY ---
        // Firestore's 'array-contains' is the standard way to query for a value in an array.
        stream: FirebaseFirestore.instance
            .collection('chats')
            .where('participantIds', arrayContains: currentUser.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("You have no active chats."));
          }
          if (snapshot.hasError) {
            return const Center(child: Text("Something went wrong!"));
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final chatDoc = snapshot.data!.docs[index];
              final chatData = chatDoc.data() as Map<String, dynamic>;
              final participants = chatData['participants'] as Map<String, dynamic>;

              String otherUserId = '';
              String otherUserName = 'Chat User';

              // Find the other user's ID and name from the participants map
              participants.forEach((key, value) {
                if (key != currentUser.uid) {
                  otherUserId = key;
                  otherUserName = value['name'] ?? 'Chat User';
                }
              });

              if (otherUserId.isEmpty) {
                // Handle case where other user is not found, though this shouldn't happen
                return const SizedBox.shrink();
              }

              return ListTile(
                leading: const CircleAvatar(child: Icon(Icons.person)),
                title: Text(otherUserName),
                subtitle: const Text("Tap to view conversation"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChatScreen(
                        receiverId: otherUserId,
                        receiverName: otherUserName,
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
