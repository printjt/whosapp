import 'package:WhosApp/Screens/new_chat_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class messageBubble extends StatelessWidget {
  messageBubble({required this.text, required this.sender, required this.isMe,required this.id});

  final String text;
  final String sender;
  final bool isMe;
  final String id;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        if(sender == FirebaseAuth.instance.currentUser?.email){
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) => SingleChildScrollView(
                  child: GestureDetector(
                    onTap: (){
                      firestore.collection("messages").doc(id).delete();
                      Navigator.pop(context);
                    },
                    child: Container(
                      color: Colors.red,
                      child: Align(
                        child: Text(
                          "DELETE",
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30.0),
                        ),
                        alignment: Alignment.center,
                      ),
                    ),
                  )));
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
        child: Column(
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            // Text(
            //   sender,
            //   style: TextStyle(color: Colors.black54, fontSize: 12.0),
            // ),
            Material(
              color: isMe ? Color(0xff005D4B) : Color(0xff1F2C34),
              borderRadius: BorderRadius.only(
                  topRight: isMe ? Radius.circular(0) : Radius.circular(10.0),
                  topLeft: isMe ? Radius.circular(10.0) : Radius.circular(0),
                  bottomLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0)),
              elevation: 5.0,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                child: Text(
                  text,
                  style: TextStyle(color: Colors.white, fontSize: 17.0),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
