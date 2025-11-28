import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../data/repositories/auth/auth_repository.dart';
import '../data/repositories/auth/auth_repository_dev.dart';
import '../data/repositories/auth/auth_repository_remote.dart';
import '../data/repositories/post/post_repository.dart';
import '../data/repositories/post/post_repository_local.dart';
import '../data/repositories/post/post_repository_remote.dart';
import '../data/services/post/service.dart';
import '../domain/use_cases/post/fetch_posts_use_case.dart';

List<SingleChildWidget> get providersLocal => [
  ChangeNotifierProvider<AuthRepository>(create: (_) => AuthRepositoryDev()),
  Provider<PostService>(create: (_) => const PostServiceLocal()),
  Provider<PostRepository>(
    create: (context) => PostRepositoryLocal(service: context.read()),
  ),
  Provider<FetchPostsUseCase>(
    create: (context) => FetchPostsUseCase(repository: context.read()),
  ),
];

List<SingleChildWidget> get providersRemote => [
  ChangeNotifierProvider<AuthRepository>(create: (_) => AuthRepositoryRemote()),
  Provider<PostService>(create: (_) => PostServiceRemote()),
  Provider<PostRepository>(
    create: (context) => PostRepositoryRemote(service: context.read()),
  ),
  Provider<FetchPostsUseCase>(
    create: (context) => FetchPostsUseCase(repository: context.read()),
  ),
];
