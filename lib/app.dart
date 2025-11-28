import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'config/dependencies.dart';
import 'data/repositories/auth/auth_repository.dart';
import 'routing/router.dart';
import 'ui/core/localization/app_localizations.dart';
import 'ui/core/theme/app_theme.dart';

class StarterApp extends StatelessWidget {
  const StarterApp({
    super.key,
    required this.environmentName,
    required this.providers,
  });

  final String environmentName;
  final List<SingleChildWidget> providers;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: Builder(
        builder: (context) {
          final authRepository = context.watch<AuthRepository>();
          return MaterialApp.router(
            title: 'Flutter Starter ($environmentName)',
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            routerConfig: createRouter(authRepository),
            localizationsDelegates: AppLocalizations.delegates,
            supportedLocales: AppLocalizations.supportedLocales,
          );
        },
      ),
    );
  }

  /// Helper exposing local providers for tests or CLI tooling.
  static List<SingleChildWidget> localProviders() => providersLocal;

  /// Helper exposing remote providers for tests or CLI tooling.
  static List<SingleChildWidget> remoteProviders() => providersRemote;
}
