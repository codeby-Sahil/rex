import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/expense_models.dart';

class ExpenseTrackerController extends GetxController {
  final RxInt _currentMonthIndex = 0.obs;
  final selectedTab = TrackerTab.ledger.obs;
  final selectedFilter = 'All'.obs;
  final entryType = EntryType.expense.obs;
  final isComposerOpen = false.obs;
  final isExportOpen = false.obs;
  final recurring = false.obs;
  final selectedCategory = 'Food'.obs;

  final amountController = TextEditingController();
  final descriptionController = TextEditingController();

  int _nextId = 100;

  final List<MonthData> months = <MonthData>[
    MonthData(
      label: 'APR 2025',
      entries: <TransactionEntry>[
        TransactionEntry(id: 1, type: EntryType.income, category: 'Salary', description: 'Monthly salary', amount: 85000, dateLabel: '01 APR', isRecurring: true),
        TransactionEntry(id: 2, type: EntryType.expense, category: 'Bills', description: 'Electricity', amount: 2400, dateLabel: '03 APR', isRecurring: true),
        TransactionEntry(id: 3, type: EntryType.expense, category: 'Food', description: 'Groceries', amount: 3200, dateLabel: '05 APR', isRecurring: false),
        TransactionEntry(id: 4, type: EntryType.expense, category: 'Transport', description: 'Metro pass', amount: 1500, dateLabel: '06 APR', isRecurring: true),
        TransactionEntry(id: 5, type: EntryType.expense, category: 'Fun', description: 'Netflix', amount: 649, dateLabel: '08 APR', isRecurring: true),
        TransactionEntry(id: 6, type: EntryType.expense, category: 'Food', description: 'Pizza night', amount: 980, dateLabel: '11 APR', isRecurring: false),
      ],
    ),
    MonthData(
      label: 'MAR 2025',
      entries: <TransactionEntry>[
        TransactionEntry(id: 10, type: EntryType.income, category: 'Salary', description: 'Monthly salary', amount: 85000, dateLabel: '01 MAR', isRecurring: true),
        TransactionEntry(id: 11, type: EntryType.expense, category: 'Bills', description: 'Electricity', amount: 2200, dateLabel: '03 MAR', isRecurring: true),
        TransactionEntry(id: 12, type: EntryType.expense, category: 'Shopping', description: 'New shoes', amount: 4500, dateLabel: '10 MAR', isRecurring: false),
        TransactionEntry(id: 13, type: EntryType.expense, category: 'Food', description: 'Restaurant', amount: 2100, dateLabel: '15 MAR', isRecurring: false),
        TransactionEntry(id: 14, type: EntryType.expense, category: 'Fun', description: 'Concert', amount: 1800, dateLabel: '20 MAR', isRecurring: false),
      ],
    ),
    MonthData(
      label: 'FEB 2025',
      entries: <TransactionEntry>[
        TransactionEntry(id: 20, type: EntryType.income, category: 'Salary', description: 'Monthly salary', amount: 85000, dateLabel: '01 FEB', isRecurring: true),
        TransactionEntry(id: 21, type: EntryType.expense, category: 'Health', description: 'Gym membership', amount: 1200, dateLabel: '02 FEB', isRecurring: true),
        TransactionEntry(id: 22, type: EntryType.expense, category: 'Food', description: 'Groceries', amount: 2900, dateLabel: '06 FEB', isRecurring: false),
        TransactionEntry(id: 23, type: EntryType.expense, category: 'Shopping', description: 'Electronics', amount: 8500, dateLabel: '14 FEB', isRecurring: false),
      ],
    ),
  ];

  final List<QuickAction> quickActions = <QuickAction>[
    QuickAction(label: 'Coffee', category: 'Food', amount: 80, icon: Icons.coffee_outlined),
    QuickAction(label: 'Cab', category: 'Transport', amount: 200, icon: Icons.local_taxi_outlined),
    QuickAction(label: 'Lunch', category: 'Food', amount: 250, icon: Icons.lunch_dining_outlined),
    QuickAction(label: 'Bill', category: 'Bills', amount: 500, icon: Icons.bolt_outlined),
    QuickAction(label: 'Movie', category: 'Fun', amount: 350, icon: Icons.movie_outlined),
  ];

  final List<BudgetLimit> budgets = <BudgetLimit>[
    BudgetLimit(category: 'Food', limit: 5000),
    BudgetLimit(category: 'Transport', limit: 2000),
    BudgetLimit(category: 'Shopping', limit: 3000),
    BudgetLimit(category: 'Fun', limit: 1500),
    BudgetLimit(category: 'Health', limit: 2000),
    BudgetLimit(category: 'Bills', limit: 4000),
  ];

  final Map<String, IconData> categoryIcons = <String, IconData>{
    'Food': Icons.fastfood_outlined,
    'Transport': Icons.directions_bus_outlined,
    'Shopping': Icons.shopping_bag_outlined,
    'Fun': Icons.sports_esports_outlined,
    'Health': Icons.medication_outlined,
    'Bills': Icons.flash_on_outlined,
    'Salary': Icons.work_outline,
    'Other': Icons.auto_awesome_outlined,
  };

  final Map<String, Color> categoryBackgrounds = <String, Color>{
    'Food': const Color(0x1FFF9A1E),
    'Transport': const Color(0x1900F5D4),
    'Shopping': const Color(0x1FC864FF),
    'Fun': const Color(0x1F508CFF),
    'Health': const Color(0x19FF4F6D),
    'Bills': const Color(0x19FFDC32),
    'Salary': const Color(0x19B5FF5A),
    'Other': const Color(0x199D4EDD),
  };

  final Map<String, Color> categoryChartColors = <String, Color>{
    'Food': const Color(0x99FFB432),
    'Transport': const Color(0x9900F5D4),
    'Shopping': const Color(0x99C864FF),
    'Fun': const Color(0x99508CFF),
    'Health': const Color(0x99FF4F6D),
    'Bills': const Color(0x99FFDC32),
    'Salary': const Color(0x99B5FF5A),
    'Other': const Color(0x999D4EDD),
  };

  MonthData get currentMonth => months[_currentMonthIndex.value];

  List<String> get filters => <String>[
        'All',
        ...currentMonth.entries.map((entry) => entry.category).toSet(),
      ];

  List<TransactionEntry> get filteredTransactions {
    final filter = selectedFilter.value;
    final items = filter == 'All'
        ? currentMonth.entries
        : currentMonth.entries.where((entry) => entry.category == filter).toList();
    return items.reversed.take(7).toList();
  }

  double get incomeTotal => _sumByType(EntryType.income);

  double get expenseTotal => _sumByType(EntryType.expense);

  double get balance => incomeTotal - expenseTotal;

  int get recurringCommitment => currentMonth.entries
      .where((entry) => entry.isRecurring && entry.type == EntryType.expense)
      .fold<int>(0, (sum, entry) => sum + entry.amount.round());

  String get burnPerDayLabel {
    if (expenseTotal == 0) {
      return '-';
    }
    final burn = (expenseTotal / DateTime.now().day.clamp(1, 31)).round();
    return '$rupeeSymbol${formatAmount(burn.toDouble())}/d';
  }

  String get runwayLabel {
    if (expenseTotal == 0 || incomeTotal == 0) {
      return 'INF';
    }
    final burn = (expenseTotal / DateTime.now().day.clamp(1, 31)).round();
    if (burn <= 0) {
      return 'INF';
    }
    final runway = (balance / burn).floor();
    return runway > 999 ? 'INF' : '${runway}d';
  }

  Map<String, double> get spendingByCategory {
    final map = <String, double>{};
    for (final entry in currentMonth.entries.where((item) => item.type == EntryType.expense)) {
      map.update(entry.category, (value) => value + entry.amount, ifAbsent: () => entry.amount);
    }
    final sortedEntries = map.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return Map<String, double>.fromEntries(sortedEntries);
  }

  String? get topSpendCategory => spendingByCategory.isEmpty ? null : spendingByCategory.keys.first;

  String get insightText {
    final spendRatio = incomeTotal == 0 ? 0 : ((expenseTotal / incomeTotal) * 100).round();
    if (spendRatio > 80) {
      return 'ALERT // SPENDING $spendRatio% OF INCOME';
    }
    if (spendRatio > 50) {
      return 'SPENDING $spendRatio% OF INCOME';
    }
    final top = topSpendCategory;
    if (top != null) {
      return '${top.toUpperCase()} IS TOP SPEND THIS MONTH';
    }
    return 'ALL SYSTEMS NOMINAL';
  }

  String get exportReport {
    final lines = <String>[
      '// WALLET_OS - MONTHLY REPORT',
      '// PERIOD: ${currentMonth.label}',
      '--------------------',
      'INCOME    $rupeeSymbol${formatAmount(incomeTotal)}',
      'EXPENSES  $rupeeSymbol${formatAmount(expenseTotal)}',
      'BALANCE   $rupeeSymbol${formatAmount(balance)}',
      '--------------------',
      'CATEGORY BREAKDOWN:',
      ...spendingByCategory.entries.map(
        (entry) => '  ${entry.key.padRight(12)}$rupeeSymbol${formatAmount(entry.value)}',
      ),
      '--------------------',
      'EXPORT GENERATED // WALLET_OS',
    ];
    return lines.join('\n');
  }

  @override
  void onClose() {
    amountController.dispose();
    descriptionController.dispose();
    super.onClose();
  }

  void shiftMonth(int direction) {
    _currentMonthIndex.value = (_currentMonthIndex.value + direction).clamp(0, months.length - 1);
    selectedFilter.value = 'All';
    update();
  }

  void switchTab(TrackerTab tab) {
    selectedTab.value = tab;
  }

  void setFilter(String filter) {
    selectedFilter.value = filter;
  }

  void toggleComposer() {
    isComposerOpen.toggle();
    if (!isComposerOpen.value) {
      _resetComposer();
    }
  }

  void toggleExport() {
    isExportOpen.toggle();
  }

  void setEntryType(EntryType type) {
    entryType.value = type;
  }

  void setCategory(String category) {
    selectedCategory.value = category;
  }

  void setRecurring(bool value) {
    recurring.value = value;
  }

  void quickAdd(QuickAction action) {
    currentMonth.entries.add(
      TransactionEntry(
        id: _nextId++,
        type: EntryType.expense,
        category: action.category,
        description: action.label,
        amount: action.amount,
        dateLabel: _buildDateLabel(),
        isRecurring: false,
      ),
    );
    selectedFilter.value = 'All';
    update();
    _showToast('// ${action.label.toUpperCase()}_LOGGED');
  }

  void saveEntry() {
    final amount = double.tryParse(amountController.text.trim());
    final description = descriptionController.text.trim();
    if (amount == null || amount <= 0 || description.isEmpty) {
      return;
    }

    currentMonth.entries.add(
      TransactionEntry(
        id: _nextId++,
        type: entryType.value,
        category: selectedCategory.value,
        description: description,
        amount: amount,
        dateLabel: _buildDateLabel(),
        isRecurring: recurring.value,
      ),
    );

    selectedFilter.value = 'All';
    isComposerOpen.value = false;
    _resetComposer();
    update();
    _showToast('// TX_LOGGED - CONFIRMED');
  }

  String formatAmount(double value) {
    final rounded = value.round();
    final digits = rounded.abs().toString();
    if (digits.length <= 3) {
      return rounded.toString();
    }

    final lastThree = digits.substring(digits.length - 3);
    var rest = digits.substring(0, digits.length - 3);
    final chunks = <String>[];

    while (rest.length > 2) {
      chunks.insert(0, rest.substring(rest.length - 2));
      rest = rest.substring(0, rest.length - 2);
    }

    if (rest.isNotEmpty) {
      chunks.insert(0, rest);
    }

    final result = '${chunks.join(',')},$lastThree';
    return rounded.isNegative ? '-$result' : result;
  }

  double budgetSpent(String category) {
    return currentMonth.entries
        .where((entry) => entry.type == EntryType.expense && entry.category == category)
        .fold<double>(0, (sum, entry) => sum + entry.amount);
  }

  double budgetProgress(String category, double limit) {
    if (limit == 0) {
      return 0;
    }
    return (budgetSpent(category) / limit).clamp(0, 1);
  }

  Color budgetColor(String category, double limit) {
    final progress = budgetProgress(category, limit);
    if (progress >= 1) {
      return const Color(0xFFFF4F6D);
    }
    if (progress >= 0.75) {
      return const Color(0xFFFFDC32);
    }
    return const Color(0xFF00F5D4);
  }

  double _sumByType(EntryType type) {
    return currentMonth.entries
        .where((entry) => entry.type == type)
        .fold<double>(0, (sum, entry) => sum + entry.amount);
  }

  String _buildDateLabel() {
    const months = <String>[
      'JAN',
      'FEB',
      'MAR',
      'APR',
      'MAY',
      'JUN',
      'JUL',
      'AUG',
      'SEP',
      'OCT',
      'NOV',
      'DEC',
    ];
    final now = DateTime.now();
    return '${now.day.toString().padLeft(2, '0')} ${months[now.month - 1]}';
  }

  void _resetComposer() {
    amountController.clear();
    descriptionController.clear();
    recurring.value = false;
    selectedCategory.value = 'Food';
    entryType.value = EntryType.expense;
  }

  void _showToast(String message) {
    Get.showSnackbar(
      GetSnackBar(
        message: message,
        duration: const Duration(seconds: 2),
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(16),
        borderRadius: 14,
        backgroundColor: const Color(0xFF19211C),
      ),
    );
  }
}
