import 'package:coffee_shop/views/cart/view/cart_view.dart';
import 'package:coffee_shop/views/orders/viewmodel/order_view_model.dart';
import 'package:coffee_shop/views/product/viewmodel/product_view_model.dart';
import 'package:coffee_shop/views/product/viewmodel/size_button_model.dart';
import 'package:coffee_shop/views/product/viewmodel/syrup_model.dart';
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
    ChangeNotifierProvider(create: (context) => SizeButtonModel()),
    ChangeNotifierProvider(create: (context) => SyrupModel()),
    ChangeNotifierProvider(create: (contex) => ProductViewModel()),
    ChangeNotifierProvider(create: (context) => OrderViewModel()),
  ];
}
