import 'package:flutter/material.dart';

class KycScreen extends StatelessWidget {
  final aadhaarController = TextEditingController();
  final panController = TextEditingController();
  final bankController = TextEditingController();
  final ifscController = TextEditingController();

  KycScreen({super.key});

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
                ElevatedButton.icon(
                  onPressed: () {
                    if (aadhaarController.text.isEmpty ||
                        panController.text.isEmpty ||
                        bankController.text.isEmpty ||
                        ifscController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Please fill all KYC details.")),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("KYC Submitted (Mock): Aadhaar: ${aadhaarController.text}")),
                      );
                      Navigator.pop(context);
                    }
                  },
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
