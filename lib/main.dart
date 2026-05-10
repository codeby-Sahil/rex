import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/bindings/universal_binding.dart';
import 'app/routes/app_pages.dart';
import 'app/theme/app_theme.dart';

void main() {
  runApp(const VexApp());
}

class VexApp extends StatelessWidget {
  const VexApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Vex',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      initialBinding: UniversalBinding(),
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
    );
  }
}
