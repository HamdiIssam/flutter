import 'package:flutter/material.dart';
import 'package:my_api/detail-post.dart';
import 'package:my_api/login.dart';
import 'package:my_api/service/authService.dart';
import 'package:my_api/service/postService.dart';

import 'model/post.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.title});
  final String title;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Post>? posts;
  bool isLoading = false;

  getPostController() async {
    posts = await PostService().getPostService();
    if (posts != null) {
      setState(() {
        isLoading = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getPostController();
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
      body: Visibility(
        visible: isLoading,
        replacement: Center(child: CircularProgressIndicator()),
        child: Center(
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add
            // size: 12,

            ),
      ),
    );
  }
}
