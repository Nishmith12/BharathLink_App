import 'package:flutter/material.dart';

class SellCropScreen extends StatelessWidget {
  final cropNameController = TextEditingController();
  final quantityController = TextEditingController();
  final priceController = TextEditingController();

  SellCropScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sell Crop")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'List your crop for sale',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.lightGreen.shade800,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 25),
                TextFormField(
                  controller: cropNameController,
                  decoration: const InputDecoration(
                    labelText: "Crop Name",
                    hintText: "e.g., Wheat, Rice, Corn",
                    prefixIcon: Icon(Icons.grain, color: Colors.lightGreen),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: quantityController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Quantity (kg)",
                    hintText: "e.g., 500, 1000",
                    prefixIcon: Icon(Icons.scale, color: Colors.lightGreen),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Price (₹/kg)",
                    hintText: "e.g., 25, 30.50",
                    prefixIcon: Icon(Icons.currency_rupee, color: Colors.lightGreen),
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton.icon(
                  onPressed: () {
                    if (cropNameController.text.isEmpty ||
                        quantityController.text.isEmpty ||
                        priceController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Please fill all crop details.")),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Crop Listed (Mock): ${cropNameController.text} - ${quantityController.text} kg")),
                      );
                      Navigator.pop(context);
                    }
                  },
                  icon: const Icon(Icons.add_shopping_cart),
                  label: const Text("List Crop"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
