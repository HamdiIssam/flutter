import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_api/model/post.dart';
import 'dart:convert';

class PostService {
  var baseUrl = Uri.parse("https://jsonplaceholder.typicode.com/posts");
  Future<List<Post>?> getPostService() async {
    var response = await http.get(baseUrl);
    if (response.statusCode == 200) {
      var json = response.body;
      return postModelFromJson(json);
    }
  }

  Future<Post>? getPostById(int id) async {
    var response = await http
        .get(Uri.parse("https://jsonplaceholder.typicode.com/posts/$id"));
    if (response.statusCode == 200) {
      // var json=response.body;
    }
    return Post.fromJson(jsonDecode(response.body));
  }
}
