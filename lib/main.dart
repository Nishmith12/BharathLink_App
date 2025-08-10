import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:bharathlink_full_demo/screens/splash_screen.dart';
=======
import 'package:intl/intl.dart'; // For date formatting
import 'dart:async'; // For Future.delayed
>>>>>>> origin/main

void main() {
  runApp(const BharathLinkApp());
}

class BharathLinkApp extends StatelessWidget {
  const BharathLinkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BharathLink Demo',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen, // A pleasant primary color
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.lightGreen,
          foregroundColor: Colors.white,
          centerTitle: true,
          elevation: 4,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.lightGreen,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.lightGreen),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.lightGreen, width: 2),
          ),
          labelStyle: const TextStyle(color: Colors.lightGreen),
          floatingLabelStyle: const TextStyle(color: Colors.lightGreen),
        ),
        cardTheme: const CardThemeData( // Using CardThemeData
          elevation: 8,
          shape: RoundedRectangleBorder(
<<<<<<< HEAD
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
        ),
      ),
      home: const SplashScreen(), // Start with the Splash Screen
    );
  }
}
=======
            borderRadius: const BorderRadius.all(Radius.circular(15.0)), // Const constructor fix
          ),
        ),
      ),
      home: SplashScreen(), // Start with the Splash Screen
    );
  }
}

// --- SPLASH SCREEN (UPDATED FOR AUTH) ---
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
                  Icon(Icons.link, size: 120, color: Colors.lightGreen), // Fallback icon
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

// --- ONBOARDING SCREEN (UPDATED NAVIGATION) ---
class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/farm_bg.jpg', // Replace with your farm background image
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(color: Colors.lightGreen.shade100), // Fallback color
            ),
          ),
          // Gradient Overlay
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.3),
                    Colors.black.withOpacity(0.6),
                  ],
                ),
              ),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(height: 50), // For top spacing
                Column(
                  children: [
                    Text(
                      'Bharath Link',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Farm to market, no broker to picket.',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white70,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Column(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange, // Distinct color for action button
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        // After onboarding, navigate to Login Screen
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginScreen()));
                      },
                      child: const Text('EXPLORE NOW'),
                    ),
                    const SizedBox(height: 40),
                    // Quick Action Icons at the bottom
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildQuickActionIcon(Icons.camera_alt, 'Crop Scan'),
                        _buildQuickActionIcon(Icons.bar_chart, 'Market Prices'),
                        _buildQuickActionIcon(Icons.payments, 'Direct Pay'),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionIcon(IconData icon, String label) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.white.withOpacity(0.2),
          child: Icon(icon, size: 30, color: Colors.white),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
      ],
    );
  }
}

// --- LOGIN SCREEN (UPDATED) ---
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController(text: 'user@example.com');
  final TextEditingController _passwordController = TextEditingController(text: 'password123');
  bool _isLoading = false;

  void _login() async {
    setState(() {
      _isLoading = true;
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLoading = false;
    });

    if (_usernameController.text == 'user@example.com' && _passwordController.text == 'password123') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login Successful!')),
      );
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid username or password.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.link,
                size: 100,
                color: Colors.lightGreen,
              ),
              const SizedBox(height: 20),
              Text(
                'Welcome Back',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.lightGreen,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          labelText: 'Email / Username',
                          prefixIcon: Icon(Icons.person, color: Colors.lightGreen),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: Icon(Icons.lock, color: Colors.lightGreen),
                        ),
                      ),
                      const SizedBox(height: 30),
                      _isLoading
                          ? const CircularProgressIndicator(color: Colors.lightGreen)
                          : ElevatedButton(
                        onPressed: _login,
                        child: const Text('Login'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Forgot Password? (Feature Coming Soon)')),
                  );
                },
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(color: Colors.lightGreen, fontSize: 16),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => SignUpScreen()));
                    },
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// --- SIGN UP SCREEN (NEW) ---
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _isLoading = false;

  void _signUp() async {
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match!')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLoading = false;
    });

    // Mock successful signup
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Registration Successful! Please login.')),
    );
    Navigator.pop(context); // Go back to Login screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.person_add,
                size: 80,
                color: Colors.lightGreen,
              ),
              const SizedBox(height: 20),
              Text(
                'Create Your Account',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.lightGreen,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _fullNameController,
                        decoration: InputDecoration(
                          labelText: 'Full Name',
                          prefixIcon: Icon(Icons.person_outline, color: Colors.lightGreen),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          prefixIcon: Icon(Icons.email_outlined, color: Colors.lightGreen),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: Icon(Icons.lock_outline, color: Colors.lightGreen),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _confirmPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          prefixIcon: Icon(Icons.lock_reset, color: Colors.lightGreen),
                        ),
                      ),
                      const SizedBox(height: 30),
                      _isLoading
                          ? const CircularProgressIndicator(color: Colors.lightGreen)
                          : ElevatedButton(
                        onPressed: _signUp,
                        child: const Text('Sign Up'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context); // Go back to Login screen
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- NEW HOME SCREEN (PREVIOUSLY DASHBOARD) ---
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to Bharath Link'),
        automaticallyImplyLeading: false, // No back button on home
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
                _buildHomeActionCard(
                  context,
                  icon: Icons.camera_alt,
                  label: 'Scan Crop',
                  iconColor: Colors.lightGreen,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => ScanCropScreen()));
                  },
                ),
                _buildHomeActionCard(
                  context,
                  icon: Icons.calendar_today,
                  label: 'Schedule Visit',
                  iconColor: Colors.blue.shade400,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => ScheduleVisitScreen()));
                  },
                ),
                _buildHomeActionCard(
                  context,
                  icon: Icons.currency_rupee,
                  label: 'My Payments',
                  iconColor: Colors.orange.shade400,
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('My Payments (Feature Coming Soon)')),
                    );
                  },
                ),
                _buildHomeActionCard(
                  context,
                  icon: Icons.stacked_line_chart,
                  label: 'Crop Status',
                  iconColor: Colors.purple.shade400,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => SalesTrackingScreen())); // Re-using sales tracking for status
                  },
                ),
                _buildHomeActionCard(
                  context,
                  icon: Icons.lightbulb_outline,
                  label: 'Tips & Guidance',
                  iconColor: Colors.teal.shade400,
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Tips & Guidance (Feature Coming Soon)')),
                    );
                  },
                ),
                _buildHomeActionCard(
                  context,
                  icon: Icons.sell,
                  label: 'Sell Crop',
                  iconColor: Colors.red.shade400,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => SellCropFlowScreen()));
                  },
                ),
                _buildHomeActionCard(
                  context,
                  icon: Icons.assignment,
                  label: 'KYC Form',
                  iconColor: Colors.brown.shade400,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => KycScreen()));
                  },
                ),
                _buildHomeActionCard(
                  context,
                  icon: Icons.rate_review,
                  label: 'Feedback',
                  iconColor: Colors.indigo.shade400,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => FeedbackScreen()));
                  },
                ),
                _buildHomeActionCard(
                  context,
                  icon: Icons.receipt_long,
                  label: 'Crop Report',
                  iconColor: Colors.cyan.shade400,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => CropReportScreen()));
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
                icon: Icon(Icons.home, color: Colors.white),
                onPressed: () {
                  // Already on Home
                },
              ),
              IconButton(
                icon: Icon(Icons.notifications, color: Colors.white),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Notifications (Feature Coming Soon)')),
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.person, color: Colors.white),
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

  Widget _buildHomeActionCard(BuildContext context, {required IconData icon, required String label, required Color iconColor, required VoidCallback onTap}) {
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

// --- SELL CROP FLOW SCREEN ---
class SellCropFlowScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sell Your Crops Directly'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Fast, Fair & Transparent Crop Selling',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.lightGreen.shade800,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 25),

            // Scan Your Crop Card
            _buildSellCropFlowCard(
              context,
              icon: Icons.camera_alt,
              iconColor: Colors.lightGreen,
              title: 'Scan Your Crop',
              description: 'Point your camera at the crop for quick assessment',
              buttonText: 'Scan Now',
              onButtonPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => ScanCropScreen()));
              },
            ),
            const SizedBox(height: 20),

            // Schedule a Visit Card
            _buildSellCropFlowCard(
              context,
              icon: Icons.calendar_month,
              iconColor: Colors.brown.shade700,
              title: 'Schedule a Visit for Quality Assessment',
              description: 'Choose visit date for physical verification',
              buttonText: 'Choose Visit Date',
              buttonColor: Colors.brown.shade700,
              onButtonPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => ScheduleVisitScreen()));
              },
            ),
            const SizedBox(height: 20),

            // Instant Payment Card
            _buildSellCropFlowCard(
              context,
              icon: Icons.currency_rupee,
              iconColor: Colors.lightGreen,
              title: 'Instant Payment',
              description: 'Receive immediate payment upon sale confirmation',
              buttonText: 'Learn More',
              onButtonPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Instant Payment details (Feature Coming Soon)')),
                );
              },
            ),
            const SizedBox(height: 30),

            // Track Your Crop Sale Status
            _buildSectionHeader(icon: Icons.track_changes, title: 'Track Your Crop Sale Status'),
            const SizedBox(height: 15),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        _buildProgressBarStep(1, '1', true),
                        Expanded(child: Divider(color: Colors.lightGreen, thickness: 2)),
                        _buildProgressBarStep(2, '2', false),
                        Expanded(child: Divider(color: Colors.grey, thickness: 2)),
                        _buildProgressBarStep(3, '3', false),
                        Expanded(child: Divider(color: Colors.grey, thickness: 2)),
                        _buildProgressBarStep(4, '4', false),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Step 1: Crop Scanned - Pending Assessment',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.lightGreen.shade800,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Quality Report Link
            _buildSellCropFlowCard(
              context,
              icon: Icons.assignment_turned_in,
              iconColor: Colors.lightGreen,
              title: 'Quality Report',
              description: 'See detailed crop quality metrics',
              buttonText: 'View Report',
              onButtonPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => CropReportScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSellCropFlowCard(BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String title,
    required String description,
    required String buttonText,
    Color? buttonColor,
    required VoidCallback onButtonPressed,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: iconColor.withOpacity(0.1),
                  child: Icon(icon, size: 30, color: iconColor),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.lightGreen.shade800,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        description,
                        style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor ?? Theme.of(context).elevatedButtonTheme.style?.backgroundColor?.resolve({MaterialState.pressed}),
                  foregroundColor: Theme.of(context).elevatedButtonTheme.style?.foregroundColor?.resolve({MaterialState.pressed}),
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                onPressed: onButtonPressed,
                child: Text(buttonText),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressBarStep(int step, String label, bool isActive) {
    return Column(
      children: [
        CircleAvatar(
          radius: 15,
          backgroundColor: isActive ? Colors.lightGreen : Colors.grey.shade400,
          child: Text(
            label,
            style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          'Step $step',
          style: TextStyle(
            fontSize: 10,
            color: isActive ? Colors.lightGreen : Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}

// --- FEEDBACK SCREEN ---
class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  int _starRating = 0;
  bool _isGoodExperience = false;
  bool _isNeedsImprovement = false;
  final TextEditingController _commentsController = TextEditingController();
  final TextEditingController _suggestionsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rate Your Experience & Provide Feedback'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            _buildSectionHeader(icon: Icons.star_border, title: 'Rating the Purchase Experience'),
            const SizedBox(height: 15),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text(
                      'How was your crop sale experience today?',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.lightGreen.shade800,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        return IconButton(
                          icon: Icon(
                            index < _starRating ? Icons.star : Icons.star_border,
                            color: Colors.amber,
                            size: 35,
                          ),
                          onPressed: () {
                            setState(() {
                              _starRating = index + 1;
                            });
                          },
                        );
                      }),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildThumbButton(
                          icon: Icons.thumb_up,
                          label: 'Good',
                          isSelected: _isGoodExperience,
                          onTap: () {
                            setState(() {
                              _isGoodExperience = !_isGoodExperience;
                              if (_isGoodExperience) _isNeedsImprovement = false;
                            });
                          },
                        ),
                        _buildThumbButton(
                          icon: Icons.thumb_down,
                          label: 'Needs Improvement',
                          isSelected: _isNeedsImprovement,
                          onTap: () {
                            setState(() {
                              _isNeedsImprovement = !_isNeedsImprovement;
                              if (_isNeedsImprovement) _isGoodExperience = false;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),

            _buildSectionHeader(icon: Icons.comment, title: 'Share Your Comments'),
            const SizedBox(height: 15),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your feedback helps us improve! Let us know how we can serve you better.',
                      style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      controller: _commentsController,
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: 'Type your feedback here...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.mic, color: Colors.grey.shade600),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Voice input (Mock)')),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),

            _buildSectionHeader(icon: Icons.lightbulb_outline, title: 'Suggestion Box for Quality'),
            const SizedBox(height: 15),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'How do you think we can help you improve the quality of your crops next time? Any tips or tools needed?',
                      style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      controller: _suggestionsController,
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: 'Share your suggestions here...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Feedback Submitted (Mock)')),
                      );
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.send),
                    label: const Text('Submit Feedback'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightGreen,
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => ScheduleVisitScreen()));
                    },
                    icon: Icon(Icons.event_note),
                    label: const Text('Request Next Visit'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildInfoTip(
              icon: Icons.lightbulb_outline,
              text: 'Help us improve! Receive ₹100 on your next sale for submitting feedback!',
              color: Colors.yellow.shade100,
              iconColor: Colors.orange,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThumbButton({required IconData icon, required String label, required bool isSelected, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isSelected ? Colors.lightGreen.shade100 : Colors.grey.shade100,
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? Colors.lightGreen : Colors.grey.shade300,
                width: 2,
              ),
            ),
            child: Icon(
              icon,
              size: 30,
              color: isSelected ? Colors.lightGreen : Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.lightGreen : Colors.grey.shade700,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

// --- EXISTING SCREENS (with minor adjustments for navigation) ---

class KycScreen extends StatelessWidget {
  final aadhaarController = TextEditingController();
  final panController = TextEditingController();
  final bankController = TextEditingController();
  final ifscController = TextEditingController();

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
                  decoration: InputDecoration(
                    labelText: "Aadhaar Number",
                    hintText: "e.g., 1234 5678 9012",
                    prefixIcon: Icon(Icons.credit_card, color: Colors.lightGreen),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: panController,
                  textCapitalization: TextCapitalization.characters,
                  decoration: InputDecoration(
                    labelText: "PAN Number",
                    hintText: "e.g., ABCDE1234F",
                    prefixIcon: Icon(Icons.badge, color: Colors.lightGreen),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: bankController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Bank Account Number",
                    hintText: "e.g., 9876543210987",
                    prefixIcon: Icon(Icons.account_balance, color: Colors.lightGreen),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: ifscController,
                  textCapitalization: TextCapitalization.characters,
                  decoration: InputDecoration(
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
                  icon: Icon(Icons.check_circle_outline),
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

class SellCropScreen extends StatelessWidget {
  final cropNameController = TextEditingController();
  final quantityController = TextEditingController();
  final priceController = TextEditingController();

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
                  decoration: InputDecoration(
                    labelText: "Crop Name",
                    hintText: "e.g., Wheat, Rice, Corn",
                    prefixIcon: Icon(Icons.grain, color: Colors.lightGreen),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: quantityController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Quantity (kg)",
                    hintText: "e.g., 500, 1000",
                    prefixIcon: Icon(Icons.scale, color: Colors.lightGreen),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
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
                  icon: Icon(Icons.add_shopping_cart),
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

class ScanCropScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Your Crop'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Expanded(
              child: Card(
                color: Colors.lightGreen.shade50,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.camera_alt,
                        size: 80,
                        color: Colors.lightGreen.shade300,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Point camera at your crop',
                        style: TextStyle(
                          color: Colors.lightGreen.shade600,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Scanning Crop... (Mock)')),
                );
                // In a real app, this would trigger camera.
                // For now, let's navigate to a mock report screen after a delay.
                Future.delayed(const Duration(seconds: 2), () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => CropReportScreen()));
                });
              },
              child: const Text('SCAN NOW'),
            ),
            const SizedBox(height: 10),
            Text(
              'Ensure good lighting for better results.',
              style: TextStyle(color: Colors.grey.shade600),
            ),
            const SizedBox(height: 20),
            _buildInfoTip(
              icon: Icons.lightbulb_outline,
              text: 'Tip: Hold your camera steady for better quality checking.',
              color: Colors.yellow.shade100,
              iconColor: Colors.orange,
            ),
          ],
        ),
      ),
    );
  }
}

class ScheduleVisitScreen extends StatefulWidget {
  @override
  _ScheduleVisitScreenState createState() => _ScheduleVisitScreenState();
}

class _ScheduleVisitScreenState extends State<ScheduleVisitScreen> {
  DateTime _selectedDate = DateTime.now();
  String? _selectedTimeSlot;
  final TextEditingController _addressController = TextEditingController();

  final List<String> _timeSlots = [
    '9 AM - 10 AM',
    '10 AM - 11 AM',
    '11 AM - 12 PM',
    '1 PM - 2 PM',
    '2 PM - 3 PM',
    '3 PM - 4 PM',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Schedule Farm Visit'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Calendar Header (Mock)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(Icons.chevron_left, color: Colors.lightGreen),
                          onPressed: () {
                            setState(() {
                              _selectedDate = DateTime(_selectedDate.year, _selectedDate.month - 1, _selectedDate.day);
                            });
                          },
                        ),
                        Text(
                          DateFormat.yMMMM().format(_selectedDate),
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            color: Colors.lightGreen.shade800,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.chevron_right, color: Colors.lightGreen),
                          onPressed: () {
                            setState(() {
                              _selectedDate = DateTime(_selectedDate.year, _selectedDate.month + 1, _selectedDate.day);
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Days of the week header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']
                          .map((day) => Text(day, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey.shade700)))
                          .toList(),
                    ),
                    const SizedBox(height: 10),
                    // Calendar Grid (Simplified)
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 7,
                        childAspectRatio: 1.0,
                      ),
                      itemCount: DateTime(_selectedDate.year, _selectedDate.month + 1, 0).day + DateTime(_selectedDate.year, _selectedDate.month, 1).weekday % 7,
                      itemBuilder: (context, index) {
                        final firstDayOfMonth = DateTime(_selectedDate.year, _selectedDate.month, 1);
                        final dayOffset = firstDayOfMonth.weekday % 7; // 0 for Sunday, 1 for Monday
                        final day = index - dayOffset + 1;

                        if (day <= 0) {
                          return Container(); // Empty cells for days before the 1st
                        }

                        final currentDate = DateTime(_selectedDate.year, _selectedDate.month, day);
                        final isSelected = currentDate.day == _selectedDate.day &&
                            currentDate.month == _selectedDate.month &&
                            currentDate.year == _selectedDate.year;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedDate = currentDate;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: isSelected ? Colors.lightGreen : Colors.transparent,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: currentDate.isBefore(DateTime.now().subtract(const Duration(days: 1)))
                                    ? Colors.transparent
                                    : (isSelected ? Colors.lightGreen : Colors.grey.shade300),
                                width: 1,
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              '$day',
                              style: TextStyle(
                                color: isSelected
                                    ? Colors.white
                                    : (currentDate.isBefore(DateTime.now().subtract(const Duration(days: 1)))
                                    ? Colors.grey
                                    : Colors.black87),
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Select Time Slot',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.lightGreen.shade700,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: _selectedTimeSlot,
                    hint: Text('-- Select a time slot --', style: TextStyle(color: Colors.grey.shade600)),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedTimeSlot = newValue;
                      });
                    },
                    items: _timeSlots.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Enter your Farm Address',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.lightGreen.shade700,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextFormField(
                  controller: _addressController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: 'Enter address or pin your location',
                    border: InputBorder.none, // Remove default border
                    contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildInfoTip(
              icon: Icons.lightbulb_outline,
              text: 'Tip: Ensure someone is present at the farm during the visit for smooth quality checking!',
              color: Colors.yellow.shade100,
              iconColor: Colors.orange,
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () {
                if (_selectedDate == null || _selectedTimeSlot == null || _addressController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please select a date, time slot, and enter address.')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Visit Confirmed for ${DateFormat.yMMMd().format(_selectedDate)} at $_selectedTimeSlot')),
                  );
                  Navigator.pop(context);
                }
              },
              icon: Icon(Icons.event_available),
              label: const Text('Confirm Visit'),
            ),
          ],
        ),
      ),
    );
  }
}

class CropReportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Crop Quality Report & Payment Details'),
        toolbarHeight: 80, // Adjust height to fit longer title
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            _buildSectionHeader(
              icon: Icons.bar_chart,
              title: 'Crop Quality Summary',
            ),
            const SizedBox(height: 15),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    _buildCropQualityItem(
                      context,
                      crop: 'Coconut',
                      score: 92,
                      status: 'Excellent',
                      suggestion: 'Quality Score: 92% - Slightly high moisture detected. Suggest drying 2 extra days.',
                      statusColor: Colors.green,
                    ),
                    const Divider(),
                    _buildCropQualityItem(
                      context,
                      crop: 'Paddy',
                      score: 84,
                      status: 'Good',
                      suggestion: 'Quality Score: 84% - Good grain quality. Maintain current storage conditions.',
                      statusColor: Colors.orange,
                    ),
                    const Divider(),
                    _buildCropQualityItem(
                      context,
                      crop: 'Arecanut',
                      score: 78,
                      status: 'Needs Improvement',
                      suggestion: 'Quality Score: 78% - Some unripe nuts detected.',
                      statusColor: Colors.red,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            _buildSectionHeader(
              icon: Icons.bug_report,
              title: 'Defects Detected',
            ),
            const SizedBox(height: 15),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    _buildQualityNote(
                      icon: Icons.warning_amber,
                      title: 'Coconut Quality Note',
                      description: 'Slightly high moisture detected (12.5%). Suggest drying 2 extra days to reach optimal 10% moisture level for better pricing.',
                      color: Colors.lightGreen.shade50,
                      iconColor: Colors.lightGreen,
                    ),
                    const SizedBox(height: 15),
                    _buildQualityNote(
                      icon: Icons.warning_amber,
                      title: 'Arecanut Quality Note',
                      description: 'Some unripe nuts detected (15%). Suggest delayed harvest by 7-10 days for more uniform maturity and better market value.',
                      color: Colors.orange.shade50,
                      iconColor: Colors.orange,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            _buildSectionHeader(
              icon: Icons.payments,
              title: 'Payment Summary',
            ),
            const SizedBox(height: 15),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: _buildPaymentDetailTile(
                            context,
                            label: 'Amount',
                            value: '₹15,000',
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: _buildPaymentDetailTile(
                            context,
                            label: 'Date',
                            value: '2025-04-26',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: _buildPaymentDetailTile(
                            context,
                            label: 'Transaction ID',
                            value: '#BLink20250426',
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: _buildPaymentDetailTile(
                            context,
                            label: 'Payment Method',
                            value: 'UPI',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.lightGreen.shade50,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.check_circle_outline, color: Colors.lightGreen, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            'Payment Confirmed',
                            style: TextStyle(color: Colors.lightGreen, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            _buildInfoTip(
              icon: Icons.info_outline,
              text: 'Farmer\'s Tip\nDry coconut under full sunlight for 2 extra days for premium prices!',
              color: Colors.blue.shade50,
              iconColor: Colors.blue,
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Learning how to improve crop quality... (Mock)')),
                );
              },
              icon: Icon(Icons.book),
              label: const Text('Learn How to Improve Crop Quality'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCropQualityItem(BuildContext context, {required String crop, required int score, required String status, required String suggestion, required Color statusColor}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(_getCropIcon(crop), color: Colors.lightGreen.shade700, size: 24),
                const SizedBox(width: 8),
                Text(
                  crop,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.lightGreen.shade800,
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                status,
                style: TextStyle(
                  color: statusColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        LinearProgressIndicator(
          value: score / 100,
          backgroundColor: Colors.grey.shade200,
          valueColor: AlwaysStoppedAnimation<Color>(statusColor),
          minHeight: 8,
        ),
        const SizedBox(height: 5),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            '$score%',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey.shade700),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          suggestion,
          style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
        ),
        const SizedBox(height: 15), // Spacer for next item
      ],
    );
  }

  IconData _getCropIcon(String crop) {
    switch (crop.toLowerCase()) {
      case 'coconut':
        return Icons.grass; // Using a generic farm icon
      case 'paddy':
        return Icons.rice_bowl; // Represents grain
      case 'arecanut':
        return Icons.local_florist; // Represents a natural product
      default:
        return Icons.grain;
    }
  }

  Widget _buildPaymentDetailTile(BuildContext context, {required String label, required String value}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(color: Colors.grey.shade700, fontSize: 13),
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class SalesTrackingScreen extends StatefulWidget {
  @override
  _SalesTrackingScreenState createState() => _SalesTrackingScreenState();
}

class _SalesTrackingScreenState extends State<SalesTrackingScreen> {
  DateTime _currentMonth = DateTime.now();
  DateTime? _selectedSaleDate;

  // Mock data for sales
  final Map<DateTime, List<String>> _salesData = {
    DateTime(2025, 4, 27): ['₹8,000 for 300 kg Coconut'],
    DateTime(2025, 4, 28): ['₹12,000 for 500 kg Arecanut - 9AM-4PM'],
    DateTime(2025, 4, 30): ['₹5,000 for 200 kg Paddy'],
    DateTime(2025, 5, 5): ['₹10,000 for 400 kg Wheat'],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Track Your Next Crop Sale'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            _buildSectionHeader(
              icon: Icons.calendar_month,
              title: 'Upcoming Sale Schedule',
            ),
            const SizedBox(height: 15),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    // Calendar Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(Icons.chevron_left, color: Colors.lightGreen),
                          onPressed: () {
                            setState(() {
                              _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1, 1);
                            });
                          },
                        ),
                        Text(
                          DateFormat.yMMMM().format(_currentMonth),
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            color: Colors.lightGreen.shade800,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.chevron_right, color: Colors.lightGreen),
                          onPressed: () {
                            setState(() {
                              _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1, 1);
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Days of the week header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']
                          .map((day) => Text(day, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey.shade700)))
                          .toList(),
                    ),
                    const SizedBox(height: 10),
                    // Calendar Grid
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 7,
                        childAspectRatio: 1.0,
                      ),
                      itemCount: DateTime(_currentMonth.year, _currentMonth.month + 1, 0).day + DateTime(_currentMonth.year, _currentMonth.month, 1).weekday % 7,
                      itemBuilder: (context, index) {
                        final firstDayOfMonth = DateTime(_currentMonth.year, _currentMonth.month, 1);
                        final dayOffset = firstDayOfMonth.weekday % 7;
                        final day = index - dayOffset + 1;

                        if (day <= 0) {
                          return Container();
                        }

                        final currentDate = DateTime(_currentMonth.year, _currentMonth.month, day);
                        // Normalize dates for map lookup (remove time component)
                        final normalizedCurrentDate = DateTime(currentDate.year, currentDate.month, currentDate.day);
                        final hasSale = _salesData.keys.any((saleDate) =>
                        saleDate.year == normalizedCurrentDate.year &&
                            saleDate.month == normalizedCurrentDate.month &&
                            saleDate.day == normalizedCurrentDate.day);

                        final isSelected = _selectedSaleDate != null &&
                            currentDate.day == _selectedSaleDate!.day &&
                            currentDate.month == _selectedSaleDate!.month &&
                            currentDate.year == _selectedSaleDate!.year;


                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedSaleDate = hasSale ? normalizedCurrentDate : null;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: isSelected ? Colors.lightGreen : (hasSale ? Colors.lightGreen.shade100 : Colors.transparent),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: (isSelected || hasSale) ? Colors.lightGreen : Colors.grey.shade300,
                                width: isSelected ? 2 : 1,
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '$day',
                                  style: TextStyle(
                                    color: isSelected ? Colors.white : (hasSale ? Colors.lightGreen.shade800 : Colors.black87),
                                    fontWeight: isSelected || hasSale ? FontWeight.bold : FontWeight.normal,
                                  ),
                                ),
                                if (hasSale && !isSelected)
                                  Container(
                                    width: 5,
                                    height: 5,
                                    decoration: BoxDecoration(
                                      color: Colors.lightGreen.shade700,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    if (_selectedSaleDate != null && _salesData.containsKey(_selectedSaleDate!))
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Card(
                          color: Colors.lightGreen.shade50,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(color: Colors.lightGreen),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.lightGreen,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    DateFormat('dd\nMMM').format(_selectedSaleDate!),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const SizedBox(width: 15),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: _salesData[_selectedSaleDate!]!.map((saleDetail) =>
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 4.0),
                                          child: Text(
                                            saleDetail,
                                            style: TextStyle(color: Colors.lightGreen.shade800, fontSize: 16),
                                          ),
                                        )
                                    ).toList(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            _buildSectionHeader(
              icon: Icons.check_circle_outline,
              title: 'Crop Improvement Reminder',
            ),
            const SizedBox(height: 15),
            _buildQualityNote(
              icon: Icons.thumb_up_alt_outlined,
              title: 'Ensure proper drying for Arecanut before your next sale! Check quality suggestions for improvement.',
              description: '', // No separate description, title contains full text
              color: Colors.yellow.shade50,
              iconColor: Colors.orange,
              isTitleOnly: true,
            ),
            const SizedBox(height: 30),
            _buildSectionHeader(
              icon: Icons.warning_amber,
              title: 'Upcoming Crop Info & Suggested Improvements',
            ),
            const SizedBox(height: 15),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    _buildImprovementSuggestion(
                      context,
                      crop: 'Arecanut',
                      quantity: '500 kg',
                      suggestion: 'Ensure you harvest at the right time and dry properly for premium prices!',
                    ),
                    const Divider(),
                    _buildImprovementSuggestion(
                      context,
                      crop: 'Coconut',
                      quantity: '200 kg',
                      suggestion: 'Harvest when the water inside makes a sloshing sound for best quality.',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Scheduling a visit or scanning your crop... (Mock)')),
                );
                // Navigate to Scan Crop or Schedule Visit
              },
              icon: Icon(Icons.error_outline),
              label: const Text('Schedule a Visit or Scan Your Crop'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImprovementSuggestion(BuildContext context, {required String crop, required String quantity, required String suggestion}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.check_circle_outline, color: Colors.lightGreen),
              const SizedBox(width: 8),
              Text(
                '$crop ($quantity)',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.lightGreen.shade800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.only(left: 32.0),
            child: Text(
              suggestion,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}


// --- REUSABLE WIDGETS ---

Widget _buildSectionHeader({required IconData icon, required String title}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
    decoration: BoxDecoration(
      color: Colors.lightGreen,
      borderRadius: BorderRadius.circular(15),
    ),
    child: Row(
      children: [
        Icon(icon, color: Colors.white, size: 28),
        const SizedBox(width: 15),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildQualityNote({required IconData icon, required String title, required String description, required Color color, required Color iconColor, bool isTitleOnly = false}) {
  return Container(
    padding: const EdgeInsets.all(15),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: iconColor.withOpacity(0.5)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: iconColor, size: 24),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: iconColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              if (!isTitleOnly) ...[
                const SizedBox(height: 5),
                Text(
                  description,
                  style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
                ),
              ],
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildInfoTip({required IconData icon, required String text, required Color color, required Color iconColor}) {
  return Container(
    padding: const EdgeInsets.all(15),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: iconColor.withOpacity(0.5)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: iconColor, size: 24),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
          ),
        ),
      ],
    ),
  );
}
>>>>>>> origin/main
