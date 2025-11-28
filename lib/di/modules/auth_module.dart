import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../data/repositories/auth/auth_repository.dart';
import '../../data/repositories/auth/auth_repository_dev.dart';
import '../../data/repositories/auth/auth_repository_remote.dart';

List<SingleChildWidget> authLocalModule() => [
  ChangeNotifierProvider<AuthRepository>(create: (_) => AuthRepositoryDev()),
];

List<SingleChildWidget> authRemoteModule() => [
  ChangeNotifierProvider<AuthRepository>(create: (_) => AuthRepositoryRemote()),
];

