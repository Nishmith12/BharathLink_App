import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class KycScreen extends StatefulWidget {
  const KycScreen({super.key});

  @override
  State<KycScreen> createState() => _KycScreenState();
}

class _KycScreenState extends State<KycScreen> {
  final aadhaarController = TextEditingController();
  final panController = TextEditingController();
  final bankController = TextEditingController();
  final ifscController = TextEditingController();
  bool _isLoading = false;

  void _submitKyc() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("You must be logged in to submit KYC.")),
      );
      return;
    }

    if (aadhaarController.text.isEmpty ||
        panController.text.isEmpty ||
        bankController.text.isEmpty ||
        ifscController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all KYC details.")),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'aadhaar': aadhaarController.text,
        'pan': panController.text,
        'bankAccount': bankController.text,
        'ifsc': ifscController.text,
        'kycSubmittedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true)); // Use merge to avoid overwriting other user data

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("KYC details submitted successfully!")),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to submit KYC: $e")),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("KYC Details")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Enter your KYC information',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.lightGreen.shade800,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 25),
                TextFormField(
                  controller: aadhaarController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Aadhaar Number",
                    hintText: "e.g., 1234 5678 9012",
                    prefixIcon: Icon(Icons.credit_card, color: Colors.lightGreen),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: panController,
                  textCapitalization: TextCapitalization.characters,
                  decoration: const InputDecoration(
                    labelText: "PAN Number",
                    hintText: "e.g., ABCDE1234F",
                    prefixIcon: Icon(Icons.badge, color: Colors.lightGreen),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: bankController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Bank Account Number",
                    hintText: "e.g., 9876543210987",
                    prefixIcon: Icon(Icons.account_balance, color: Colors.lightGreen),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: ifscController,
                  textCapitalization: TextCapitalization.characters,
                  decoration: const InputDecoration(
                    labelText: "IFSC Code",
                    hintText: "e.g., SBIN0001234",
                    prefixIcon: Icon(Icons.code, color: Colors.lightGreen),
                  ),
                ),
                const SizedBox(height: 30),
                _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton.icon(
                  onPressed: _submitKyc,
                  icon: const Icon(Icons.check_circle_outline),
                  label: const Text("Submit KYC"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
