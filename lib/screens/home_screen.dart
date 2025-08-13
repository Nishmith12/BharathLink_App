// lib/screens/home_screen.dart

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/app_drawer.dart'; // Import the new drawer
import 'scan_crop_screen.dart';
import 'sell_crop_screen.dart';
import 'search_results_screen.dart';
import 'browse_crops_screen.dart';
import 'offers_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The drawer property adds the hamburger menu icon automatically
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search for a crop...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey.shade200,
              ),
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SearchResultsScreen(searchQuery: value),
                    ),
                  );
                }
              },
            ),
            const SizedBox(height: 30),

            _buildDashboard(context),
            const SizedBox(height: 30),

            // --- SIMPLIFIED Grid for primary actions ---
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2, // Reduced to 2 columns for a cleaner look
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              childAspectRatio: 1.2, // Adjust aspect ratio for larger cards
              children: [
                _HomeActionCard(
                  icon: Icons.sell,
                  label: 'Sell a Crop',
                  iconColor: Colors.red.shade400,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const SellCropScreen()));
                  },
                ),
                _HomeActionCard(
                  icon: Icons.store,
                  label: 'Browse Market',
                  iconColor: Colors.blue.shade700,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const BrowseCropsScreen()));
                  },
                ),
                _HomeActionCard(
                  icon: Icons.inbox,
                  label: 'My Offers',
                  iconColor: Colors.amber.shade800,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const OffersScreen()));
                  },
                ),
                _HomeActionCard(
                  icon: Icons.camera_alt,
                  label: 'Scan a Crop',
                  iconColor: Colors.lightGreen,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const ScanCropScreen()));
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboard(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return const SizedBox.shrink();

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "My Farm Status",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const Divider(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildDashboardItem(
                  context,
                  stream: FirebaseFirestore.instance
                      .collection('crops')
                      .where('ownerId', isEqualTo: currentUser.uid)
                      .where('status', isNotEqualTo: 'sold')
                      .snapshots(),
                  icon: Icons.list_alt,
                  label: "Active Listings",
                  color: Colors.blue,
                ),
                _buildDashboardItem(
                  context,
                  stream: FirebaseFirestore.instance
                      .collection('offers')
                      .where('farmerId', isEqualTo: currentUser.uid)
                      .where('status', isEqualTo: 'pending')
                      .snapshots(),
                  icon: Icons.inbox,
                  label: "Pending Offers",
                  color: Colors.orange,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardItem(
      BuildContext context, {
        required Stream<QuerySnapshot> stream,
        required IconData icon,
        required String label,
        required Color color,
      }) {
    return StreamBuilder<QuerySnapshot>(
      stream: stream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }
        final count = snapshot.data!.docs.length;
        return Column(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: color,
              child: Icon(icon, color: Colors.white, size: 28),
            ),
            const SizedBox(height: 8),
            Text(
              count.toString(),
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              label,
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ],
        );
      },
    );
  }
}

class _HomeActionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color iconColor;
  final VoidCallback onTap;

  const _HomeActionCard({
    required this.icon,
    required this.label,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: iconColor.withOpacity(0.1),
              child: Icon(icon, size: 30, color: iconColor),
            ),
            const SizedBox(height: 10),
            Text(
              label,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
