// lib/screens/splash_screen.dart

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_screen.dart';
import 'onboarding_screen.dart';
import '../services/notification_service.dart'; // Import the service

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    // --- Initialize notifications here ---
    await NotificationService().initNotifications(context);
    _checkAuthStatus();
  }

  _checkAuthStatus() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (mounted) {
        if (user == null) {
          Timer(const Duration(seconds: 2), () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const OnboardingScreen()),
            );
          });
        } else {
          Timer(const Duration(seconds: 2), () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen.shade50,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/bharath_link_logo.png',
              height: 120,
              width: 120,
              errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.link, size: 120, color: Colors.lightGreen),
            ),
            const SizedBox(height: 20),
            Text(
              'Bharath Link',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.lightGreen.shade800,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Connecting Indian Farmers to Direct\nMarkets with Fair Pricing',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 40),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.lightGreen),
            ),
          ],
        ),
      ),
    );
  }
}
