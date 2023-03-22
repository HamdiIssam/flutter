import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_api/http-example/home.dart';
import 'package:my_api/produit/home-produit.dart';
import 'package:my_api/splashScreen.dart';

import 'auth/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false, // band debug
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        home: AnimatedSplashScreen(
            splash: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(width: 100, child: Image.asset('assets/cart.png')),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Bienvenue',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                )
              ],
            ),
            duration: 1000,
            splashTransition: SplashTransition.rotationTransition,
            backgroundColor: Colors.grey[300]!,
            nextScreen: LoginPage()));
  }
}
