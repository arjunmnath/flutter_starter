import '../../../domain/models/post/post.dart';

abstract interface class PostRepository {
  Future<List<Post>> fetchPosts();
}
