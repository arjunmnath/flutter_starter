import 'package:flutter/foundation.dart';

import '../../../domain/models/post/post.dart';
import '../../../domain/use_cases/post/fetch_posts_use_case.dart';

class PostsViewModel extends ChangeNotifier {
  PostsViewModel({required FetchPostsUseCase fetchPostsUseCase})
    : _fetchPostsUseCase = fetchPostsUseCase;

  final FetchPostsUseCase _fetchPostsUseCase;

  List<Post> _posts = const [];
  bool _isLoading = false;
  String? _error;

  List<Post> get posts => _posts;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadPosts() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _posts = await _fetchPostsUseCase.execute();
    } catch (error, stackTrace) {
      _error = 'Something went wrong.';
      debugPrint('Failed to load posts: $error\n$stackTrace');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
