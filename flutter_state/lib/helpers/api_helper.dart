import 'dart:convert';

import 'package:flutter_state/models/album.dart';
import 'package:flutter_state/models/comment.dart';
import 'package:flutter_state/models/post.dart';
import 'package:flutter_state/models/user.dart';
import 'package:http/http.dart' as http;

class APIHelper {
  
  // Posts getirme
  static Future<List<Post>> getPosts(int start) async {
    String url =
        "https://jsonplaceholder.typicode.com/posts?_start=$start&_limit=5 ";
    var response = await http.get(url);

    List<Post> posts = [];

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);

      jsonData.forEach((o) {
        Post post = Post.fromObject(o);
        posts.add(post);
      });

      return posts;
    } else {
      throw Exception("Error");
    }
  }

  // id ye göre post getirme
  static Future<Post> getPostById(int id) async {
    String url = "https://jsonplaceholder.typicode.com/posts/$id";
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      Post post = Post.fromObject(jsonData);
      return post;
    } else {
      throw Exception("Error");
    }
  }

  //id ye göre comment getirme
  static Future<List<Comment>> getCommentById(int id, int start) async {
    String url =
        "https://jsonplaceholder.typicode.com/posts/$id/comments?_start=$start&_limit=3";
    var response = await http.get(url);

    List<Comment> comments = [];

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);

      jsonData.forEach((o) {
        Comment comment = Comment.fromObject(o);
        comments.add(comment);
      });

      return comments;
    } else {
      throw Exception("Error");
    }
  }

  //User getirme
  static Future<List<User>> getAllUser(int start) async {
    String url =
        "https://jsonplaceholder.typicode.com/users?_start=$start&_limit=5";
    var response = await http.get(url);

    List<User> users = [];

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);

      jsonData.forEach((o) {
        User user = User.fromObject(o);
        users.add(user);
      });

      return users;
    } else {
      throw Exception("Error");
    }
  }

  //tüm albümleri getirme
  static Future<List<Album>> getAllAlbums() async {
    String url = "https://jsonplaceholder.typicode.com/albums";
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List<Album> albums = [];
      var jsonData = jsonDecode(response.body);

      jsonData.forEach((o) {
        Album album = Album.fromObject(o);
        albums.add(album);
      });

      return albums;
    } else {
      throw Exception("Error");
    }
  }

  // tüm postları getirme
  static Future<List<Post>> getAllPost() async {
    String url = "https://jsonplaceholder.typicode.com/posts";
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List<Post> posts = [];
      var jsonData = jsonDecode(response.body);

      jsonData.forEach((o) {
        Post post = Post.fromObject(o);
        posts.add(post);
      });

      return posts;
    } else {
      throw Exception("Error");
    }
  }
}
