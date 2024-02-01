import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  const ChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8,
        bottom: 8,
      ),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Color.fromARGB(197, 255, 255, 255),
        ),
        child: Text(
          message,
          style: const TextStyle(
              fontSize: 20, color: Color.fromARGB(184, 0, 0, 0), fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
