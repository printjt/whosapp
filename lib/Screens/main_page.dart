// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:WhosApp/Widgets/tiles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:WhosApp/Screens/new_chat_page.dart';
import 'package:provider/provider.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) => SingleChildScrollView(child: NewChat()));
        },
        child: Icon(Icons.message),
        backgroundColor: Color(0xff04A985),
      ),
      backgroundColor: Color(0xff131A22),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
                top: 10.0, left: 10.0, right: 10.0, bottom: 2.0),
            color: Color(0xff1F2C34),
            child: SafeArea(
              child: Column(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          FirebaseAuth.instance.signOut();
                          Navigator.popAndPushNamed(context, "login");
                        },
                        child: Text(
                          "Whosapp",
                          style: TextStyle(
                              color: Color(0xff7B8A93),
                              fontSize: 20.0,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      Spacer(),
                      Icon(Icons.search, color: Color(0xff7B8A93), size: 25.0),
                      SizedBox(width: 5.0),
                      PopupMenuButton(
                        color: Color(0xff233239),
                        itemBuilder: (context) =>
                        [
                          PopupMenuItem(
                              child: Text(
                                "New Group",
                                style: TextStyle(color: Colors.white),
                              )),
                          PopupMenuItem(
                              child: Text(
                                "New Broadcast",
                                style: TextStyle(color: Colors.white),
                              )),
                          PopupMenuItem(
                              child: Text(
                                "Linked Devices",
                                style: TextStyle(color: Colors.white),
                              )),
                          PopupMenuItem(
                              child: Text(
                                "Starred Messages",
                                style: TextStyle(color: Colors.white),
                              )),
                          PopupMenuItem(
                              child: Text(
                                "Settings",
                                style: TextStyle(color: Colors.white),
                              ))
                        ],
                        icon: Icon(Icons.more_vert,
                            color: Color(0xff7B8A93), size: 25.0),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(context, "pay"),
                        child: Icon(
                          Icons.camera_alt,
                          color: Color(0xff7B8A93),
                          size: 25.0,
                        ),
                      ),
                      SizedBox(
                        width: 125,
                      ),
                      Container(
                        width: 100,
                        height: 35,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Chats",
                            style: TextStyle(
                                color: Color(0xff7B8A93),
                                fontSize: 17.0,
                                fontWeight: FontWeight.w700),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Color(0xff109A7B), width: 3.0))),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          Flexible(
            child: Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
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
                          final userTile = Tile(userName, userEmil, userImage);
                          userWidgets.add(userTile);
                        }
                        ;
                        return Expanded(
                          child: ListView(
                            children: userWidgets,
                          ),
                        );
                      })
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
