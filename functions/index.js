// functions/index.js

const {onObjectFinalized} = require("firebase-functions/v2/storage");
const {onDocumentCreated} = require("firebase-functions/v2/firestore"); // New import
const {logger} = require("firebase-functions");
const admin = require("firebase-admin");
const path = require("path");

// Keep your existing admin.initializeApp() at the top of the file.

// --- Keep your existing analyzeCropImage function here ---
exports.analyzeCropImage = onObjectFinalized({cpu: 1}, async (event) => {
    // ... (your existing code for this function)
});


// --- NEW: Function to send a notification for new chat messages ---
exports.sendChatNotification = onDocumentCreated("chats/{chatRoomId}/messages/{messageId}", async (event) => {
  const messageData = event.data.data();
  const receiverId = messageData.receiverId;
  const senderId = messageData.senderId;
  const messageText = messageData.message;

  // 1. Get the sender's name
  const senderDoc = await admin.firestore().collection("users").doc(senderId).get();
  const senderName = senderDoc.data()?.fullName ?? "Someone";

  // 2. Get the recipient's FCM token
  const receiverDoc = await admin.firestore().collection("users").doc(receiverId).get();
  const fcmToken = receiverDoc.data()?.fcmToken;

  if (!fcmToken) {
    logger.log(`No FCM token found for user ${receiverId}. Cannot send notification.`);
    return null;
  }

  // 3. Construct the notification message
  const payload = {
    notification: {
      title: `New message from ${senderName}`,
      body: messageText,
      click_action: "FLUTTER_NOTIFICATION_CLICK", // Important for Flutter
    },
    token: fcmToken,
  };

  // 4. Send the notification
  try {
    logger.log(`Sending notification to token: ${fcmToken}`);
    await admin.messaging().send(payload);
    logger.log("Notification sent successfully!");
  } catch (error) {
    logger.error("Error sending notification:", error);
  }

  return null;
});
