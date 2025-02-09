import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:post_management/models/post.dart';

class ApiService {
  final String baseUrl = "https://jsonplaceholder.typicode.com/posts";

  // A helper method to handle common API response errors
  void _handleError(http.Response response) {
    if (response.statusCode == 400) {
      throw Exception('Bad Request: Invalid data sent');
    } else if (response.statusCode == 404) {
      throw Exception('Not Found: The requested resource could not be found');
    } else if (response.statusCode == 500) {
      throw Exception('Internal Server Error: Please try again later');
    } else {
      throw Exception('Unexpected error: ${response.statusCode}');
    }
  }

  // Fetching posts with error handling
  Future<List<Post>> fetchPosts() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        return (json.decode(response.body) as List).map((data) => Post.fromJson(data)).toList();
      } else {
        _handleError(response);
      }
    } on SocketException {
      throw Exception('No internet connection');
    } catch (e) {
      rethrow;
    }
    throw Exception('Failed to load posts');
  }

  // Creating a post with error handling
  Future<Post> createPost(String title, String body) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        body: json.encode({"title": title, "body": body, "userId": 1}),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 201) {
        return Post.fromJson(json.decode(response.body));
      } else {
        _handleError(response);
      }
    } on SocketException {
      throw Exception('No internet connection');
    } catch (e) {
      rethrow;
    }
    throw Exception('Unexpected error occurred while creating post');
  }

  // Updating a post with error handling
  Future<Post> updatePost(int id, String title, String body) async {
    try {
      final response = await http.put(
        Uri.parse("$baseUrl/$id"),
        body: json.encode({"id": id, "title": title, "body": body, "userId": 1}),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        return Post.fromJson(json.decode(response.body));
      } else {
        _handleError(response);
      }
    } on SocketException {
      throw Exception('No internet connection');
    } catch (e) {
      rethrow;
    }

    throw Exception('Failed to update post');
  }

  // Deleting a post with error handling
  Future<void> deletePost(int id) async {
    try {
      final response = await http.delete(Uri.parse("$baseUrl/$id"));

      if (response.statusCode != 200) {
        _handleError(response);
        throw Exception('Failed to delete post'); // Ensure the method always throws on failure
      }
    } on SocketException {
      throw Exception('No internet connection');
    } catch (e) {
      rethrow; // Rethrow any other error
    }
    throw Exception('Failed to delete post');
  }
}
