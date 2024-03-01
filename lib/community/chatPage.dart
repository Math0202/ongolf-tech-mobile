import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ongolf_tech/basic%20components/my_textfied.dart';
import 'package:ongolf_tech/community/chattingServices/chat.dart';

class chatPage extends StatefulWidget {
  final String receivedUserFullName;
  final String receivedUserID;
  const chatPage({
    super.key,
    required this.receivedUserFullName,
    required this.receivedUserID,
  });

  @override
  State<chatPage> createState() => _chatPageState();
}

class _chatPageState extends State<chatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void sendMessage() async {
    //only send when the textfild is not empty.
    if (_messageController.text.isNotEmpty){
      await _chatService.sendMessage(widget.receivedUserID, _messageController.text);
      _messageController.clear();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.receivedUserFullName),
        ),
        body: Column(
          children: [
            Expanded(child: _buildMessageList(),
            ),
            //sending message
            Row(
              children: [
                Expanded(
                  child:MyTextFied(
                    controller: _messageController,
                    hintText: 'Enter message',
                    obscureText: false,
                    )
                  ),

                  //send button
                  IconButton(
                    onPressed: sendMessage, 
                    icon: Icon(
                      Icons.arrow_upward, 
                      size: 40,)
                  )
              ],
            )
          ],
        ),
    );
  }

  //build message list
Widget _buildMessageList() {
  return StreamBuilder(
    stream: _chatService.getMessages(
      widget.receivedUserID, _firebaseAuth.currentUser!.uid),
    builder: (context, snapshot) {
      if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      }
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Text('Loading...');
      }
      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
        return const Text('No messages yet.');
      }
      return ListView(
      children: snapshot.data!.docs
      .map((document) => _buildMessageItem(document))
      .toList(),
      );
       
    },
  );
}





  //building a message item
  Widget _buildMessageItem(DocumentSnapshot document){
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    //alignment of sender and receiver
    var alignment = (data['senderId'] == _firebaseAuth.currentUser!.uid)? 
    Alignment.centerRight 
    : Alignment.centerLeft; 
    //heres were you can lable the sender name of each message
    return Container(
    alignment: alignment,
    child: Text(data['message']),
    );
  }
}