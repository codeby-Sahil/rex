import 'package:flutter/material.dart';

import '../controllers/expense_tracker_controller.dart';
import '../models/expense_models.dart';
import 'tracker_shell.dart';

class ComposerFormBody extends StatelessWidget {
  const ComposerFormBody({super.key, required this.controller});
  // 0x4000F5D4
  final ExpenseTrackerController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xF7060612),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color.fromARGB(64, 243, 130, 0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Center(
            child: Text(
              '// NEW_ENTRY',
              style: TextStyle(
                color: kMutedColor,
                fontSize: 9,
                letterSpacing: 2,
                fontFamily: 'monospace',
              ),
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: <Widget>[
              Expanded(
                child: _TypeButton(
                  label: 'EXPENSE',
                  selected: controller.entryType.value == EntryType.expense,
                  accent: kCoralColor,
                  onTap: () => controller.setEntryType(EntryType.expense),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _TypeButton(
                  label: 'INCOME',
                  selected: controller.entryType.value == EntryType.income,
                  accent: kLimeColor,
                  onTap: () => controller.setEntryType(EntryType.income),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const _FormLabel('AMOUNT'),
          _TextInput(
            controller: controller.amountController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            hintText: '0.00',
          ),
          const SizedBox(height: 10),
          const _FormLabel('DESCRIPTION'),
          _TextInput(
            controller: controller.descriptionController,
            hintText: 'e.g. Coffee',
          ),
          const SizedBox(height: 10),
          const _FormLabel('CATEGORY'),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: const Color(0x0A00F5D4),
              borderRadius: BorderRadius.circular(11),
              border: Border.all(color: const Color(0x3300F5D4)),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: controller.selectedCategory.value,
                dropdownColor: kVoidColor,
                isExpanded: true,
                style: const TextStyle(
                  color: kTextColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
                items: controller.categoryIcons.keys.map((category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    controller.setCategory(value);
                  }
                },
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: <Widget>[
              Checkbox(
                value: controller.recurring.value,
                activeColor: kVioletColor,
                side: const BorderSide(color: kBorderStrong),
                onChanged: (value) => controller.setRecurring(value ?? false),
              ),
              const Text(
                'MARK AS RECURRING',
                style: TextStyle(
                  color: kMutedColor,
                  fontSize: 10,
                  letterSpacing: 0.8,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: <Widget>[
              Expanded(
                child: OutlinedButton(
                  onPressed: controller.toggleComposer,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: kMutedColor,
                    side: const BorderSide(color: kBorderColor),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(11),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text(
                    'ABORT',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.7,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: FilledButton(
                  onPressed: controller.saveEntry,
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0x1A00F5D4),
                    foregroundColor: kCyanColor,
                    side: const BorderSide(color: Color(0x8000F5D4)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(11),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text(
                    'COMMIT',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.7,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FormLabel extends StatelessWidget {
  const _FormLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        text,
        style: const TextStyle(
          color: kMutedColor,
          fontSize: 9,
          letterSpacing: 1.5,
          fontFamily: 'monospace',
        ),
      ),
    );
  }
}

class _TextInput extends StatelessWidget {
  const _TextInput({
    required this.controller,
    this.keyboardType,
    this.hintText,
  });

  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      style: const TextStyle(
        color: kTextColor,
        fontSize: 13,
        fontWeight: FontWeight.w600,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: kMutedColor),
        filled: true,
        fillColor: const Color(0x0A00F5D4),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 13,
          vertical: 10,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(11),
          borderSide: const BorderSide(color: Color(0x3300F5D4)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(11),
          borderSide: const BorderSide(color: Color(0x9900F5D4)),
        ),
      ),
    );
  }
}

class _TypeButton extends StatelessWidget {
  const _TypeButton({
    required this.label,
    required this.selected,
    required this.accent,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final Color accent;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 11),
        decoration: BoxDecoration(
          color: selected ? accent.withValues(alpha: 0.12) : kSurfaceColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected ? accent.withValues(alpha: 0.5) : kBorderColor,
          ),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: selected ? accent : kMutedColor,
            fontSize: 10,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.7,
            fontFamily: 'monospace',
          ),
        ),
      ),
    );
  }
}
