import 'package:flutter/material.dart';
import 'dart:async';
import 'home_screen.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  // Mock authentication check
  Future<bool> _isAuthenticated() async {
    // Simulate network delay or checking local storage for a token
    await Future.delayed(const Duration(seconds: 2));
    // For now, always return false to force login/onboarding flow
    // In a real app, this would be based on actual authentication state
    return false;
  }

  _checkAuthStatus() async {
    bool authenticated = await _isAuthenticated();
    if (mounted) {
      if (authenticated) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else {
        // If not authenticated, first show onboarding, then login
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const OnboardingScreen()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen.shade50,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Assuming you have a logo in assets/images/bharath_link_logo.png
            Image.asset(
              'assets/images/bharath_link_logo.png', // Replace with your logo path
              height: 120,
              width: 120,
              errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.link, size: 120, color: Colors.lightGreen), // Fallback icon
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
