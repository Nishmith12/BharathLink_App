// lib/services/notification_service.dart

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../screens/my_chats_screen.dart'; // To navigate to the chats screen

// --- NEW: Function to handle background messages ---
// This needs to be a top-level function (outside of any class)
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}


class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications(BuildContext context) async {
    await _firebaseMessaging.requestPermission();
    final fcmToken = await _firebaseMessaging.getToken();
    print("FCM Token: $fcmToken");

    _saveTokenToDatabase(fcmToken);
    _firebaseMessaging.onTokenRefresh.listen(_saveTokenToDatabase);

    // --- NEW: Set up notification listeners ---
    _setupInteractedMessage(context);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
        // You can show a local notification here if you want
      }
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  Future<void> _saveTokenToDatabase(String? token) async {
    if (token == null) return;

    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'fcmToken': token,
        'lastUpdated': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    }
  }

  // --- NEW: Handle notification taps ---
  Future<void> _setupInteractedMessage(BuildContext context) async {
    // Get any messages which caused the application to open from a terminated state.
    RemoteMessage? initialMessage = await _firebaseMessaging.getInitialMessage();

    if (initialMessage != null) {
      _handleMessage(context, initialMessage);
    }

    // Also handle any messages that arrive while the app is backgrounded and opened from the notification.
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _handleMessage(context, message);
    });
  }

  void _handleMessage(BuildContext context, RemoteMessage message) {
    // For now, we'll just navigate to the "My Chats" screen.
    // In a real app, you might navigate to the specific chat.
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const MyChatsScreen()),
    );
  }
}
