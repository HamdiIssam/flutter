import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_api/http-example/detail-post.dart';
import 'package:my_api/auth/login.dart';
import 'package:my_api/service/authService.dart';
import 'package:my_api/service/postService.dart';
import 'package:my_api/service/userService.dart';

import '../model/post.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.title});
  final String title;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Post>? posts;
  bool isLoading = false;
  final user2 = FirebaseAuth.instance.currentUser;

  final FirebaseAuth auth = FirebaseAuth.instance;
  String nom = '', prenom = '', email = '';

  getPostController() async {
    posts = await PostService().getPostService();
    if (posts != null) {
      setState(() {
        isLoading = true;
      });
    }
  }

  Future<User>? getUserById() {
    final user = auth.currentUser;
    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .snapshots()
        .listen((data) {
      if (mounted) {
        setState(() {
          nom = data.data()!['nom'];
          prenom = data.data()!['prenom'];
          email = data.data()!['email'];
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getPostController();
    getUserById();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
              onPressed: () async {
                await AuthService().logout();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Column(
        children: [
          Text(
            '${nom} ${prenom}',
            style: TextStyle(color: Colors.black),
          ),
          Text(email),
          Text(user2!.email!),
          Visibility(
            visible: isLoading,
            replacement: Center(child: CircularProgressIndicator()),
            child: Center(
              child: Container(
                height: 600,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    // print('aaaaaaa');
                    // print(posts!.length);
                    return ListTile(
                        leading: Icon(Icons.abc),
                        trailing: GestureDetector(
                          child: Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        DetailPost(postId: posts![index].id)));
                          },
                        ),
                        title: Text(
                          posts![index].title,
                          style: TextStyle(fontSize: 12),
                        ),
                        subtitle: Text(
                          posts![index].body,
                          style: TextStyle(fontSize: 8),
                        ));
                  },
                  itemCount: posts?.length,
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add
            // size: 12,

            ),
      ),
    );
  }
}
