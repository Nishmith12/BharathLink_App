// lib/screens/kyc_screen.dart

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
  // --- NEW CONTROLLERS ---
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  bool _isLoading = false;

  void _submitKyc() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    if (aadhaarController.text.isEmpty ||
        panController.text.isEmpty ||
        bankController.text.isEmpty ||
        ifscController.text.isEmpty ||
        addressController.text.isEmpty ||
        cityController.text.isEmpty ||
        stateController.text.isEmpty) {
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
        // --- NEW FIELDS TO SAVE ---
        'address': addressController.text,
        'city': cityController.text,
        'state': stateController.text,
        'kycSubmittedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("KYC details submitted successfully!")),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      // Handle error
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
                // ... existing fields for Aadhaar, PAN, etc. ...
                TextFormField(
                  controller: aadhaarController,
                  decoration: const InputDecoration(labelText: "Aadhaar Number"),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: panController,
                  decoration: const InputDecoration(labelText: "PAN Number"),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: bankController,
                  decoration: const InputDecoration(labelText: "Bank Account Number"),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: ifscController,
                  decoration: const InputDecoration(labelText: "IFSC Code"),
                ),
                const SizedBox(height: 20),
                // --- NEW FORM FIELDS ---
                TextFormField(
                  controller: addressController,
                  decoration: const InputDecoration(
                    labelText: "Street Address",
                    prefixIcon: Icon(Icons.home_work_outlined),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: cityController,
                  decoration: const InputDecoration(
                    labelText: "City / Town",
                    prefixIcon: Icon(Icons.location_city),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: stateController,
                  decoration: const InputDecoration(
                    labelText: "State",
                    prefixIcon: Icon(Icons.map_outlined),
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
