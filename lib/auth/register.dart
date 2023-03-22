import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_api/http-example/home.dart';
import 'package:my_api/auth/login.dart';
import 'package:my_api/service/authService.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();
  String nom = '';
  String prenom = '';
  String email = '';
  String password = '';
  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Page d\'inscription',
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
              Text('Créer votre compte',
                  style: GoogleFonts.lato(
                      fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 40),
                    child: Text(
                      "Nom",
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
                        validator: (n) {
                          final regex = RegExp(r'^[a-zA-Z0-9]+$');

                          if (n!.isEmpty) {
                            return 'Nom not found';
                          } else if (n.contains(regex) == false) {
                            return 'Ce champ n\'accepte pas les caractères spéciaux';
                          }
                        },
                        onChanged: (n) {
                          if (n.isNotEmpty) {
                            nom = n;
                          }
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintStyle: TextStyle(fontSize: 13),
                            hintText: "Entrez votre nom"),
                      ),
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 40),
                    child: Text(
                      "Prénom",
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
                        validator: (p) {
                          final regex = RegExp(r'^[a-zA-Z0-9]+$');
                          if (p!.isEmpty) {
                            return 'Email not found';
                          } else if (p.contains(regex) == false) {
                            return 'Ce champ n\'accepte pas les caractères spéciaux';
                          }
                        },
                        onChanged: (p) {
                          if (p.isNotEmpty) {
                            prenom = p;
                          }
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintStyle: TextStyle(fontSize: 13),
                            hintText: "Entrez votre prénom"),
                      ),
                    )),
              ),
              SizedBox(
                height: 10,
              ),
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
                    // print(nom);
                    // print(prenom);
                    // print(email);
                    // print(password);
                    if (formKey.currentState!.validate()) {
                      await AuthService()
                          .register(email, password, nom, prenom)
                          .then((value) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                        QuickAlert.show(
                            context: context,
                            type: QuickAlertType.success,
                            text: 'Votre compte a été crée avec succès',
                            confirmBtnText: 'D\'accord',
                            title: 'Félicitations');
                      });
                    }
                  },
                  child: Text("S'inscrire", style: GoogleFonts.lato())),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Avez vous déja un compte? ',
                    style: TextStyle(fontSize: 10),
                  ),
                  GestureDetector(
                    child: Text(
                      'Se connecter',
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline),
                    ),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                  )
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
