// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_key_in_widget_constructors
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:WhosApp/Widgets/message_bubble.dart';

class ChatPage extends StatelessWidget {

  final fieldtext = TextEditingController();
  late String message;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference chat = FirebaseFirestore.instance.collection('messages');


  void clearText() {
    fieldtext.clear();
  }

  Future<void> addMessage(String receiver) {
    return chat
        .add({
          'sender': FirebaseAuth.instance.currentUser?.email,
          'message': message,
          'key': '$receiver ${FirebaseAuth.instance.currentUser?.email}',
          'createdAt': FieldValue.serverTimestamp()
        })
        .then((value) => print("message sent"))
        .catchError((error) => print(error));
  }

  @override
  Widget build(BuildContext context) {

    final arg = ModalRoute.of(context)?.settings.arguments as Map;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/back.png"), fit: BoxFit.cover)),
        child: Column(
          children: [
            Container(
              color: Color(0xff1F2C34),
              child: SafeArea(
                  child: Padding(
                padding: EdgeInsets.only(
                    left: 10.0, top: 10.0, bottom: 10.0, right: 10.0),
                child: Row(
                  children: [
                    GestureDetector(
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      onTap: () => Navigator.pop(context),
                    ),
                    CircleAvatar(
                      backgroundImage: NetworkImage(arg['image']),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      arg['name'],
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 20.0),
                    ),
                    Spacer(),
                    Icon(
                      Icons.video_call_rounded,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.call,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.more_vert,
                      color: Colors.white,
                    )
                  ],
                ),
              )),
            ),
            StreamBuilder<QuerySnapshot>(
                stream: firestore
                    .collection("messages")
                    .where("key", whereIn: ["${arg['email']} ${FirebaseAuth.instance.currentUser?.email}","${FirebaseAuth.instance.currentUser?.email} ${arg['email']}"])
                    .orderBy('createdAt', descending: false)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.teal,
                      ),
                    );
                  }
                  final messages = snapshot.data?.docs.reversed;
                  List<Widget> messageWidgets = [];
                  for (var message in messages!) {
                    final messageText = message["message"];
                    final messageSender = message["sender"];
                    final messageId = message.id;
                    final currentUser =
                        FirebaseAuth.instance.currentUser?.email;
                    final isMe = currentUser == messageSender;

                    final messageWidget = messageBubble(
                        text: messageText, sender: messageSender, isMe: isMe,id: messageId,);
                    messageWidgets.add(messageWidget);
                  }
                  return Expanded(
                      child: Align(
                    alignment: Alignment.topCenter,
                    child: ListView(
                      children: messageWidgets,
                      reverse: true,
                      shrinkWrap: true,
                    ),
                  ));
                }),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(children: [
                Expanded(
                  child: Container(
                    padding:
                        EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10.0),
                    decoration: BoxDecoration(
                        color: Color(0xff1F2C34),
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    child: Row(
                      children: [
                        Icon(
                          Icons.tag_faces_outlined,
                          color: Color(0xff7B8A93),
                          size: 25.0,
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Flexible(
                            child: TextField(
                              maxLines: null,
                          controller: fieldtext,
                          onChanged: (text) => message = text,
                          decoration: InputDecoration.collapsed(
                              hintText: "Message",
                              hintStyle: TextStyle(color: Color(0xff7B8A93))),
                          style: TextStyle(color: Colors.white),
                        )),
                        Icon(
                          Icons.attachment,
                          color: Color(0xff7B8A93),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Icon(
                          Icons.camera_alt,
                          color: Color(0xff7B8A93),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                GestureDetector(
                  onTap: () => {addMessage(arg["email"]), clearText()},
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xff05A682),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    height: 40,
                    width: 40,
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                  ),
                )
              ]),
            ),
            SizedBox(
              height: 10.0,
            )
          ],
        ),
      ),
    );
  }
}
