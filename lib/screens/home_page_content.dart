import 'package:flutter/material.dart';

class HomePageContent extends StatefulWidget {
  const HomePageContent({super.key});

  @override
  State<HomePageContent> createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Using a Stack to combine background image, gradient overlay, and content
      body: Stack(
        children: [
          // Background Image (ensure the image is added in your assets)
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/welcome_bg.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Gradient overlay with 70% opacity using hex values (alpha = B3)
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xB3F0F8F3), // top color with 70% opacity
                  Color(0xB3E97A7A), // bottom color with 70% opacity
                ],
              ),
            ),
          ),
          // Main content on top of the background
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ======================
                    // HEADER
                    // ======================
                    Container(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Replace with your actual logo asset
                          Image.asset(
                            'assets/images/appbar_logo.png',
                            width: 65,
                            height: 60,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            'SmartCampus',
                            style: TextStyle(
                              // Figma: 24px, Bold
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    // ======================
                    // SHUTTLE SERVICES
                    // ======================
                    sectionTitle('Shuttle Services'),
                    buildCustomCard(
                      title: 'Schedule',
                      subtitle: 'Book your shuttle 3hrs prior and go hustle free',
                      pngAsset: 'assets/images/stevens_logo.png',
                    ),
                    buildCustomCard(
                      title: 'Book Now',
                      subtitle: 'Instant shuttle booking',
                      pngAsset: 'assets/images/stevens_logo.png',
                    ),
                    const SizedBox(height: 24),
                    // ======================
                    // CAMPUS NAVIGATION
                    // ======================
                    sectionTitle('Campus Navigation'),
                    buildCustomCard(
                      title: 'Find a classroom',
                      subtitle: 'Navigate inside the campus',
                      pngAsset: 'assets/images/classroom_home.png',
                    ),
                    buildCustomCard(
                      title: 'Navigate',
                      subtitle: 'Roam around the campus',
                      pngAsset: 'assets/images/navigate_home.png',
                    ),
                    const SizedBox(height: 24),
                    // ======================
                    // CUSTOMER SERVICE CARD
                    // ======================
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF0F8F3),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black, width: 1),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x1A000000), // ~10% opacity black
                              offset: Offset(0, 2),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xFFD9D9D9),
                                  ),
                                  child: const Icon(
                                    Icons.support_agent,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                const Text(
                                  'Customer Service for Shuttles:',
                                  style: TextStyle(
                                    // Figma: 14px, Bold
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            const Padding(
                              padding: EdgeInsets.only(left: 12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ServiceContactLine('201.474.3376'),
                                  SizedBox(height: 4),
                                  ServiceContactLine(
                                      'support-stevens@ridewithvia.com'),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ======================
  // SECTION TITLE
  // ======================
  Widget sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        text,
        style: const TextStyle(
          // Figma: 24px, Bold
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  // ======================
  // CUSTOM CARD (Dynamic Height)
  // ======================
  Widget buildCustomCard({
    required String title,
    required String subtitle,
    IconData? icon,
    String? pngAsset,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF0F8F3),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black, width: 1),
          boxShadow: const [
            BoxShadow(
              color: Color(0x1A000000), // ~10% opacity black
              offset: Offset(0, 2),
              blurRadius: 4,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          child: Row(
            children: [
              // Title & Subtitle
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        // Figma: 20px, Bold
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        // Figma: 14px, Normal
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              // Trailing image: Use PNG instead of SVG
              if (pngAsset != null)
                SizedBox(
                  width: 40,
                  height: 40,
                  child: Image.asset(
                    pngAsset,
                    fit: BoxFit.contain,
                  ),
                )
              else if (icon != null)
                Icon(icon),
            ],
          ),
        ),
      ),
    );
  }
}

// ======================
// SERVICE CONTACT LINE
// ======================
class ServiceContactLine extends StatelessWidget {
  final String text;
  const ServiceContactLine(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.circle, size: 6),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(
            // Figma: 14px, Normal
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}