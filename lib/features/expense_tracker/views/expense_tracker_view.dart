import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/expense_tracker_controller.dart';
import '../models/expense_models.dart';
import '../widgets/tracker_components.dart';
import '../widgets/tracker_shell.dart';

class ExpenseTrackerView extends GetView<ExpenseTrackerController> {
  const ExpenseTrackerView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ExpenseTrackerController>(
      builder: (controller) {
        return Obx(
          () => Scaffold(
            body: TrackerShell(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    HeaderPanel(controller: controller),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TabSwitcher(
                            selectedTab: controller.selectedTab.value,
                            onChanged: controller.switchTab,
                          ),
                          const SizedBox(height: 16),
                          if (controller.selectedTab.value ==
                              TrackerTab.ledger) ...<Widget>[
                            const SectionLabel('QUICK LOG'),
                            const SizedBox(height: 12),
                            Wrap(
                              spacing: 6,
                              runSpacing: 6,
                              children: controller.quickActions
                                  .map(
                                    (action) => QuickActionChip(
                                      action: action,
                                      onTap: () => controller.quickAdd(action),
                                    ),
                                  )
                                  .toList(),
                            ),
                            const SizedBox(height: 16),
                            const SectionLabel('TRANSACTIONS'),
                            const SizedBox(height: 12),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: controller.filters
                                    .map(
                                      (filter) => Padding(
                                        padding: const EdgeInsets.only(
                                          right: 6,
                                        ),
                                        child: FilterChipButton(
                                          label: filter,
                                          selected:
                                              filter ==
                                              controller.selectedFilter.value,
                                          onTap: () =>
                                              controller.setFilter(filter),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                            const SizedBox(height: 12),
                            CommittedBar(
                              value:
                                  '$rupeeSymbol${controller.formatAmount(controller.recurringCommitment.toDouble())}',
                            ),
                            const SizedBox(height: 12),
                            if (controller.filteredTransactions.isEmpty)
                              const EmptyStateCard('// NO_DATA_FOUND')
                            else
                              Column(
                                children: controller.filteredTransactions
                                    .map(
                                      (entry) => Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 6,
                                        ),
                                        child: TransactionCard(
                                          entry: entry,
                                          icon:
                                              controller.categoryIcons[entry
                                                  .category] ??
                                              Icons.auto_awesome_outlined,
                                          background:
                                              controller
                                                  .categoryBackgrounds[entry
                                                  .category] ??
                                              const Color(0x199D4EDD),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                          ],
                          if (controller.selectedTab.value ==
                              TrackerTab.analytics) ...<Widget>[
                            const SectionLabel('SPEND BY CATEGORY'),
                            const SizedBox(height: 16),
                            AnalyticsBars(
                              spendingMap: controller.spendingByCategory,
                              colorForCategory: (category) =>
                                  controller.categoryChartColors[category] ??
                                  const Color(0x999D4EDD),
                              iconForCategory: (category) =>
                                  controller.categoryIcons[category] ??
                                  Icons.auto_awesome_outlined,
                            ),
                          ],
                          if (controller.selectedTab.value ==
                              TrackerTab.budgets) ...<Widget>[
                            const SectionLabel('BUDGET LIMITS'),
                            const SizedBox(height: 12),
                            Column(
                              children: controller.budgets.map((budget) {
                                final spent = controller.budgetSpent(
                                  budget.category,
                                );
                                final progress = controller.budgetProgress(
                                  budget.category,
                                  budget.limit,
                                );
                                final progressColor = controller.budgetColor(
                                  budget.category,
                                  budget.limit,
                                );
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: BudgetCard(
                                    name: budget.category,
                                    spentLabel:
                                        '$rupeeSymbol${controller.formatAmount(spent)} / $rupeeSymbol${controller.formatAmount(budget.limit)}',
                                    progress: progress,
                                    progressColor: progressColor,
                                    icon:
                                        controller.categoryIcons[budget
                                            .category] ??
                                        Icons.auto_awesome_outlined,
                                    valueColor: progress >= 1
                                        ? const Color(0xFFFF4F6D)
                                        : progress >= 0.75
                                        ? const Color(0xFFFFDC32)
                                        : kMutedColor,
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                          const SizedBox(height: 16),
                          ActionButtons(
                            composerOpen: controller.isComposerOpen.value,
                            onToggleComposer: controller.toggleComposer,
                            onToggleExport: controller.toggleExport,
                          ),
                          const SizedBox(height: 14),
                          if (controller.isExportOpen.value) ...<Widget>[
                            ExportPanel(controller.exportReport),
                            const SizedBox(height: 14),
                          ],
                          ComposerCard(controller: controller),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
