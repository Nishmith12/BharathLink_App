// lib/widgets/app_drawer.dart

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../screens/login_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/market_prices_screen.dart';
import '../screens/browse_crops_screen.dart';
import '../screens/offers_screen.dart';
import '../screens/sales_tracking_screen.dart';
import '../screens/visit_requests_screen.dart';
import '../screens/view_feedback_screen.dart';
import '../screens/tips_screen.dart';
import '../screens/kyc_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: const Text("Farmer Name"), // Placeholder
            accountEmail: Text(currentUser?.email ?? "No email"),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, size: 50),
            ),
            decoration: const BoxDecoration(
              color: Colors.lightGreen,
            ),
          ),
          _createDrawerItem(
            icon: Icons.person_outline,
            text: 'My Profile',
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileScreen())),
          ),
          _createDrawerItem(
            icon: Icons.store_outlined,
            text: 'Browse Market',
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const BrowseCropsScreen())),
          ),
          _createDrawerItem(
            icon: Icons.bar_chart_outlined,
            text: 'Market Prices',
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const MarketPricesScreen())),
          ),
          const Divider(),
          _createDrawerItem(
            icon: Icons.inbox_outlined,
            text: 'Offers Received',
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const OffersScreen())),
          ),
          _createDrawerItem(
            icon: Icons.stacked_line_chart_outlined,
            text: 'Crop Status',
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SalesTrackingScreen())),
          ),
          _createDrawerItem(
            icon: Icons.calendar_today_outlined,
            text: 'Visit Requests',
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const VisitRequestsScreen())),
          ),
          const Divider(),
          _createDrawerItem(
            icon: Icons.lightbulb_outline,
            text: 'Tips & Guidance',
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TipsScreen())),
          ),
          _createDrawerItem(
            icon: Icons.assignment_outlined,
            text: 'KYC Form',
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const KycScreen())),
          ),
          _createDrawerItem(
            icon: Icons.rate_review_outlined,
            text: 'View Feedback',
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ViewFeedbackScreen())),
          ),
          const Divider(),
          _createDrawerItem(
            icon: Icons.logout,
            text: 'Logout',
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                    (Route<dynamic> route) => false,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _createDrawerItem({required IconData icon, required String text, required GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(text),
          )
        ],
      ),
      onTap: onTap,
    );
  }
}
