// lib/screens/home_screen.dart

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'scan_crop_screen.dart';
import 'schedule_visit_screen.dart';
import 'sales_tracking_screen.dart';
import 'kyc_screen.dart';
import 'feedback_screen.dart';
import 'login_screen.dart';
import 'profile_screen.dart';
import 'tips_screen.dart';
import 'payments_screen.dart';
import 'sell_crop_screen.dart';
import 'search_results_screen.dart';
import 'market_prices_screen.dart';
import 'browse_crops_screen.dart';
import 'offers_screen.dart'; // Import the new screen

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to Bharath Link'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
            },
          ),
        ],
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

            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              children: [
                _HomeActionCard(
                  icon: Icons.store,
                  label: 'Browse Market',
                  iconColor: Colors.blue.shade700,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const BrowseCropsScreen()));
                  },
                ),
                // --- NEW CARD ADDED ---
                _HomeActionCard(
                  icon: Icons.inbox,
                  label: 'Offers Received',
                  iconColor: Colors.amber.shade800,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const OffersScreen()));
                  },
                ),
                _HomeActionCard(
                  icon: Icons.sell,
                  label: 'Sell Crop',
                  iconColor: Colors.red.shade400,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const SellCropScreen()));
                  },
                ),
                _HomeActionCard(
                  icon: Icons.stacked_line_chart,
                  label: 'Crop Status',
                  iconColor: Colors.purple.shade400,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const SalesTrackingScreen()));
                  },
                ),
                _HomeActionCard(
                  icon: Icons.bar_chart,
                  label: 'Market Prices',
                  iconColor: Colors.deepPurple.shade400,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const MarketPricesScreen()));
                  },
                ),
                _HomeActionCard(
                  icon: Icons.camera_alt,
                  label: 'Scan Crop',
                  iconColor: Colors.lightGreen,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const ScanCropScreen()));
                  },
                ),
                _HomeActionCard(
                  icon: Icons.calendar_today,
                  label: 'Schedule Visit',
                  iconColor: Colors.blue.shade400,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const ScheduleVisitScreen()));
                  },
                ),
                _HomeActionCard(
                  icon: Icons.lightbulb_outline,
                  label: 'Tips & Guidance',
                  iconColor: Colors.teal.shade400,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const TipsScreen()));
                  },
                ),
                _HomeActionCard(
                  icon: Icons.payments,
                  label: 'My Payments',
                  iconColor: Colors.orange.shade400,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const PaymentsScreen()));
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.lightGreen,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: const Icon(Icons.home, color: Colors.white),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.notifications, color: Colors.white),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Notifications (Feature Coming Soon)')),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.person, color: Colors.white),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileScreen()));
                },
              ),
            ],
          ),
        ),
      ),
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
