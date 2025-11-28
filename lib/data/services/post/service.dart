import 'dart:convert';

import 'package:http/http.dart' as http;

/// Defines the contract for retrieving posts.
abstract interface class PostService {
  Future<List<Map<String, dynamic>>> fetchPosts();
}

/// Remote implementation targeting JSONPlaceholder.
class PostServiceRemote implements PostService {
  PostServiceRemote({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  @override
  Future<List<Map<String, dynamic>>> fetchPosts() async {
    final response = await _client.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts/'),
      headers: {
        'Accept': 'application/json',
        // optionally add a benign User-Agent to avoid some basic bot blocks:
        'User-Agent': 'MyApp/1.0 (flutter)',
      },
    );
    print(response.statusCode);
    if (response.statusCode != 200) {
      throw const FormatException('Failed to download posts');
    }

    final decoded = jsonDecode(response.body) as List<dynamic>;
    return decoded
        .cast<Map<String, dynamic>>()
        .map((post) => Map<String, dynamic>.from(post))
        .toList();
  }
}

/// Local implementation used by the development entrypoint.
class PostServiceLocal implements PostService {
  const PostServiceLocal();

  @override
  Future<List<Map<String, dynamic>>> fetchPosts() async {
    return const [
      {
        'id': 1,
        'title': 'Local post',
        'body': 'Loaded from PostServiceLocal to support offline dev work.',
      },
    ];
  }
}
