import 'package:prosnap/core/router/routes.dart';
import 'package:prosnap/features/auth/views/splash_screen.dart';

import 'package:get/route_manager.dart';

class GetRoutes {
  static List<GetPage> routes = [
    GetPage(name: Routes.splashScreen, page: () => SplashScreen()),
  ];
}
