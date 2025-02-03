import 'dart:convert';

import 'package:machine_test_practice2/models/post_model.dart';
import 'package:http/http.dart' as http;

class PostRepostiory {
  Future<List<PostModel>> fetchPosts() async {
    try {
      final response = await http
          .get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));

      if (response.statusCode == 200) {
        List<PostModel> fetchedPosts = (json.decode(response.body) as List)
            .map((post) => PostModel.fromJson(post))
            .toList();

        return fetchedPosts;
      } else {
        throw Exception("Failed to fetch posts");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
