import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../services/auth/auth_service.dart';
import '../views/home/viewmodel/home_view_model.dart';

class ProviderManager {
  static ProviderManager? _instance;
  static ProviderManager get instance {
    _instance ??= ProviderManager._init();
    return _instance!;
  }

  ProviderManager._init();

  List<SingleChildWidget> providers = [
    ChangeNotifierProvider(create: (context) => AuthService()),
    ChangeNotifierProvider(create: (context) => HomeViewModel()),
  ];
}
