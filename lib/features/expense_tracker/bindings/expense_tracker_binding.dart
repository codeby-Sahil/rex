import 'package:get/get.dart';

import '../controllers/expense_tracker_controller.dart';

class ExpenseTrackerBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<ExpenseTrackerController>()) {
      Get.lazyPut<ExpenseTrackerController>(ExpenseTrackerController.new);
    }
  }
}
