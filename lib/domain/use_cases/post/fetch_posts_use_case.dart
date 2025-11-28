import '../../../data/repositories/post/post_repository.dart';
import '../../models/post/post.dart';

class FetchPostsUseCase {
  const FetchPostsUseCase({required PostRepository repository})
    : _repository = repository;

  final PostRepository _repository;

  Future<List<Post>> execute() => _repository.fetchPosts();
}
