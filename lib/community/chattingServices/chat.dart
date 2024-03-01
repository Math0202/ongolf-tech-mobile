import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ongolf_tech/basic%20components/my_textfied.dart';
import 'package:ongolf_tech/community/chatPage.dart';
import 'package:ongolf_tech/community/chattingServices/message.dart';

class ChatService extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendMessage(String receiverId, String message) async {
    final currentUserId = _firebaseAuth.currentUser!.uid;
    final currentUserEmail = _firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    if (message.isNotEmpty) {
      Message newMessage = Message(
        senderId: currentUserId,
        senderEmail: currentUserEmail,
        receiverId: receiverId,
        message: message,
        timestamp: timestamp,
      );

      List<String> ids = [currentUserId, receiverId];
      ids.sort();
      String chatRoomId = ids.join("_");

      await _firestore
          .collection('chat_rooms')
          .doc(chatRoomId)
          .collection('messages')
          .add(newMessage.toMap());
    }
  }

  Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join("_");

    String messagesCollectionPath = 'chat_rooms/$chatRoomId/messages';
    print('Fetching messages from: $messagesCollectionPath');

    try {
      return _firestore
          .collection(messagesCollectionPath)
          .orderBy('timestamp', descending: false)
          .snapshots();
    } catch (e) {
      print('Error fetching messages: $e');
      throw e; // Rethrow the error to handle it in the UI
    }
  }
}


class _chatPageState extends State<chatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
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
          Expanded(
            child: _buildMessageList(),
          ),
          Row(
            children: [
              Expanded(
                child: MyTextFied(
                  controller: _messageController,
                  hintText: 'Enter message',
                  obscureText: false,
                ),
              ),
              IconButton(
                onPressed: sendMessage,
                icon: Icon(
                  Icons.arrow_upward,
                  size: 40,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    return StreamBuilder(
      stream: _chatService.getMessages(widget.receivedUserID, _firebaseAuth.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text('Error ${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading...');
        }
        return ListView(
          children: snapshot.data!.docs.map((document) => _buildMessageItem(document)).toList(),
        );
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    var alignment =
        (data['senderId'] == _firebaseAuth.currentUser!.uid) ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            data['senderEmail'], // Display sender's email as sender's name
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(data['message']),
        ],
      ),
    );
  }
}
