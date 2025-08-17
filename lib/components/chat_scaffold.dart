import 'dart:async';
import 'package:flutter/material.dart';

/// ====== Figma-accurate tokens ======
class UI {
  // Inner card gradient
  static const gradTop = Color.fromRGBO(240, 248, 243, 1);   // #F0F8F3
  static const gradBottom = Color.fromRGBO(233, 122, 122, 1); // #E97A7A
  // 1px black borders everywhere
  static const border = Color.fromRGBO(0, 0, 0, 1);
  // Bubbles (white with black stroke)
  static const botBubble = Color.fromRGBO(255, 255, 255, 1);
  static const userBubble = Color.fromRGBO(255, 255, 255, 1);
  // Hint
  static const hint = Color(0xFF666666);
  // Outer frame tone (kept subtle)
  static const popupOuter = Color.fromARGB(255, 215, 129, 129);
}

/// Simple message model
class ChatMessage {
  final String text;
  final bool isUser; // true=user (right), false=bot (left)
  const ChatMessage(this.text, this.isUser);
}

class ChatScaffold extends StatefulWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final Color? backgroundColor;

  const ChatScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.backgroundColor,
  });

  @override
  State<ChatScaffold> createState() => _ChatScaffoldState();
}

class _ChatScaffoldState extends State<ChatScaffold> {
  bool _isChatOpen = false;
  bool _firstTimeOpened = true;

  double _buttonBottom = 30;
  double _buttonRight = 20;

  final List<ChatMessage> _messages = [];
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  // ----- helpers -----
  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _submitIfNotEmpty(String v) {
    final text = v.trim();
    if (text.isEmpty) return;
    _controller.clear();
    _sendToBot(text);
  }

  // ===== MOCK SEND (active now) =====
  Future<void> _sendToBot(String userText) async {
    setState(() => _messages.add(ChatMessage(userText, true)));
    _scrollToBottom();

    setState(() => _messages.add(const ChatMessage("...", false)));
    _scrollToBottom();

    await Future.delayed(const Duration(milliseconds: 800));

    setState(() {
      _messages.removeLast(); // remove typing
      _messages.add(ChatMessage("Echo from Stev-o-mate: $userText", false));
    });
    _scrollToBottom();
  }

  // ===== REAL INTEGRATION (uncomment & replace the mock above when backend is ready) =====
  // import 'dart:convert';
  // import 'package:http/http.dart' as http;
  // const String kChatApi = "http://10.0.2.2:8080/chat"; // or your deployed HTTPS URL
  //
  // Future<void> _sendToBot(String userText) async {
  //   setState(() => _messages.add(ChatMessage(userText, true)));
  //   _scrollToBottom();
  //   setState(() => _messages.add(const ChatMessage("...", false)));
  //   _scrollToBottom();
  //   try {
  //     final history = _messages
  //         .where((m) => m.text != "...")
  //         .map((m) => {"role": m.isUser ? "user" : "assistant", "content": m.text})
  //         .toList();
  //     final resp = await http.post(
  //       Uri.parse(kChatApi),
  //       headers: {"Content-Type": "application/json"},
  //       body: jsonEncode({"messages": history}),
  //     );
  //     if (resp.statusCode == 200) {
  //       final reply = (jsonDecode(resp.body)["reply"] ?? "").toString();
  //       setState(() {
  //         _messages.removeLast();
  //         _messages.add(ChatMessage(reply.isEmpty ? "Sorry, I didn’t catch that." : reply, false));
  //       });
  //     } else {
  //       setState(() {
  //         _messages.removeLast();
  //         _messages.add(ChatMessage("Server error: ${resp.statusCode}", false));
  //       });
  //     }
  //   } catch (e) {
  //     setState(() {
  //       _messages.removeLast();
  //       _messages.add(ChatMessage("Network error: $e", false));
  //     });
  //   }
  //   _scrollToBottom();
  // }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: widget.appBar,
      body: Stack(
        children: [
          Container(color: widget.backgroundColor, child: widget.body),

          // ===== Draggable chat FAB =====
          Positioned(
            bottom: _buttonBottom,
            right: _buttonRight,
            child: GestureDetector(
              onPanUpdate: (details) {
                setState(() {
                  _buttonBottom -= details.delta.dy;
                  _buttonRight -= details.delta.dx;

                  if (_buttonBottom < 10) _buttonBottom = 10;
                  if (_buttonRight < 10) _buttonRight = 10;

                  if (_buttonBottom > size.height - 80) {
                    _buttonBottom = size.height - 80;
                  }
                  if (_buttonRight > size.width - 60) {
                    _buttonRight = size.width - 60;
                  }
                });
              },
              child: FloatingActionButton(
                backgroundColor: const Color(0xFFE06767), // light red
                onPressed: () {
                  setState(() {
                    _isChatOpen = !_isChatOpen;
                    if (_isChatOpen && _firstTimeOpened) {
                      _messages.add(const ChatMessage(
                        "Hi, I'm Stev-o-mate!. How can I help you today?",
                        false,
                      ));
                      _firstTimeOpened = false;
                    }
                  });
                  _scrollToBottom();
                },
                child: const Icon(Icons.chat, color: Colors.black), // black icon
              ),
            ),
          ),

          // ===== Smart placement: compute popup size & position so it never cuts off =====
          if (_isChatOpen)
            Builder(
              builder: (context) {
                final screen = MediaQuery.of(context).size;
                final padTop = MediaQuery.of(context).padding.top;
                final padBottom = MediaQuery.of(context).padding.bottom;

                // Figma target size, then clamp to available space
                const double targetW = 398;
                const double targetH = 505;
                final double w = targetW.clamp(280.0, screen.width - 20);
                final double h = targetH.clamp(
                  360.0,
                  screen.height - (padTop + padBottom + 40),
                );

                // If button is too high, open popup below (so top stays visible)
                final bool openBelow = _buttonBottom < (h + 100);

                return Positioned(
                  bottom: openBelow ? null : (_buttonBottom + 70),
                  top: openBelow ? (padTop + 16) : null,
                  right: _buttonRight,
                  child: _buildChatPopup(context, width: w, height: h),

                );
              },
            ),
        ],
      ),
    );
  }

  /// ===== Popup exactly matching your Figma =====
  Widget _buildChatPopup(BuildContext context, {required double width, required double height}) {
    return Material(
      color: Colors.transparent,
      elevation: 8,
      child: SizedBox(
        width: width,
        height: height,
        child: Container(
          // Small outer margin (keeps a subtle outer frame feel)
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(74), // BIG rounded corners (Figma)
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [UI.gradTop, UI.gradBottom],
            ),
            border: Border.all(color: UI.border, width: 1), // 1px black
          ),
          clipBehavior: Clip.antiAlias, // clip inner content to the radius
          child: Column(
            children: [
              // Header row: avatar + title + close (transparent style)
                      Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 4),
          child: Row(
            children: [
              // Custom left asset instead of smart_toy icon
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration( // subtle transparent bg
                  borderRadius: BorderRadius.circular(50),
                ),
                alignment: Alignment.center,
                child: Image.asset(
                  "assets/images/stevo_logo.png", // <-- replace with your asset path
                  width: 20,
                  height: 20,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(width: 10),

              const Text(
                "SmartCampus",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),

              const Spacer(),

              // Black close button
              InkWell(
                onTap: () => setState(() => _isChatOpen = false),
                borderRadius: BorderRadius.circular(50),
                child: Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(// subtle background
                    borderRadius: BorderRadius.circular(50),
                  ),
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.close,
                    color: Colors.black, // <-- now black
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ),

              const SizedBox(height: 8),

              // Messages
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ListView.builder(
                    controller: _scrollController,
                    physics: const BouncingScrollPhysics(),
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      final m = _messages[index];
                      return _bubble(text: m.text, isUser: m.isUser);
                    },
                  ),
                ),
              ),

              // Quick chips
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                child: Wrap(
                  spacing: 12,
                  runSpacing: 8,
                  children: [
                    _chip("Campus guide"),
                    _chip("Ride to Campus"),
                  ],
                ),
              ),

              // Input + circular send
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(28),
                          border: Border.all(color: UI.border, width: 1),
                        ),
                        child: TextField(
                          controller: _controller,
                          decoration: const InputDecoration(
                            hintText: "Type message or select option",
                            hintStyle: TextStyle(color: UI.hint),
                            contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                            border: InputBorder.none,
                          ),
                          onSubmitted: _submitIfNotEmpty,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    InkWell(
                      onTap: () => _submitIfNotEmpty(_controller.text),
                      borderRadius: BorderRadius.circular(22),
                      child: Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: UI.border, width: 1),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x26000000),
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        alignment: Alignment.center,
                        child: const Icon(Icons.arrow_forward, color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// pill bubbles with 1px black border; bot-left / user-right
  Widget _bubble({required String text, required bool isUser}) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        constraints: const BoxConstraints(maxWidth: 260),
        decoration: BoxDecoration(
          color: isUser ? UI.userBubble : UI.botBubble,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: UI.border, width: 1),
        ),
        child: Text(
          text,
          style: const TextStyle(color: Colors.black, fontSize: 14, height: 1.25),
        ),
      ),
    );
  }

  /// quick chips (sends that text)
  Widget _chip(String label) {
    return InkWell(
      onTap: () {
        _controller.text = label;
        _submitIfNotEmpty(label);
      },
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: UI.border, width: 1),
        ),
        child: Text(
          label,
          style: const TextStyle(color: Colors.black, fontSize: 13, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
