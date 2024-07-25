import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:mime/mime.dart';
import 'package:ongolf_tech/community/chattingServices/message.dart';
import 'package:video_player/video_player.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:chewie/chewie.dart';

class ChatService extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

Future<void> sendMessage(String receiverId, {String? message, String? fileUrl, bool isGroupChat = false, List<String>? groupMemberIds}) async {
    final currentUserId = _firebaseAuth.currentUser!.uid;
    final Timestamp timestamp = Timestamp.now();

    if (message != null || fileUrl != null) {
      Message newMessage = Message(
        senderId: currentUserId,
        receiverId: receiverId,
        message: message ?? '',
        timestamp: timestamp,
        fileUrl: fileUrl,
      );

      if (!isGroupChat) {
        // For one-to-one chats
        List<String> ids = [currentUserId, receiverId];
        ids.sort();
        String chatRoomId = ids.join("-");

        await _firestore
            .collection('chat_rooms')
            .doc(chatRoomId)
            .collection('messages')
            .add(newMessage.toMap());
      } else {
        // For group chats
        if (groupMemberIds != null) {
          for (String memberId in groupMemberIds) {
            if (memberId != currentUserId) {
              List<String> ids = [currentUserId, memberId];
              ids.sort();
              String chatRoomId = ids.join("-");
              await _firestore
                  .collection('chat_rooms')
                  .doc(chatRoomId)
                  .collection('messages')
                  .add(newMessage.toMap());
            }
          }
        }
      }

      print('Message sent: $message');
    }
  }


  // Get messages from database
  Stream<QuerySnapshot> getMessages(String currentUserId, String receivedUserID) {
    List<String> ids = [currentUserId, receivedUserID];
    ids.sort();
    String chatRoomId = ids.join("-");

    return _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timeStamp', descending: false)
        .snapshots();
  }
}

class ChatPage extends StatefulWidget {
  final String receivedUserID;
  final String receivedUserFullName;

  const ChatPage({Key? key, required this.receivedUserID, required this.receivedUserFullName, required bool isGroupChat}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with AutomaticKeepAliveClientMixin<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  late ScrollController scrollController;
  String? _fileUrl;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController(); // Initialize the scroll controller
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        print("At the bottom");
      }
    });
  }

  void sendMessage() async {
    if (_messageController.text.isEmpty && _fileUrl != null) {
      // Clear the file URL and dispose of the file
      setState(() {
        _fileUrl = null;
      });
    } else if (_messageController.text.isNotEmpty || _fileUrl != null) {
      // Show a circular progress indicator
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('Sending message...'),
              ],
            ),
          );
        },
      );

      await _chatService.sendMessage(
        widget.receivedUserID,
        message: _messageController.text,
        fileUrl: _fileUrl,
      );
      _messageController.clear();
      setState(() {
        _fileUrl = null;
      });

      // Close the progress indicator dialog
      Navigator.of(context).pop();
    }
  }

  void pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path!);

      // Show a progress indicator while uploading
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('Uploading file...'),
              ],
            ),
          );
        },
      );

      // Storing the file in Firebase Storage and getting the download URL
      Reference ref = FirebaseStorage.instance.ref().child(result.files.single.name);
      UploadTask uploadTask = ref.putFile(file);
      TaskSnapshot taskSnapshot = await uploadTask;
      String fileUrl = await taskSnapshot.ref.getDownloadURL();

      setState(() {
        _fileUrl = fileUrl;
        _messageController.text = result.files.single.name;
      });

      // Close the progress indicator dialog
      Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.green.shade100,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 95, 228, 99),
        title: Text(widget.receivedUserFullName),
        centerTitle: true,
      ),
      body: PageStorage(
        bucket: PageStorageBucket(),
        key: PageStorageKey('chatPageKey'), // Unique key for the ChatPage
        child: Column(
          children: [
            Expanded(
              child: _buildMessagesList(),
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.attach_file),
                  onPressed: pickFile,
                ),
                Expanded(
                  child: TextField(
                    maxLines: null,
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Enter message or select a file',
                      hintStyle: TextStyle(color: Colors.grey[500]),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueGrey),
                      ),
                      fillColor: Colors.grey.shade200,
                      filled: true,
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: sendMessage,
                      icon: Icon(
                        Icons.send,
                        size: 30,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10,)
          ],
        ),
      ),
    );
  }

  // Build messages list
  Widget _buildMessagesList() {
    return StreamBuilder(
      stream: _chatService.getMessages(widget.receivedUserID, _firebaseAuth.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error' + snapshot.error.toString());
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: const Text("loading..."));
        }

        // Scroll to the bottom when the snapshot is updated
        WidgetsBinding.instance?.addPostFrameCallback((_) {
          if (mounted) {
            scrollController.animateTo(scrollController.position.maxScrollExtent, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
          }
        });

        final messages = snapshot.data!.docs.map((document) => _buildMessagesItem(document)).toList();
        return ListView.builder(
          controller: scrollController, // Attach a scroll controller
          itemCount: messages.length,
          itemBuilder: (context, index) {
            return messages[index];
          },
        );
      },
    );
  }

  Widget _buildMessagesItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    var alignment = (data['senderId'] == _firebaseAuth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    var messageBubble = Align(
      alignment: alignment,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        margin: EdgeInsets.only(bottom: 4, left: 8, right: 8, top: 4),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        decoration: BoxDecoration(
          color: (data['senderId'] == _firebaseAuth.currentUser!.uid) ? Colors.green[200] : Colors.green.shade400,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
            bottomLeft: (alignment == Alignment.centerRight) ? Radius.circular(12) : Radius.zero,
            bottomRight: (alignment == Alignment.centerLeft) ? Radius.circular(12) : Radius.zero,
          ),
        ),
        child: _buildMessageContent(data),
      ),
    );

    return messageBubble;
  }

  Widget _buildMessageContent(Map<String, dynamic> data) {
    VideoPlayerController? videoPlayerController;
    ChewieController? chewieController;

    if (data['fileUrl'] != null) {
      String fileName = Uri.parse(data['fileUrl']).path.split('/').last;
      String? mimeType = lookupMimeType(fileName, headerBytes: null);
      if (mimeType != null) {
        if (mimeType.startsWith('image/')) {
          // Display the image within the app
          print('Displaying image...');
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  // Show the image in a full-screen dialog
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        child: Container(
                          constraints: BoxConstraints.expand(),
                          child: Image.network(
                            data['fileUrl'],
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Image.network(
                  data['fileUrl'],
                  fit: BoxFit.cover,
                ),
              ),
              if (data['message'] != null && data['message'].isNotEmpty) SizedBox(height: 8),
              if (data['message'] != null && data['message'].isNotEmpty) Text(data['message']),
            ],
          );
        } else if (mimeType.startsWith('video/')) {
          // Display the video within the app
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  // Show the video in a full-screen dialog
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        child: Container(
                          constraints: BoxConstraints.expand(),
                          child: FittedBox(
                            fit: BoxFit.cover,
                            child: Chewie(
                              controller: chewieController!,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: Chewie(
                    controller: chewieController = ChewieController(
                      videoPlayerController: videoPlayerController = VideoPlayerController.network(data['fileUrl']),
                      looping: false,
                    ),
                  ),
                ),
              ),
              if (data['message'] != null && data['message'].isNotEmpty) SizedBox(height: 8),
              if (data['message'] != null && data['message'].isNotEmpty) Text(data['message']),
            ],
          );
        }
      }

      // Display a generic message for other file types
      print('Displaying generic file...');
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              var fileUrl = data['fileUrl'];
              launchUrl(Uri.parse(fileUrl));
            },
            child: Container(
              height: 130 / 5,
              width: 180 / 5,
              child: Image.asset(
                'assets/file1.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          if (data['message'] != null && data['message'].isNotEmpty) SizedBox(height: 8),
          if (data['message'] != null && data['message'].isNotEmpty) Text(data['message']),
        ],
      );
    } else {
      return Text(
        data['message'],
        style: TextStyle(fontSize: 16),
      );
    }
  }
}
