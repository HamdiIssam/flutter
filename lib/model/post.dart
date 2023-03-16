import 'dart:convert';

List<Post> postModelFromJson(String element )=>
List<Post>.from(json.decode(element).map((x) => Post.fromJson(x)));

String postModelToJson(List<Post> data) =>
   json.encode(List<dynamic>.from(data.map((e) => e.toJson())));

class Post {
  int? userId;
  int id;
  String title;
  String body;

Post({
  this.userId,
  required this.id,
  required this.title,
  required this.body
});

factory Post.fromJson(Map<String , dynamic > json) =>Post(
  userId: json["userId"],
  id:json ["id"],
   title:json ["title"], 
   body:json ["body"]
   );
   Map<String , dynamic > toJson()=> {
"userId":userId,
"id":id,
"title":title,
"body":body

   };
}