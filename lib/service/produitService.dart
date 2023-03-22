import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProduitService {
  final user = FirebaseAuth.instance.currentUser;
  Future<void> addProduitService(String nom, int reference, String description,
      double prix, String famille, String imgUrl) async {
    return await FirebaseFirestore.instance.collection('produits').doc().set({
      "nom": nom,
      "reference": reference,
      "description": description,
      "prix": prix,
      "famille": famille,
      "imageUrl": imgUrl,
      "userId": user!.uid,
      "created_at": DateTime.now()
    });
  }

// void getProduitById(String productId) async {
//     await FirebaseFirestore.instance
//         .collection('products')
//         .get().then((DocumentSnapshot documentSnapshot) async {
//           if(documentSnapshot.exists){
//             var data=documentSnapshot.data();
//           }
//         });
//   }
}
