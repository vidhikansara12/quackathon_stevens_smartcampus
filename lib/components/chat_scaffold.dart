import 'package:flutter/material.dart';

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

  final List<String> _messages = []; 
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appBar,
      body: Stack(
        children: [
          Container(
            color: widget.backgroundColor, 
            child: widget.body,
          ),

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
                  if (_buttonBottom > MediaQuery.of(context).size.height - 80) {
                    _buttonBottom = MediaQuery.of(context).size.height - 80;
                  }
                  if (_buttonRight > MediaQuery.of(context).size.width - 60) {
                    _buttonRight = MediaQuery.of(context).size.width - 60;
                  }
                });
              },
              child: FloatingActionButton(
                backgroundColor: const Color.fromARGB(255, 224, 103, 103),
                onPressed: () {
                  setState(() {
                    _isChatOpen = !_isChatOpen;

                    
                    if (_isChatOpen && _firstTimeOpened) {
                      _messages.add(
                        "Welcome to Smart-Campus! I'm Stev-o-mate, how can I help you?"
                      );
                      _firstTimeOpened = false;
                    }
                  });
                },
                child: const Icon(Icons.chat, color: Colors.black,),
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
        height: 400,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 215, 129, 129),
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
                    onTap: () {
                      setState(() {
                        _isChatOpen = false;
                      });
                    },
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
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    final message = _messages[index];
                    final isUser = index % 2 == 1; // 🔑 simple trick: odd = user, even = bot
                    // You can replace with a proper model later (like storing sender info)

                    return Align(
                      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        padding: const EdgeInsets.all(10),
                        constraints: BoxConstraints(maxWidth: 220), // prevents super long lines
                        decoration: BoxDecoration(
                          color: isUser ? Colors.white : const Color(0xB3E97A7A),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          message,
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
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'Type a message...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () {
                      if (_controller.text.trim().isNotEmpty) {
                        setState(() {
                          _messages.add(_controller.text.trim());
                          _controller.clear();
                        });
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
