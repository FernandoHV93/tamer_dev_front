import 'package:flutter/material.dart';

class TabBarSection extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabSelected;

  const TabBarSection({
    super.key,
    required this.selectedIndex,
    required this.onTabSelected,
  });

  final tabs = const [
    'Content List',
    'Performance',
    'Topic Clusters',
    'Content Gaps'
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(tabs.length, (index) {
        final isSelected = index == selectedIndex;
        return GestureDetector(
          onTap: () => onTabSelected(index),
          child: Container(
            margin: const EdgeInsets.only(right: 24),
            padding: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              border: isSelected
                  ? Border(
                      bottom: BorderSide(
                        width: 2,
                        color: isSelected
                            ? Color.fromARGB(255, 17, 35, 195)
                            : Color.fromARGB(255, 5, 5, 5),
                      ),
                    )
                  : null,
            ),
            child: Text(
              tabs[index],
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: isSelected
                    ? const Color.fromARGB(255, 60, 75, 166)
                    : const Color.fromARGB(255, 95, 95, 95),
              ),
            ),
          ),
        );
      }),
    );
  }
}
