import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String num;
  final String name;

  CustomCard(this.num, this.name);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.0),
      width: 250.0,
      decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        image: DecorationImage(image: AssetImage("assets/flag.jpg"),fit: BoxFit.fill),
        boxShadow: [
          BoxShadow(
            color: Colors.lightBlueAccent.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ]
      ),

      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Bank of Wakanda",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0),
              ),
              Spacer(),
              Image(
                image: AssetImage("assets/nfc.png"),
                alignment: Alignment.topRight,
                color: Colors.white,
              ),
            ],
          ),
          Spacer(),
          Align(alignment: Alignment.topLeft,child: Image(image: AssetImage("assets/chip.png"),width: 30.0,height: 30.0,)),
          Spacer(),
          Row(
            children: [
              Column(
                children: [
                  Text(
                    num,
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(name, style: TextStyle(color: Colors.white))
                ],
              ),
              Spacer(),
              Image(
                image: AssetImage("assets/visa.png"),
                width: 50.0,
                height: 50.0,
              )
            ],
          ),


        ],
      ),
    );
  }
}
