import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _keepSignedIn = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    final username = _usernameController.text.trim();
    final password = _passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter both username and password')),
      );
      return;
    }

    // Handle your actual login logic here.
    Navigator.pushNamed(context, '/verify', arguments: {'username': username});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          // 1) Background image
          Positioned.fill(
            child: Image.asset(
              'assets/images/login_bg.jpeg',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.black12,
                  child: const Center(
                    child: Icon(Icons.broken_image, size: 64, color: Colors.white70),
                  ),
                );
              },
            ),
          ),

          // 2) Red-to-white gradient overlay
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    // Adjust alpha (last parameter) to control how much the background shows
                    Color.fromRGBO(176, 8, 8, 0.7),   // nearly opaque red
                    Color.fromRGBO(255, 255, 255, 0.9), // nearly opaque white
                  ],
                ),
              ),
            ),
          ),

          // 3) Scrollable content to avoid bottom overflow
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back arrow
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(height: 10),

                  // Title
                  const Text(
                    'Log In',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Username
                  const Text(
                    'Username',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: TextField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        hintText: 'Username',
                        prefixIcon: Icon(Icons.email, color: Color(0xFF10C222)),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Password
                  const Text(
                    'Password',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: 'Password',
                        prefixIcon: Icon(Icons.lock, color: Color(0xFF10C222)),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // "Keep me signed in" checkbox
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        Checkbox(
                          value: _keepSignedIn,
                          onChanged: (value) {
                            setState(() {
                              _keepSignedIn = value ?? false;
                            });
                          },
                          activeColor: const Color(0xFF10C222),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Keep me signed in',
                          style: TextStyle(color: Colors.black87, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Login button
                  Center(
                    child: ElevatedButton(
                      onPressed: _handleLogin,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(354, 57),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text(
                        'Log In',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
