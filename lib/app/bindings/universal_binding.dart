import 'package:get/get.dart';

import '../../features/expense_tracker/bindings/expense_tracker_binding.dart';

class UniversalBinding extends Bindings {
  @override
  void dependencies() {
    ExpenseTrackerBinding().dependencies();
  }
}
