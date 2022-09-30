import 'package:chat/screen/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chat/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chat/screen/login.dart';

final _auth = FirebaseAuth.instance;

class ChatScreen extends StatefulWidget {
  static const String id = "ChatScreen";
  ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    getUser();
    super.initState();
  }

  void getUser() {
    try {
      final user = _auth.currentUser!.email;
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    late String message;
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
        .collection("Message")
        .orderBy("time", descending: true)
        .snapshots();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat"),
        actions: [
          IconButton(
              onPressed: () async {
                await _auth.signOut();
                Navigator.pushNamed(context, Login.id);
              },
              icon: Icon(Icons.cancel))
        ],
      ),
      body: SafeArea(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                    stream: _usersStream,
                    builder: ((BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      final messages = snapshot.data?.docs;

                      if (!snapshot.hasData) {
                        return const Text("Loading ...");
                      }

                      late List<ChatBody> messageWidgets = [];

                      for (var message in messages!) {
                        final String messegeEmail = message["Email"];
                        final String messageText = message["message"];

                        final messageWidget = ChatBody(
                            sender: messegeEmail, message: messageText);

                        messageWidgets.add(messageWidget);
                      }

                      if (snapshot.hasError) {
                        return const Text("Error ");
                      }
                      // return Text("fuck");

                      return ListView(reverse: true, children: messageWidgets);
                    })),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        onChanged: (String value) {
                          message = value;
                        },
                        decoration: inputDecoration.copyWith(
                            label: const Text("Type Your Messege")),
                      ),
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Theme.of(context).primaryColor)),
                        onPressed: () {
                          firestore.collection('Message').add({
                            "Email": _auth.currentUser!.email,
                            "message": message,
                            "time": DateTime.now(),
                          });

                          _controller.clear();
                        },
                        child: const Text("Send"))
                  ],
                ),
              )
            ]),
      ),
    );
  }
}

class ChatBody extends StatelessWidget {
  const ChatBody({Key? key, required this.sender, required this.message})
      : super(key: key);

  final String sender;
  final String message;

  @override
  Widget build(BuildContext context) {
    bool isMe = _auth.currentUser!.email == sender;
    return Column(
      crossAxisAlignment:
          isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(
          sender,
          style: const TextStyle(color: Colors.brown, fontSize: 14.0),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            color: isMe ? const Color(0xff487eb0) : const Color(0xffecf0f1),
            elevation: 10.0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              child: Text(
                message,
                style: TextStyle(
                    fontSize: 18, color: isMe ? Colors.white : Colors.black87),
              ),
            ),
          ),
        )
      ],
    );
    ;
  }
}
