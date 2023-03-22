import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:my_api/service/produitService.dart';

class DetailProduit extends StatefulWidget {
  const DetailProduit(
      {super.key,
      required this.nom,
      required this.reference,
      required this.description,
      required this.prix,
      required this.famille,
      required this.imageUrl});
  final String nom;
  final int reference;
  final String description;
  final double prix;
  final String famille;
  final String imageUrl;

  @override
  State<DetailProduit> createState() => _DetailProduitState();
}

class _DetailProduitState extends State<DetailProduit> {
  // getProduits() {
  //   return ProduitService().getProduitById('mmY52ltXMFunXzXBh67k');
  // }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text(
          'Détails du produit',
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.imageUrl),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.nom,
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Référence: ${widget.reference}',
                        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                      ),
                      SizedBox(height: 16),
                      Text(
                        widget.description,
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Text(
                            'Prix:',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 8),
                          Text(
                            '${widget.prix} €',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Famille: ${widget.famille}',
                        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
