import 'package:flutter/material.dart';

const String rupeeSymbol = '\u20B9';

enum TrackerTab { ledger, analytics, budgets }

enum EntryType { expense, income }

class MonthData {
  MonthData({
    required this.label,
    required this.entries,
  });

  final String label;
  final List<TransactionEntry> entries;
}

class TransactionEntry {
  TransactionEntry({
    required this.id,
    required this.type,
    required this.category,
    required this.description,
    required this.amount,
    required this.dateLabel,
    required this.isRecurring,
  });

  final int id;
  final EntryType type;
  final String category;
  final String description;
  final double amount;
  final String dateLabel;
  final bool isRecurring;
}

class QuickAction {
  QuickAction({
    required this.label,
    required this.category,
    required this.amount,
    required this.icon,
  });

  final String label;
  final String category;
  final double amount;
  final IconData icon;
}

class BudgetLimit {
  BudgetLimit({
    required this.category,
    required this.limit,
  });

  final String category;
  final double limit;
}
