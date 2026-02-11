import 'package:dio_get/core/router/routes.dart';
import 'package:dio_get/features/home/bindings/home_bindings.dart';
import 'package:dio_get/features/home/views/home_screen.dart';
import 'package:get/route_manager.dart';

class GetRoutes {
  static List<GetPage> routes = [
    GetPage(
      name: Routes.homeScreen,
      page: () => HomeScreen(),
      binding: HomeBindings(),
    ),
  ];
}
