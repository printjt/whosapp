// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:WhosApp/Providers/error_provider.dart';

class LoginPage extends StatelessWidget {
  FirebaseAuth auth = FirebaseAuth.instance;
  String email = "";
  String pass = "";


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Color(0xff131A22),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
          child: Column(
            children: [
              Align(
                child: Image.asset("assets/pic.png", width: 75, height: 75),
                alignment: Alignment.topLeft,
              ),
              SizedBox(
                height: 40.0,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Welcome to WhosApp",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                "Enter your email address and password to proceed with the login process",
                style: TextStyle(color: Color(0xff7B8A93)),
              ),
              Align(
                  alignment: Alignment.center,
                  child: Text(
                    context.watch<Error>().error,
                    style: TextStyle(color: Colors.red),
                  )),
              SizedBox(
                height: 30.0,
              ),
              Flexible(
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    hintText: "Email",
                    hintStyle: TextStyle(color: Color(0xff7B8A93)),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white))),
                style: TextStyle(color: Colors.white),
                onChanged: (text) {
                  email = text;
                },
              )),
              SizedBox(
                height: 20.0,
              ),
              Flexible(
                  child: TextField(
                decoration: InputDecoration(
                    hintText: "Password",
                    hintStyle: TextStyle(color: Color(0xff7B8A93)),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white))),
                style: TextStyle(color: Colors.white),
                onChanged: (text) => pass = text,
                obscureText: true,
              )),
              Spacer(),
              TextButton(
                onPressed: () async {
                  try {
                    //await FirebaseAuth.instance.signOut();
                    UserCredential user = await FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: email, password: pass);
                    context.read<Error>().setError("");
                    Navigator.popAndPushNamed(context, "main");
                  } on FirebaseAuthException catch (e) {
                    if(pass.isEmpty){
                      context.read<Error>().setError("Enter password");
                    }else if(pass.length < 6){
                      context.read<Error>().setError("Password is invalid");
                    }else if(email.isEmpty){
                      context.read<Error>().setError("Enter email");
                    }else (context.read<Error>().setError(e.code));
                    print("email is $email and pass is $pass");
                  }
                },
                child: Text(
                  "Login",
                  style: TextStyle(color: Colors.white),
                ),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Color(0xff17C672)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0))),
                    fixedSize:
                        MaterialStateProperty.all(Size.fromWidth(300.0))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
