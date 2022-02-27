// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:flutter/material.dart';

class Tile extends StatelessWidget {
  final String name;
  final String email;
  final String image;
  Tile(this.name,this.email,this.image);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, 'chat',arguments: {"name":name,"email":email,"image":image}),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage:NetworkImage(image),
              radius: 25.0,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                      style: TextStyle(
                          color: Color(0xffDBDDDE),
                          fontWeight: FontWeight.bold,
                          fontSize: 17.0)),
                  Text(
                    "message",
                    style: TextStyle(color: Color(0xff7B8A93)),
                  )
                ],
              ),
            ),
            Spacer(),
            Text("Yesterday",
              style: TextStyle(
                color: Color(0xff7B8A93),
              ),)
          ],
        ),
      ),
    );
  }
}