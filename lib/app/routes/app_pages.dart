import 'package:get/get.dart';

import '../../features/expense_tracker/views/expense_tracker_view.dart';

class AppRoutes {
  static const expenseTracker = '/';
}

class AppPages {
  static const initial = AppRoutes.expenseTracker;

  static final routes = <GetPage<dynamic>>[
    GetPage<dynamic>(
      name: AppRoutes.expenseTracker,
      page: ExpenseTrackerView.new,
    ),
  ];
}
