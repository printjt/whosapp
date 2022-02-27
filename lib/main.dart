
import 'package:WhosApp/Screens/pay_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:WhosApp/Screens/chat_page.dart';
import 'package:WhosApp/Screens/login_page.dart';
import 'package:WhosApp/Screens/main_page.dart';
import 'package:WhosApp/main.dart';
import 'package:WhosApp/Screens/chat_page.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:WhosApp/Providers/error_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => Error()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        systemNavigationBarColor: Color(0xff0C131B),
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "demo",
      initialRoute:
          FirebaseAuth.instance.currentUser != null ? 'main' : 'login',
      routes: {
        "main": (context) => MainPage(),
        "chat": (context) => ChatPage(),
        "login": (context) => LoginPage(),
        "pay": (context) => PayPage()
      },
    );
  }
}
