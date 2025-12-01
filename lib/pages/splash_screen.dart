import 'package:flutter/material.dart';
//import 'package:traveler_app/utils/constants.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 238, 102, 92),
      // body: Stack(
      //   fit: StackFit.expand,
      //   children: [
      // Full-bleed background image
      // Image.asset(
      //   'assets/images/splashscreen/splash_screen.png',
      //   fit: BoxFit.cover,
      //   errorBuilder: (context, error, stack) => Container(
      //     color: Constants.lightTheme.scaffoldBackgroundColor,
      //     alignment: Alignment.center,
      //     child: const Text(
      //       'Traveler App',
      //       style: TextStyle(
      //         fontSize: 28,
      //         fontWeight: FontWeight.bold,
      //         fontFamily: 'Ubuntu-Regular',
      //       ),
      //     ),
      //   ),
      // ),

      // // Semi-transparent overlay for readability
      // Container(color: Colors.black.withOpacity(0.35)),

      // Center content
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.travel_explore, size: 50, fontWeight: FontWeight.bold),
              SizedBox(height: 20),
              const Text(
                'Traveler App',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Ubuntu-Regular',
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Discover. Share. Explore.',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                  fontFamily: 'Ubuntu-Regular',
                ),
              ),
              const SizedBox(height: 24),
              const SizedBox(
                width: 48,
                height: 4,
                child: LinearProgressIndicator(
                  backgroundColor: Colors.white24,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      //   ],
      // ),
    );
  }
}
