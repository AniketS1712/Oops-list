import 'package:flutter/material.dart';

class FilterChipsRow extends StatelessWidget {
  final String selectedFilter;
  final ValueChanged<String> onFilterChanged;

  const FilterChipsRow({
    super.key,
    required this.selectedFilter,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: ['All', 'Today', 'Upcoming', 'Overdue', 'Completed']
              .map(
                (filter) => Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(filter),
                    selected: selectedFilter == filter,
                    onSelected: (_) => onFilterChanged(filter),
                    selectedColor: Colors.redAccent.withOpacity(0.2),
                    checkmarkColor: Colors.redAccent,
                    labelStyle: TextStyle(
                      color: selectedFilter == filter
                          ? Colors.redAccent
                          : theme.colorScheme.onSurface,
                      fontWeight: selectedFilter == filter
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
