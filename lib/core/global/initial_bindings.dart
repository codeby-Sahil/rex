import 'package:prosnap/core/services/api_service.dart';
import 'package:get/instance_manager.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(ApiService());
  }
}
