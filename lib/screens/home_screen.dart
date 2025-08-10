import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'scan_crop_screen.dart';
import 'schedule_visit_screen.dart';
import 'sales_tracking_screen.dart';
import 'sell_crop_flow_screen.dart';
import 'kyc_screen.dart';
import 'feedback_screen.dart';
import 'crop_report_screen.dart';
import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to Bharath Link'),
        automaticallyImplyLeading: false, // No back button on home
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
            // Search Bar
            TextField(
              decoration: InputDecoration(
                hintText: 'Search crop, service or help...',
                prefixIcon: Icon(Icons.search, color: Colors.grey.shade600),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey.shade200,
                contentPadding: const EdgeInsets.symmetric(vertical: 15.0),
              ),
            ),
            const SizedBox(height: 30),

            // Main Action Grid
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(), // Disable scrolling of grid
              crossAxisCount: 3,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              children: [
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
                  icon: Icons.currency_rupee,
                  label: 'My Payments',
                  iconColor: Colors.orange.shade400,
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('My Payments (Feature Coming Soon)')),
                    );
                  },
                ),
                _HomeActionCard(
                  icon: Icons.stacked_line_chart,
                  label: 'Crop Status',
                  iconColor: Colors.purple.shade400,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const SalesTrackingScreen())); // Re-using sales tracking for status
                  },
                ),
                _HomeActionCard(
                  icon: Icons.lightbulb_outline,
                  label: 'Tips & Guidance',
                  iconColor: Colors.teal.shade400,
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Tips & Guidance (Feature Coming Soon)')),
                    );
                  },
                ),
                _HomeActionCard(
                  icon: Icons.sell,
                  label: 'Sell Crop',
                  iconColor: Colors.red.shade400,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const SellCropFlowScreen()));
                  },
                ),
                _HomeActionCard(
                  icon: Icons.assignment,
                  label: 'KYC Form',
                  iconColor: Colors.brown.shade400,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => KycScreen()));
                  },
                ),
                _HomeActionCard(
                  icon: Icons.rate_review,
                  label: 'Feedback',
                  iconColor: Colors.indigo.shade400,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const FeedbackScreen()));
                  },
                ),
                _HomeActionCard(
                  icon: Icons.receipt_long,
                  label: 'Crop Report',
                  iconColor: Colors.cyan.shade400,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const CropReportScreen()));
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
                onPressed: () {
                  // Already on Home
                },
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
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Profile (Feature Coming Soon)')),
                  );
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
