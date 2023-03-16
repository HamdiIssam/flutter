import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_api/service/authService.dart';
import 'package:quickalert/quickalert.dart';

import 'home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = '';
  String password = '';
  bool isVisible = true;

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login Page', style: GoogleFonts.lato())),
      body: Center(
          child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon(Icons.person),
              Container(
                width: 100,
                height: 100,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage("assets/profile.png"),
                ),
              ),
              SizedBox(height: 40),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 40),
                    child: Text(
                      "Email",
                      style: GoogleFonts.lato(),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 2),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: TextFormField(
                        validator: (e) {
                          if (e!.isEmpty) {
                            return 'Email not found';
                          } else if (!EmailValidator.validate(e)) {
                            return 'Email not valid';
                          }
                        },
                        onChanged: (e) {
                          if (e.isNotEmpty) {
                            email = e;
                          }
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintStyle: TextStyle(fontSize: 13),
                            hintText: "Entrez votre email"),
                      ),
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 40),
                    child: Text('Password', style: GoogleFonts.lato()),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 2),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: TextFormField(
                      obscureText: isVisible,
                      validator: (p) {
                        if (p!.isEmpty) {
                          return 'Password not found ';
                        } else if (p.length < 6) {
                          return 'Password should have 6 characters';
                        }
                      },
                      onChanged: (p) {
                        if (p.isNotEmpty) {
                          password = p;
                        }
                      },
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: isVisible
                                ? Icon(Icons.visibility_off)
                                : Icon(Icons.visibility),
                            onPressed: () {
                              setState(() {
                                isVisible = !isVisible;
                              });
                            },
                          ),
                          border: InputBorder.none,
                          hintStyle: TextStyle(fontSize: 13),
                          hintText: "Entrez votre Password"),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.deepPurple,
                      padding: EdgeInsets.symmetric(horizontal: 50)),
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      // print("User data: ${email} / ${password}");
                      // print(email + ' ' + password);
                      // print(password);

                      try {
                        await AuthService()
                            .login(email, password)
                            .then((value) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MainPage(
                                        title: 'home',
                                      )));
                          QuickAlert.show(
                              context: context,
                              type: QuickAlertType.success,
                              text: 'Vous êtes connecté',
                              confirmBtnText: 'D\'accord',
                              title: 'Succès');
                        });
                      } on FirebaseAuthException catch (e) {
                        if (e.code == "user-not-found") {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("User not found"),
                            backgroundColor: Colors.red,
                          ));
                        } else if (e.code == "wrong-password") {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Wrong password"),
                            backgroundColor: Colors.red,
                          ));
                        } else if (e.code == "network-request-failed") {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("No internet"),
                            backgroundColor: Colors.red,
                          ));
                        }
                      }
                    }
                  },
                  child: Text("Login", style: GoogleFonts.lato())),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Vous avez déja un compte ?',
                    style: TextStyle(fontSize: 10),
                  ),
                  GestureDetector(
                      child: Text(
                    'Cliquez ici',
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline),
                  )),
                ],
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      )),
    );
  }
}
