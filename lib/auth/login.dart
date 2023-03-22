import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_api/auth/register.dart';
import 'package:my_api/produit/home-produit.dart';
import 'package:my_api/service/authService.dart';
import 'package:quickalert/quickalert.dart';

import '../http-example/home.dart';

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
      appBar: AppBar(
        title: Text(
          'Page de connexion',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueGrey[800],
      ),
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
                            return 'Veuillez entrer votre email';
                          } else if (!EmailValidator.validate(e)) {
                            return 'Email invalide';
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
                    child: Text('Mot de passe', style: GoogleFonts.lato()),
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
                          return 'Veuillez entrer votre mot de passe';
                        } else if (p.length < 6) {
                          return 'Mot de passe doit avoir au moins 6 caractères';
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
                          hintText: "Entrez votre mot de passe"),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.grey[800],
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
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeProduit()));
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
                            content: Text("Cet utilisateur n'existe pas"),
                            backgroundColor: Colors.red,
                          ));
                        } else if (e.code == "wrong-password") {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Mot de passe erroné"),
                            backgroundColor: Colors.red,
                          ));
                        } else if (e.code == "network-request-failed") {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Pas d'internet"),
                            backgroundColor: Colors.red,
                          ));
                        }
                      }
                    }
                  },
                  child: Text("Se connecter", style: GoogleFonts.lato())),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Pas de compte? ',
                    style: TextStyle(fontSize: 10),
                  ),
                  GestureDetector(
                    child: Text(
                      'Cliquez ici',
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterPage()));
                    },
                  ),
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
