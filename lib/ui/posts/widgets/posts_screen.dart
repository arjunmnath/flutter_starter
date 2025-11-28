import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/post/post.dart';
import '../../../utils/example_util.dart';
import '../../core/components/info_banner.dart';
import '../viewmodel/posts_view_model.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key, required this.viewModel});

  final PostsViewModel viewModel;

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.loadPosts();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: widget.viewModel,
      child: Consumer<PostsViewModel>(
        builder: (context, viewModel, _) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Posts'),
              actions: [
                IconButton(
                  onPressed: viewModel.isLoading ? null : viewModel.loadPosts,
                  icon: const Icon(Icons.refresh),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const InfoBanner(
                    message:
                        'This screen fetches data from JSONPlaceholder via MVVM.',
                  ),
                  const SizedBox(height: 24),
                  Expanded(child: _PostsList(viewModel: viewModel)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _PostsList extends StatelessWidget {
  const _PostsList({required this.viewModel});

  final PostsViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    if (viewModel.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (viewModel.error != null) {
      return Center(child: Text(viewModel.error!));
    }

    if (viewModel.posts.isEmpty) {
      return const Center(child: Text('No posts available.'));
    }

    return ListView.separated(
      itemCount: viewModel.posts.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final post = viewModel.posts[index];
        return _PostTile(post: post);
      },
    );
  }
}

class _PostTile extends StatelessWidget {
  const _PostTile({required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      tileColor: scheme.surfaceContainerHighest,
      title: Text(post.title),
      subtitle: Text(ellipsize(post.body)),
    );
  }
}
