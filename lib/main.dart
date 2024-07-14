
import 'package:chatbot/Screen/Homepage.dart';
import 'package:chatbot/Screen/Splash.dart';
import 'package:chatbot/Screen/chatpage.dart';
import 'package:chatbot/Screen/intro_screen.dart';
import 'package:chatbot/model/model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ChatModelAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chat Bot',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      initialRoute: Splash.routeName,
      routes: {
        Splash.routeName: (context) => const Splash(),
        IntroScreen.routeName: (context) => const IntroScreen(),
        ChatPage.routeName: (context) => const ChatPage(),
      },
    );
  }
}
