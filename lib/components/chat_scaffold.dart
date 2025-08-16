import 'dart:async';
import 'package:flutter/material.dart';
// ====================== INTEGRATION_START ======================
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// /// Local dev / prod endpoint for real backend
// const String kChatApi = "http://10.0.2.2:8080/chat";
// ====================== INTEGRATION_END ========================

/// Simple message model so alignment is reliable.
class ChatMessage {
  final String text;
  final bool isUser;
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

  /// Light auto-scroll to the bottom when new messages arrive.
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

  // ====================== MOCK BEHAVIOR (ACTIVE NOW) ======================
  /// Mocked send: simulates typing, then returns a friendly echo.
  Future<void> _sendToBot(String userText) async {
    // 1) Add user message
    setState(() {
      _messages.add(ChatMessage(userText, true));
    });
    _scrollToBottom();

    // 2) Show typing indicator
    setState(() {
      _messages.add(const ChatMessage("...", false));
    });
    _scrollToBottom();

    try {
      // simulate network + thinking delay
      await Future.delayed(const Duration(milliseconds: 800));

      // Replace typing indicator with mock reply
      setState(() {
        _messages.removeLast();
        _messages.add(ChatMessage("Echo from Stev-o-mate: $userText", false));
      });
    } catch (e) {
      setState(() {
        _messages.removeLast();
        _messages.add(ChatMessage("Mock error: $e", false));
      });
    }

    _scrollToBottom();
  }
  // ====================== MOCK END ======================


  // ====================== INTEGRATION_START ======================
  // /// Real backend integration version — uncomment when backend is ready,
  // /// and comment out the MOCK version above.
  // Future<void> _sendToBot(String userText) async {
  //   setState(() {
  //     _messages.add(ChatMessage(userText, true));
  //   });
  //   _scrollToBottom();
  //
  //   setState(() {
  //     _messages.add(const ChatMessage("...", false));
  //   });
  //   _scrollToBottom();
  //
  //   try {
  //     final history = _messages
  //         .where((m) => m.text != "...")
  //         .map((m) => {
  //               "role": m.isUser ? "user" : "assistant",
  //               "content": m.text,
  //             })
  //         .toList();
  //
  //     final resp = await http.post(
  //       Uri.parse(kChatApi),
  //       headers: {"Content-Type": "application/json"},
  //       body: jsonEncode({"messages": history}),
  //     );
  //
  //     if (resp.statusCode == 200) {
  //       final data = jsonDecode(resp.body) as Map<String, dynamic>;
  //       final reply = (data["reply"] ?? "Sorry, I didn’t catch that.").toString();
  //       setState(() {
  //         _messages.removeLast();
  //         _messages.add(ChatMessage(reply, false));
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
  //
  //   _scrollToBottom();
  // }
  // ====================== INTEGRATION_END ======================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appBar,
      body: Stack(
        children: [
          Container(color: widget.backgroundColor, child: widget.body),

          // Floating draggable chat button
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

                  final size = MediaQuery.of(context).size;
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

                    // First-time welcome message
                    if (_isChatOpen && _firstTimeOpened) {
                      _messages.add(const ChatMessage(
                        "Welcome to Smart-Campus! I'm Stev-o-mate, how can I help you?",
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

          // Chat Popup
          if (_isChatOpen)
            Positioned(
              bottom: _buttonBottom + 70,
              right: _buttonRight,
              child: _buildChatPopup(context),
            ),
        ],
      ),
    );
  }

  Widget _buildChatPopup(BuildContext context) {
    return Material(
      elevation: 8,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 300,
        height: 420,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 215, 129, 129), // your pinkish bg
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: const BoxDecoration(
                color: Color.fromARGB(19, 47, 3, 3),
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Chatbot',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () => setState(() => _isChatOpen = false),
                    child: const Icon(Icons.close, color: Colors.white),
                  ),
                ],
              ),
            ),

            // Chat messages
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8),
                color: Colors.grey[100],
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    final m = _messages[index];
                    final isUser = m.isUser;

                    return Align(
                      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        padding: const EdgeInsets.all(10),
                        constraints: const BoxConstraints(maxWidth: 220),
                        decoration: BoxDecoration(
                          color: isUser ? Colors.white : const Color(0xB3E97A7A),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          m.text,
                          style: TextStyle(
                            color: isUser ? Colors.black : const Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            // Input box
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              color: Colors.white, // whole bottom bar white
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'Type a message...',
                        filled: true,
                        fillColor: Colors.white, // input white
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      ),
                      onSubmitted: (value) {
                        final text = value.trim();
                        if (text.isNotEmpty) {
                          _controller.clear();
                          _sendToBot(text);
                        }
                      },
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () {
                      final text = _controller.text.trim();
                      if (text.isNotEmpty) {
                        _controller.clear();
                        _sendToBot(text);
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
