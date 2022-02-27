// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:WhosApp/Widgets/tiles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:WhosApp/Screens/new_chat_page.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

class NewChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff090C10),
      child: Container(
        height: 250,
        padding: EdgeInsets.only(top: 10.0,left:20.0,right: 20.0 ),
        decoration: BoxDecoration(
            color: Color(0xff1F2C34),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0))),
        child:  Column(
          children: [
            StreamBuilder<QuerySnapshot>(
                stream: firestore.collection("users").snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.teal,
                      ),
                    );
                  }
                  final users = snapshot.data?.docs;
                  List<Widget> userWidgets = [];
                  for (var user in users!) {
                    final userName = user['name'];
                    final userEmil = user['email'];
                    final userImage = user['image'];
                    final userTile = Tile(userName, userEmil,userImage);
                    userWidgets.add(userTile);
                  }
                  ;
                  return Expanded(
                    child: ListView(
                      children: userWidgets,
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
