// lib/screens/chat_screen.dart

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  final String receiverId;
  final String receiverName;

  const ChatScreen({
    super.key,
    required this.receiverId,
    required this.receiverName,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final currentUser = FirebaseAuth.instance.currentUser;
  String _receiverName = '';
  late String _chatRoomId;

  @override
  void initState() {
    super.initState();
    _fetchReceiverName();
    _chatRoomId = _getChatRoomId(currentUser!.uid, widget.receiverId);
  }

  // Creates a unique, consistent chat room ID for any pair of users
  String _getChatRoomId(String userId1, String userId2) {
    if (userId1.hashCode <= userId2.hashCode) {
      return '$userId1\_$userId2';
    } else {
      return '$userId2\_$userId1';
    }
  }

  Future<void> _fetchReceiverName() async {
    final userDoc = await FirebaseFirestore.instance.collection('users').doc(widget.receiverId).get();
    if (userDoc.exists && mounted) {
      setState(() {
        _receiverName = userDoc.data()?['fullName'] ?? widget.receiverName;
      });
    }
  }

  void _sendMessage() async {
    if (_messageController.text.isNotEmpty && currentUser != null) {
      await FirebaseFirestore.instance
          .collection('chats')
          .doc(_chatRoomId)
          .collection('messages')
          .add({
        'senderId': currentUser!.uid,
        'receiverId': widget.receiverId,
        'message': _messageController.text,
        'timestamp': FieldValue.serverTimestamp(),
      });
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_receiverName),
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildMessageList(),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    if (currentUser == null) return const Center(child: Text("Please log in."));

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('chats')
          .doc(_chatRoomId)
          .collection('messages')
          .orderBy('timestamp', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text("No messages yet. Say hello!"));
        }

        return ListView.builder(
          reverse: true,
          padding: const EdgeInsets.all(8.0),
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            final doc = snapshot.data!.docs[index];
            final data = doc.data() as Map<String, dynamic>;
            final bool isMe = data['senderId'] == currentUser!.uid;

            return _buildMessageBubble(data, isMe);
          },
        );
      },
    );
  }

  Widget _buildMessageBubble(Map<String, dynamic> data, bool isMe) {
    final timestamp = data['timestamp'] as Timestamp?;
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isMe ? Colors.lightGreen.shade200 : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              data['message'] ?? '',
              style: const TextStyle(color: Colors.black87),
            ),
            const SizedBox(height: 4),
            Text(
              timestamp != null ? DateFormat.jm().format(timestamp.toDate()) : '',
              style: TextStyle(color: Colors.black54, fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: const InputDecoration(
                hintText: 'Type a message...',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (_) => _sendMessage(),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send, color: Colors.lightGreen),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }
}
