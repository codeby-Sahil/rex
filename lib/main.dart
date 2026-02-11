import 'package:dio_get/core/global/initial_bindings.dart';
import 'package:dio_get/core/router/router.dart';
import 'package:dio_get/core/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  runApp(MealsDB());
}

class MealsDB extends StatelessWidget {
  const MealsDB({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.homeScreen,
      initialBinding: InitialBindings(),
      getPages: GetRoutes.routes,
    );
  }
}
