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
  double _buttonBottom = 30;
  double _buttonRight = 20;

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
                  if (_buttonBottom > MediaQuery.of(context).size.height - 80)
                    _buttonBottom = MediaQuery.of(context).size.height - 80;
                  if (_buttonRight > MediaQuery.of(context).size.width - 60)
                    _buttonRight = MediaQuery.of(context).size.width - 60;
                });
              },
              child: FloatingActionButton(
                onPressed: () {
                  setState(() {
                    _isChatOpen = !_isChatOpen;
                  });
                },
                child: const Icon(Icons.chat),
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
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: const BoxDecoration(
                color: Colors.blue,
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
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8),
                color: Colors.grey[100],
                child: const Center(
                  child: Text('Chat content will appear here'),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
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
                    onPressed: () {},
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
