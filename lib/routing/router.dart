import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../data/repositories/auth/auth_repository.dart';
import '../ui/auth/viewmodel/auth_view_model.dart';
import '../ui/auth/widgets/login_screen.dart';
import '../ui/posts/viewmodel/posts_view_model.dart';
import '../ui/posts/widgets/posts_screen.dart';
import 'routes.dart';

GoRouter createRouter(AuthRepository authRepository) => GoRouter(
  initialLocation: Routes.posts,
  debugLogDiagnostics: true,
  refreshListenable: authRepository,
  redirect: (context, state) => _redirect(context, state, authRepository),
  routes: [
    GoRoute(
      path: Routes.login,
      builder: (context, state) =>
          LoginScreen(viewModel: AuthViewModel(authRepository: context.read())),
    ),
    GoRoute(
      path: Routes.posts,
      builder: (context, state) => PostsScreen(
        viewModel: PostsViewModel(fetchPostsUseCase: context.read()),
      ),
    ),
  ],
);

String? _redirect(
  BuildContext context,
  GoRouterState state,
  AuthRepository authRepository,
) {
  final loggedIn = authRepository.isAuthenticated;
  final loggingIn = state.matchedLocation == Routes.login;

  if (!loggedIn && !loggingIn) {
    return Routes.login;
  }

  if (loggedIn && loggingIn) {
    return Routes.posts;
  }

  return null;
}
