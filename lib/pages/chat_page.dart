import 'package:chat_app/components/chat_bubble.dart';
import 'package:chat_app/components/my_textfield.dart';
import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/services/chat/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  final String receiverEmail;
  final String receiverID;
  ChatPage({super.key, required this.receiverEmail, required this.receiverID});

  //text controller

  final TextEditingController _messageController = TextEditingController();

  //chat & auth services

  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

// send message
  void sendMessage() async {
    //if there is something inside the textfield

    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(receiverID, _messageController.text);

      //clear the text controller
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          receiverEmail,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 30,
          ),
        ),

        // Set a custom height for the AppBar
        toolbarHeight: 100.0, // Adjust the value according to your needs
      ),
      body: Container(
        color: Color.fromARGB(255, 224, 198, 234),
        child: Column(
          children: [
            //display all messages
            Expanded(
              child: _buildMessageList(),
            ),
            //user input
            _buildUserInput(),

            const SizedBox(
              height: 25,
            )
          ],
        ),
      ),
    );
  }

  //build message list
  Widget _buildMessageList() {
    String senderID = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
        stream: _chatService.getMessages(receiverID, senderID),
        builder: (context, snapshot) {
          //errors
          if (snapshot.hasError) {
            return const Text("Error");
          }
          //loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading ..");
          }
          //return list view
          return ListView(
            children: snapshot.data!.docs
                .map((doc) => _buildMessageItem(doc))
                .toList(),
          );
        });
  }

  //build message item

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    var alignment = (data['senderId'] == _authService.getCurrentUser()!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment:
              (data['senderId'] == _authService.getCurrentUser()!.uid)
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
          children: [
            Text(data['senderEmail']),
            // Text(data['message']),
            const SizedBox(
              height: 5,
            ),
            ChatBubble(message: data['message']),
          ],
        ),
      ),
    );

    // return Text(data["message"]);
  }

  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Container(
        // width:100,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 219, 219, 219),
          borderRadius: BorderRadius.all(
            Radius.circular(40),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 0,
            top: 10,
            bottom: 10,
          ),
          child: Row(
            // crossAxisAlignment:CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //textfield should take up most of the space
              Expanded(
                child: MyTextField(
                  controller: _messageController,
                  hintText: "Type a message",
                  obscureText: false,
                ),
              ),

              //send button
              IconButton(
                onPressed: sendMessage,
                iconSize: 40,
                icon: const Icon(Icons.send),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
