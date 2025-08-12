// lib/screens/sell_crop_screen.dart

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';

class SellCropScreen extends StatefulWidget {
  const SellCropScreen({super.key});

  @override
  State<SellCropScreen> createState() => _SellCropScreenState();
}

class _SellCropScreenState extends State<SellCropScreen> {
  final cropNameController = TextEditingController();
  final quantityController = TextEditingController();
  final priceController = TextEditingController();
  bool _isLoading = false;
  XFile? _image;
  Uint8List? _imageData; // To hold image data for display
  final picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        _image = pickedFile;
        _imageData = bytes; // Store the image data in memory
      });
    }
  }

  void _listCrop() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("You must be logged in to list a crop.")),
      );
      return;
    }

    if (cropNameController.text.isEmpty ||
        quantityController.text.isEmpty ||
        priceController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all crop details.")),
      );
      return;
    }

    if (_image == null || _imageData == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please add an image of the crop.")),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Use the image's name for a more reliable MIME type lookup
      String fileName = 'crop_listings/${user.uid}/${DateTime.now().millisecondsSinceEpoch}-${_image!.name}';
      Reference storageRef = FirebaseStorage.instance.ref().child(fileName);

      final metadata = SettableMetadata(
        contentType: lookupMimeType(_image!.name), // Use the original file name
      );

      UploadTask uploadTask = storageRef.putData(_imageData!, metadata);

      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();

      await FirebaseFirestore.instance.collection('crops').add({
        'ownerId': user.uid,
        'cropName': cropNameController.text,
        'quantity': int.tryParse(quantityController.text) ?? 0,
        'price': double.tryParse(priceController.text) ?? 0.0,
        'imageUrl': downloadUrl,
        'listedAt': FieldValue.serverTimestamp(),
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Crop listed successfully!")),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to list crop: $e")),
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
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: _imageData == null
                      ? Center(
                    child: TextButton.icon(
                      icon: const Icon(Icons.add_a_photo, color: Colors.lightGreen),
                      label: const Text(
                        'Add Crop Image',
                        style: TextStyle(color: Colors.lightGreen),
                      ),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext bc) {
                            return SafeArea(
                              child: Wrap(
                                children: <Widget>[
                                  ListTile(
                                    leading: const Icon(Icons.photo_library),
                                    title: const Text('Photo Library'),
                                    onTap: () {
                                      _pickImage(ImageSource.gallery);
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  ListTile(
                                    leading: const Icon(Icons.photo_camera),
                                    title: const Text('Camera'),
                                    onTap: () {
                                      _pickImage(ImageSource.camera);
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  )
                      : ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.memory(
                      _imageData!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton.icon(
                  onPressed: _listCrop,
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
