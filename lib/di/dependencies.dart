import 'package:provider/single_child_widget.dart';

import 'modules/auth_module.dart';
import 'modules/post_module.dart';

List<SingleChildWidget> get providersLocal => [
  ...authLocalModule(),
  ...postLocalModule(),
];

List<SingleChildWidget> get providersRemote => [
  ...authRemoteModule(),
  ...postRemoteModule(),
];
