import 'dart:io';

import 'package:chatbot/Controller.dart/ChatController.dart';
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
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (context) => const Splash(),
        ChatPage.routeName: (context) => const ChatPage(),
      },
    );
  }
}











// import 'dart:io';

// import 'package:chatbot/Controller.dart/ChatController.dart';
// import 'package:chatbot/Screen/Homepage.dart';
// import 'package:chatbot/Screen/Splash.dart';
// import 'package:chatbot/Screen/chatpage.dart';
// import 'package:chatbot/model/model.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:hive_flutter/hive_flutter.dart';

// import 'package:flutter/material.dart';

// import 'package:flutter/material.dart';

// class CustomAppBarClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     final Path path = Path();
//     path.lineTo(0.0, size.height - 30);

//     final firstControlPoint = Offset(size.width / 4, size.height);
//     final firstEndPoint = Offset(size.width / 2, size.height - 30.0);
//     path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy, firstEndPoint.dx, firstEndPoint.dy);

//     final secondControlPoint = Offset(size.width * 3 / 4, size.height - 60.0);
//     final secondEndPoint = Offset(size.width, size.height - 30.0);
//     path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy, secondEndPoint.dx, secondEndPoint.dy);

//     path.lineTo(size.width, 0.0);
//     path.close();
//     return path;
//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) => false;
// }

// class CurvedAppBarDemo extends StatelessWidget {
//   const CurvedAppBarDemo({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: <Widget>[
//           ClipPath(
//             clipper: CustomAppBarClipper(),
//             child: Container(
//               height: 200.0,
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [Colors.blue, Colors.blueAccent],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//               ),
//               child: Center(
//                 child: Text(
//                   'Curved AppBar',
//                   style: TextStyle(
//                     fontSize: 25.0,
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           Positioned(
//             top: 220.0, // Adjust this value as needed to position the text below the AppBar
//             left: 20.0,
//             right: 20.0,
//             child: Text(
//               "vyuvkctu",
//               style: TextStyle(fontSize: 18.0),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// void main() => runApp(MaterialApp(
//   home: CurvedAppBarDemo(),
// ));


