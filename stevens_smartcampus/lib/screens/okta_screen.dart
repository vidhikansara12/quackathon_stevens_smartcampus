import 'package:flutter/material.dart';

class OktaVerifyPage extends StatefulWidget {
  const OktaVerifyPage({super.key});

  @override
  State<OktaVerifyPage> createState() => _OktaVerifyPageState();
}

class _OktaVerifyPageState extends State<OktaVerifyPage> {
  final List<TextEditingController> _controllers =
      List.generate(6, (index) => TextEditingController());
  final List<FocusNode> _focusNodes =
      List.generate(6, (index) => FocusNode());

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _onCodeChanged(String value, int index) {
    if (value.length == 1 && index < 5) {
      _focusNodes[index + 1].requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Ensure the screen resizes when the keyboard appears.
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xFF000000),
      body: SafeArea(
        child: SingleChildScrollView(
          // Adding bottom padding so content is not hidden behind the keyboard
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom + 20),
          child: Column(
            children: [
              // Header with gradient and image
              Container(
                height: 320,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFFB00808),
                      Colors.red.shade900,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 16,
                      left: 16,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    Positioned(
                      top: 60,
                      left: 24,
                      child: const Text(
                        'Okta Verify',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Image.asset(
                            'assets/images/mail.png',
                            width: 160,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const Text(
                      'Please check your message for the verification code sent to you',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(6, (index) {
                        return SizedBox(
                          width: 45,
                          height: 60,
                          child: TextField(
                            controller: _controllers[index],
                            focusNode: _focusNodes[index],
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            maxLength: 1,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                            onChanged: (value) => _onCodeChanged(value, index),
                            decoration: InputDecoration(
                              counterText: '',
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Didn't receive a code? ",
                          style: TextStyle(color: Colors.white),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Handle resend code
                          },
                          child: const Text(
                            'Send again',
                            style: TextStyle(
                              color: Color(0xFF10C222),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/nav');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Continue',
                          style: TextStyle(
                            color: Color(0xFFB00808),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}