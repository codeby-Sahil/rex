import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../controllers/expense_tracker_controller.dart';
import '../models/expense_models.dart';
import 'tracker_form.dart';
import 'tracker_shell.dart';

class HeaderPanel extends StatelessWidget {
  const HeaderPanel({super.key, required this.controller});

  final ExpenseTrackerController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(22, 26, 22, 22),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0x3300F5D4))),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'WALLET_OS // v3.0',
                      style: TextStyle(
                        color: kCyanColor,
                        fontSize: 9,
                        letterSpacing: 2.2,
                        fontFamily: 'monospace',
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Hello, You',
                      style: TextStyle(
                        color: kTextColor,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              MonthSwitcher(controller: controller),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'NET BALANCE',
            style: TextStyle(
              color: kMutedColor,
              fontSize: 9,
              letterSpacing: 2,
              fontFamily: 'monospace',
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '$rupeeSymbol${controller.formatAmount(controller.balance.abs())}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 44,
              fontWeight: FontWeight.w700,
              letterSpacing: -2,
              height: 1,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0x149D4EDD),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: const Color(0x599D4EDD)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(color: kVioletColor, shape: BoxShape.circle),
                ),
                const SizedBox(width: 8),
                Text(
                  controller.insightText,
                  style: const TextStyle(
                    color: kVioletColor,
                    fontSize: 10,
                    letterSpacing: 0.8,
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Row(
            children: <Widget>[
              Expanded(
                child: MetricCard(
                  label: 'INCOME',
                  value: '$rupeeSymbol${controller.formatAmount(controller.incomeTotal)}',
                  accent: kLimeColor,
                  footerLabel: 'RUNWAY',
                  footerValue: controller.runwayLabel,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: MetricCard(
                  label: 'SPENT',
                  value: '$rupeeSymbol${controller.formatAmount(controller.expenseTotal)}',
                  accent: kCoralColor,
                  footerLabel: 'BURN/DAY',
                  footerValue: controller.burnPerDayLabel,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MonthSwitcher extends StatelessWidget {
  const MonthSwitcher({super.key, required this.controller});

  final ExpenseTrackerController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _MiniButton(icon: Icons.chevron_left, onTap: () => controller.shiftMonth(-1)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            controller.currentMonth.label,
            style: const TextStyle(
              color: kTextColor,
              fontSize: 11,
              letterSpacing: 1.2,
              fontFamily: 'monospace',
            ),
          ),
        ),
        _MiniButton(icon: Icons.chevron_right, onTap: () => controller.shiftMonth(1)),
      ],
    );
  }
}

class MetricCard extends StatelessWidget {
  const MetricCard({
    super.key,
    required this.label,
    required this.value,
    required this.accent,
    required this.footerLabel,
    required this.footerValue,
  });

  final String label;
  final String value;
  final Color accent;
  final String footerLabel;
  final String footerValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: kSurfaceColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: kBorderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: const TextStyle(
              color: kMutedColor,
              fontSize: 9,
              letterSpacing: 1.8,
              fontFamily: 'monospace',
            ),
          ),
          const SizedBox(height: 6),
          Text(value, style: TextStyle(color: accent, fontSize: 16, fontWeight: FontWeight.w700)),
          const SizedBox(height: 6),
          Row(
            children: <Widget>[
              Text(
                footerLabel,
                style: const TextStyle(
                  color: kMutedColor,
                  fontSize: 9,
                  letterSpacing: 0.7,
                  fontFamily: 'monospace',
                ),
              ),
              const SizedBox(width: 6),
              Text(
                footerValue,
                style: const TextStyle(color: kCyanColor, fontSize: 9, fontFamily: 'monospace'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TabSwitcher extends StatelessWidget {
  const TabSwitcher({super.key, required this.selectedTab, required this.onChanged});

  final TrackerTab selectedTab;
  final ValueChanged<TrackerTab> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: kSurfaceColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: kBorderColor),
      ),
      child: Row(
        children: TrackerTab.values.map((tab) {
          final isSelected = tab == selectedTab;
          return Expanded(
            child: GestureDetector(
              onTap: () => onChanged(tab),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0x1A00F5D4) : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: isSelected ? const Color(0x4D00F5D4) : Colors.transparent),
                ),
                child: Text(
                  switch (tab) {
                    TrackerTab.ledger => 'LEDGER',
                    TrackerTab.analytics => 'ANALYTICS',
                    TrackerTab.budgets => 'BUDGETS',
                  },
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isSelected ? kCyanColor : kMutedColor,
                    fontSize: 10,
                    letterSpacing: 0.9,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class QuickActionChip extends StatelessWidget {
  const QuickActionChip({super.key, required this.action, required this.onTap});

  final QuickAction action;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: kSurfaceColor,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: kBorderColor),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(action.icon, size: 16, color: kTextColor),
            const SizedBox(width: 6),
            Text(
              action.label,
              style: const TextStyle(color: kMutedColor, fontSize: 11, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}

class FilterChipButton extends StatelessWidget {
  const FilterChipButton({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: selected ? const Color(0x1A00F5D4) : const Color(0x0A00F5D4),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: selected ? const Color(0x8000F5D4) : const Color(0x2600F5D4)),
        ),
        child: Text(
          label.toUpperCase(),
          style: TextStyle(
            color: selected ? kCyanColor : kMutedColor,
            fontSize: 10,
            letterSpacing: 0.5,
            fontFamily: 'monospace',
          ),
        ),
      ),
    );
  }
}

class CommittedBar extends StatelessWidget {
  const CommittedBar({super.key, required this.value});

  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0x0F9D4EDD),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0x409D4EDD)),
      ),
      child: Row(
        children: <Widget>[
          const Expanded(
            child: Text(
              'RECURRING / COMMITTED',
              style: TextStyle(
                color: kVioletColor,
                fontSize: 9,
                letterSpacing: 1.1,
                fontFamily: 'monospace',
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(color: kVioletColor, fontSize: 13, fontWeight: FontWeight.w700, fontFamily: 'monospace'),
          ),
        ],
      ),
    );
  }
}

class TransactionCard extends StatelessWidget {
  const TransactionCard({super.key, required this.entry, required this.icon, required this.background});

  final TransactionEntry entry;
  final IconData icon;
  final Color background;

  @override
  Widget build(BuildContext context) {
    final isExpense = entry.type == EntryType.expense;
    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: kSurfaceColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: kBorderColor),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: background,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0x12FFFFFF)),
            ),
            child: Icon(icon, color: kTextColor, size: 18),
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(entry.description, style: const TextStyle(color: kTextColor, fontSize: 12, fontWeight: FontWeight.w600)),
                const SizedBox(height: 3),
                Row(
                  children: <Widget>[
                    Text(
                      entry.dateLabel,
                      style: const TextStyle(color: kMutedColor, fontSize: 9, letterSpacing: 0.5, fontFamily: 'monospace'),
                    ),
                    if (entry.isRecurring) ...<Widget>[
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0x269D4EDD),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: const Color(0x599D4EDD)),
                        ),
                        child: const Text(
                          'RECUR',
                          style: TextStyle(color: kVioletColor, fontSize: 8, letterSpacing: 0.5, fontFamily: 'monospace'),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          Text(
            '${isExpense ? '-' : '+'}$rupeeSymbol${entry.amount.round()}',
            style: TextStyle(
              color: isExpense ? kCoralColor : kLimeColor,
              fontSize: 13,
              fontWeight: FontWeight.w700,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }
}

class AnalyticsBars extends StatelessWidget {
  const AnalyticsBars({
    super.key,
    required this.spendingMap,
    required this.colorForCategory,
    required this.iconForCategory,
  });

  final Map<String, double> spendingMap;
  final Color Function(String category) colorForCategory;
  final IconData Function(String category) iconForCategory;

  @override
  Widget build(BuildContext context) {
    if (spendingMap.isEmpty) {
      return const EmptyStateCard('// NO EXPENSE DATA');
    }

    final maxValue = spendingMap.values.reduce(math.max);
    return SizedBox(
      height: 92,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: spendingMap.entries.map((entry) {
          final heightFactor = (entry.value / maxValue).clamp(0.08, 1.0);
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: 70 * heightFactor,
                    decoration: BoxDecoration(
                      color: colorForCategory(entry.key),
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(5)),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Icon(iconForCategory(entry.key), color: kMutedColor, size: 14),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class BudgetCard extends StatelessWidget {
  const BudgetCard({
    super.key,
    required this.name,
    required this.spentLabel,
    required this.progress,
    required this.progressColor,
    required this.icon,
    required this.valueColor,
  });

  final String name;
  final String spentLabel;
  final double progress;
  final Color progressColor;
  final IconData icon;
  final Color valueColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: kSurfaceColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: kBorderColor),
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(icon, color: kTextColor, size: 16),
              const SizedBox(width: 8),
              Expanded(
                child: Text(name, style: const TextStyle(color: kTextColor, fontSize: 12, fontWeight: FontWeight.w600)),
              ),
              Text(spentLabel, style: TextStyle(color: valueColor, fontSize: 10, fontFamily: 'monospace')),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(99),
            child: LinearProgressIndicator(
              minHeight: 4,
              value: progress,
              backgroundColor: const Color(0x12FFFFFF),
              valueColor: AlwaysStoppedAnimation<Color>(progressColor),
            ),
          ),
        ],
      ),
    );
  }
}

class ActionButtons extends StatelessWidget {
  const ActionButtons({
    super.key,
    required this.composerOpen,
    required this.onToggleComposer,
    required this.onToggleExport,
  });

  final bool composerOpen;
  final VoidCallback onToggleComposer;
  final VoidCallback onToggleExport;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: FilledButton(
            onPressed: onToggleComposer,
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0x1200F5D4),
              foregroundColor: kCyanColor,
              side: const BorderSide(color: Color(0x6600F5D4)),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            child: Text(
              composerOpen ? 'X ABORT' : '+ LOG TRANSACTION',
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 0.9, fontFamily: 'monospace'),
            ),
          ),
        ),
        const SizedBox(width: 8),
        OutlinedButton(
          onPressed: onToggleExport,
          style: OutlinedButton.styleFrom(
            foregroundColor: kMutedColor,
            side: const BorderSide(color: kBorderColor),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
          child: const Text(
            'EXPORT',
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 0.8, fontFamily: 'monospace'),
          ),
        ),
      ],
    );
  }
}

class ExportPanel extends StatelessWidget {
  const ExportPanel(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0x0AB5FF5A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0x33B5FF5A)),
      ),
      child: Text(
        text,
        style: const TextStyle(color: kMutedColor, fontSize: 10, height: 1.8, fontFamily: 'monospace'),
      ),
    );
  }
}

class ComposerCard extends StatelessWidget {
  const ComposerCard({super.key, required this.controller});

  final ExpenseTrackerController controller;

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      duration: const Duration(milliseconds: 220),
      crossFadeState: controller.isComposerOpen.value ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      firstChild: ComposerFormBody(controller: controller),
      secondChild: const SizedBox.shrink(),
    );
  }
}

class _MiniButton extends StatelessWidget {
  const _MiniButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: kSurfaceColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: kBorderColor),
        ),
        child: Icon(icon, size: 14, color: kMutedColor),
      ),
    );
  }
}
