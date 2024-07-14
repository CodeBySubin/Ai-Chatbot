// import 'dart:io';

// import 'package:chatbot/Controller.dart/ChatController.dart';
// import 'package:chatbot/Resource/colors.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get_state_manager/src/simple/get_state.dart';

// class HomePage extends StatelessWidget {
//   static const routeName = '/home';
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final screenSize = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(
//         leading: null,
//         surfaceTintColor: Colors.transparent,
//         backgroundColor: Colors.white,
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.vertical(
//             bottom: Radius.circular(10),
//           ),
//         ),
//         title: const Text(
//           "Chatbot",
//           style: TextStyle(
//               fontWeight: FontWeight.bold,
//               fontFamily: 'Poppins-Regular',
//               fontSize: 20,
//               color: colorPrimary),
//         ),
//       ),
//       body: GetBuilder<ChatController>(
//         init: ChatController(),
//         builder: (chatController) {
//           return SafeArea(
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   Container(
//                     alignment: Alignment.centerLeft,
//                     height: 150,
//                     width: 150,
//                     child: Image.asset(
//                       "assets/image/chatbot_logo.png",
//                       color: colorPrimary,
//                     ),
//                   ),
//                   Container(
//                     margin: const EdgeInsets.all(20),
//                     decoration: BoxDecoration(
//                       boxShadow: const [
//                         BoxShadow(
//                           color: Color.fromARGB(255, 226, 223, 223),
//                           blurRadius: 2.0,
//                           spreadRadius: 0.0,
//                           offset: Offset(2.0, 2.0),
//                         ),
//                         BoxShadow(
//                           color: Color.fromARGB(255, 226, 223, 223),
//                           blurRadius: 2.0,
//                           spreadRadius: 0.0,
//                           offset: Offset(-2.0, -2.0),
//                         ),
//                         BoxShadow(
//                           color: Color.fromARGB(255, 226, 223, 223),
//                           blurRadius: 2.0,
//                           spreadRadius: 0.0,
//                           offset: Offset(2.0, -2.0),
//                         ),
//                         BoxShadow(
//                           color: Color.fromARGB(255, 226, 223, 223),
//                           blurRadius: 2.0,
//                           spreadRadius: 0.0,
//                           offset: Offset(-2.0, 2.0),
//                         ),
//                       ],
//                       borderRadius: BorderRadius.circular(5),
//                       color: Colors.white,
//                     ),
//                     child: Row(
//                       children: [
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const Padding(
//                               padding: EdgeInsets.only(top: 16.0, left: 16.0),
//                               child: Text(
//                                 "Hello! How can I assist you?",
//                                 style: TextStyle(
//                                   fontSize: 20.0,
//                                   fontFamily: 'Poppins-Regular',
//                                   color: colorPrimary,
//                                 ),
//                               ),
//                             ),
//                             const Padding(
//                               padding: EdgeInsets.only(left: 16.0),
//                               child: Text(
//                                 "Feel free to ask any questions.",
//                                 style: TextStyle(
//                                   fontSize: 20.0,
//                                   fontFamily: 'Poppins-Regular',
//                                   color: colorPrimary,
//                                 ),
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(
//                                 top: 8.0,
//                                 left: 16.0,
//                                 bottom: 16.0,
//                               ),
//                               child: TextButton(
//                                 onPressed: () {
//                                   Navigator.pushNamed(context, '/chat');
//                                 },
//                                 style: ButtonStyle(
//                                   backgroundColor:
//                                       MaterialStateProperty.all<Color>(
//                                           Colors.white),
//                                   foregroundColor:
//                                       MaterialStateProperty.all<Color>(
//                                           Colors.black),
//                                 ),
//                                 child: const Padding(
//                                   padding:
//                                       EdgeInsets.symmetric(horizontal: 16.0),
//                                   child: Text(
//                                     "Ask Now",
//                                     style: TextStyle(
//                                       fontSize: 16.0,
//                                       fontFamily: 'Poppins-Regular',
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   const Padding(
//                     padding: EdgeInsets.only(
//                       top: 16.0,
//                       left: 16.0,
//                       right: 16.0,
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           "Recent Chats",
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontFamily: 'Poppins-Regular',
//                               color: Colors.grey),
//                         ),
//                         Text(
//                           "See All",
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontFamily: 'Poppins-Regular',
//                               color: colorPrimary),
//                         ),
//                       ],
//                     ),
//                   ),
//                   chatController.chatHistory.isEmpty
//                       ? Column(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Image.asset(
//                               'assets/image/no_data.jpg',
//                               height: screenSize.height * 0.4,
//                               width: screenSize.width * 0.6,
//                             ),
//                             const Text(
//                               "No Recent Chat Found",
//                               style: TextStyle(
//                                 color: colorPrimary,
//                                 fontSize: 15.0,
//                                 fontFamily: 'Poppins-Bold',
//                               ),
//                             ),
//                           ],
//                         )
//                       : Expanded(
//                           child: ListView.builder(
//                             itemCount: chatController.chatHistory.length,
//                             shrinkWrap: true,
//                             padding: const EdgeInsets.only(top: 10, bottom: 10),
//                             itemBuilder: (context, index) {
//                               final chat = chatController.chatHistory[index];
//                               return Container(
//                                 padding: const EdgeInsets.all(10),
//                                 child: Align(
//                                   alignment: chat.isSender
//                                       ? Alignment.topRight
//                                       : Alignment.topLeft,
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.only(
//                                         topLeft: const Radius.circular(20.0),
//                                         topRight: const Radius.circular(20.0),
//                                         bottomRight: chat.isSender
//                                             ? const Radius.circular(0.0)
//                                             : const Radius.circular(20.0),
//                                         bottomLeft: chat.isSender
//                                             ? const Radius.circular(20.0)
//                                             : const Radius.circular(0.0),
//                                       ),
//                                       color: chat.isSender
//                                           ? colorPrimary
//                                           : colorgrey,
//                                     ),
//                                     padding: const EdgeInsets.all(16),
//                                     child: Text(
//                                       chat.message,
//                                       style: TextStyle(
//                                           fontSize: 15,
//                                           fontWeight: FontWeight.bold,
//                                           fontFamily: 'Poppins-Regular',
//                                           color: chat.isSender
//                                               ? Colors.white
//                                               : const Color(0xFF656565)),
//                                     ),
//                                   ),
//                                 ),
//                               );
//                             },
//                           ),
//                         ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
