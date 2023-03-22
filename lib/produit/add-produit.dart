import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_api/produit/home-produit.dart';
import 'package:my_api/service/produitService.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class AddProduit extends StatefulWidget {
  const AddProduit({super.key});

  @override
  State<AddProduit> createState() => _AddProduitState();
}

class _AddProduitState extends State<AddProduit> {
  final formKey = GlobalKey<FormState>();
  String nom = '';
  String reference = '';
  String description = '';
  String prix = '';
  String? _selectedFamille;
  final familles = ["Boissons", "Fruits", "Légumes", "Fast Food"];
  String imgUrl = '';
  UploadTask? uploadTask;
  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(item),
      );

  @override
  Widget build(BuildContext context) {
    Widget buildProgess() => StreamBuilder<TaskSnapshot>(
        stream: uploadTask?.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!;
            double prog = data.bytesTransferred / data.totalBytes;
            return SizedBox(
              height: 30,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  LinearProgressIndicator(
                    value: prog,
                    color: Colors.deepPurple,
                  ),
                  Center(
                    child: Text(
                      'Téléchargement:${(prog * 100).roundToDouble()}%',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            );
          } else {
            return Text('');
          }
        });

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ajouter un produit',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueGrey[800],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Nom",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[200]),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TextFormField(
                        validator: (n) {
                          final regex = RegExp(r'^[a-zA-Z\s]+$');

                          if (n!.isEmpty) {
                            return 'Ce champ ne doit pas être vide';
                          } else if (n.contains(regex) == false) {
                            return 'Ce champ n\'accepte pas les caractères spéciaux et les chiffres';
                          }
                        },
                        onChanged: (n) {
                          if (n.isNotEmpty) {
                            nom = n;
                          }
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Nom du produit',
                            hintStyle: TextStyle(fontSize: 14)),
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Réference",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[200]),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TextFormField(
                        validator: (r) {
                          final regex = RegExp(r'^[0-9]+$');

                          if (r!.isEmpty) {
                            return 'Ce champ ne doit pas être vide';
                          } else if (r.contains(regex) == false) {
                            return 'Ce champ n\'accepte pas les caractères spéciaux et les chiffres';
                          }
                        },
                        onChanged: (r) {
                          if (r.isNotEmpty) {
                            reference = r;
                          }
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Réference du produit',
                            hintStyle: TextStyle(fontSize: 14)),
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Description",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[200]),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TextFormField(
                        maxLines: 2,
                        validator: (d) {
                          final regex = RegExp(r'^[a-zA-Z\s]+$');

                          if (d!.isEmpty) {
                            return 'Ce champ ne doit pas être vide';
                          } else if (d.contains(regex) == false) {
                            return 'Ce champ n\'accepte pas les caractères spéciaux et les chiffres';
                          }
                        },
                        onChanged: (n) {
                          if (n.isNotEmpty) {
                            description = n;
                          }
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Description du produit',
                            hintStyle: TextStyle(fontSize: 14)),
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Prix",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[200]),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TextFormField(
                        validator: (p) {
                          final regex = RegExp(r'^[0-9]+.[0-9]+$');

                          if (p!.isEmpty) {
                            return 'Ce champ ne doit pas être vide';
                          } else if (p.contains(regex) == false) {
                            return 'Ce champ n\'accepte pas les caractères spéciaux et les chiffres';
                          }
                        },
                        onChanged: (p) {
                          if (p.isNotEmpty) {
                            prix = p;
                          }
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Prix du produit',
                            hintStyle: TextStyle(fontSize: 14)),
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Famille",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.grey[200],
                    ),
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                            value: _selectedFamille,
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedFamille = newValue;
                              });
                            },
                            items: familles.map((famille) {
                              return DropdownMenuItem(
                                value: famille,
                                child: Text(
                                  famille,
                                  style: TextStyle(fontSize: 14),
                                ),
                              );
                            }).toList(),
                          ),
                        )),
                  ),
                  SizedBox(height: 14),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12)),
                    child: IconButton(
                      icon: Icon(
                        Icons.image,
                        color: Colors.grey[800],
                      ),
                      onPressed: () async {
                        ImagePicker imagePicker = ImagePicker();
                        XFile? file = await imagePicker.pickImage(
                            source: ImageSource.gallery);

                        if (file == null) return;

                        Reference referenceRoot =
                            FirebaseStorage.instance.ref();
                        Reference dirImages =
                            referenceRoot.child("produits_images");
                        Reference imgToUpload = dirImages.child(file.name);

                        try {
                          await imgToUpload.putFile(File(file.path));
                          setState(() {
                            uploadTask = imgToUpload.putFile(File(file.path));
                          });

                          var x = imgUrl = await imgToUpload.getDownloadURL();
                          imgUrl = x;
                        } catch (e) {}
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  buildProgess(),
                  SizedBox(height: 20),
                  Container(
                    width: 150,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          if (imgUrl == null || imgUrl.isEmpty) {
                            QuickAlert.show(
                                context: context,
                                type: QuickAlertType.error,
                                text: 'Erreur de téléchargement de l\'image ',
                                confirmBtnText: 'Okay',
                                title: 'Erreur');
                          } else {
                            await ProduitService().addProduitService(
                                nom,
                                int.parse(reference),
                                description,
                                double.parse(prix),
                                _selectedFamille!,
                                imgUrl);
                            /* Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeProduit())); */
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => HomeProduit()));
                            QuickAlert.show(
                                context: context,
                                type: QuickAlertType.success,
                                text: 'Produit ajouté',
                                confirmBtnText: 'Okay',
                                title: 'Succès');
                          }
                        }
                      },
                      child: Text("Ajouter"),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[800]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
