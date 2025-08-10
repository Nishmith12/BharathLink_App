import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
      ),
      body: user == null
          ? const Center(child: Text("Please log in to see your profile."))
          : FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('users').doc(user.uid).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text("No profile data found."));
          }
          if (snapshot.hasError) {
            return const Center(child: Text("Something went wrong!"));
          }

          Map<String, dynamic> data = snapshot.data!.data()! as Map<String, dynamic>;

          return ListView(
            padding: const EdgeInsets.all(24.0),
            children: [
              _buildProfileHeader(user),
              const SizedBox(height: 30),
              _buildKycDetails(data),
            ],
          );
        },
      ),
    );
  }

  Widget _buildProfileHeader(User user) {
    return Column(
      children: [
        const CircleAvatar(
          radius: 50,
          backgroundColor: Colors.lightGreen,
          child: Icon(Icons.person, size: 50, color: Colors.white),
        ),
        const SizedBox(height: 16),
        Text(
          user.email ?? 'No Email',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildKycDetails(Map<String, dynamic> data) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'KYC Information',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.lightGreen.shade800,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(height: 30),
            _buildDetailRow(icon: Icons.credit_card, title: 'Aadhaar Number', value: data['aadhaar'] ?? 'Not provided'),
            _buildDetailRow(icon: Icons.badge, title: 'PAN Number', value: data['pan'] ?? 'Not provided'),
            _buildDetailRow(icon: Icons.account_balance, title: 'Bank Account', value: data['bankAccount'] ?? 'Not provided'),
            _buildDetailRow(icon: Icons.code, title: 'IFSC Code', value: data['ifsc'] ?? 'Not provided'),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow({required IconData icon, required String title, required String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey.shade600),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(color: Colors.grey.shade700)),
              const SizedBox(height: 4),
              Text(value, style: Theme.of(context).textTheme.titleMedium),
            ],
          ),
        ],
      ),
    );
  }
}
