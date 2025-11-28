import '../../../domain/models/post/post.dart';
import '../../services/post/service.dart';
import 'post_repository.dart';

class PostRepositoryLocal implements PostRepository {
  const PostRepositoryLocal({required PostService service})
    : _service = service;

  final PostService _service;

  @override
  Future<List<Post>> fetchPosts() async {
    final rawPosts = await _service.fetchPosts();
    return rawPosts.map(Post.fromJson).toList();
  }
}
