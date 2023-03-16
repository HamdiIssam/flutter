import 'package:flutter/material.dart';
import 'package:my_api/model/post.dart';
import 'package:my_api/service/postService.dart';

class DetailPost extends StatefulWidget {
  const DetailPost({super.key, required this.postId});
  final int postId;

  @override
  State<DetailPost> createState() => _DetailPostState();
}

class _DetailPostState extends State<DetailPost> {
  Post? poste;
  bool isLoading = false;
  int? id;
  String desc = "";
  String titer ='';

  getPostByIdController(int id) async {
    poste = await PostService().getPostById(id);

    if (poste != null) {
      setState(() {
        desc = poste!.body;
        titer =poste!.title;
        isLoading = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getPostByIdController(widget.postId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Visibility(
          visible: isLoading,
          replacement: Center(child: CircularProgressIndicator()),

          child: Center(child: Column(
            children: [
              Text(desc),
              Text(titer)
            ],
          ))),
    );
  }
}
