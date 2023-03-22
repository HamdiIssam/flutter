// import 'package:flutter/material.dart';
// import 'package:my_api/auth/login.dart';
// import 'package:my_api/produit/home-produit.dart';

// class SplashScreem extends StatefulWidget {
//   const SplashScreem({super.key});

//   @override
//   State<SplashScreem> createState() => _SplashScreemState();
// }

// class _SplashScreemState extends State<SplashScreem> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     navHome();
//   }

//   navHome() async {
//     await Future.delayed(Duration(milliseconds: 1500), () {});
//     Navigator.pushReplacement(
//         context, MaterialPageRoute(builder: (context) => LoginPage()));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               height: 100,
//               width: 100,
//               color: Colors.blue,
//             ),
//             Container(
//               child: Text('hello '),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
