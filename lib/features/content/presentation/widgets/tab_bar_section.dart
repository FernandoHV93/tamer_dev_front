import 'package:flutter/material.dart';

class TabBarSection extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabSelected;

  const TabBarSection({
    super.key,
    required this.selectedIndex,
    required this.onTabSelected,
  });

  static const _tabTitles = [
    'Content Cards',
    'Performance',
    'Topic Clusters',
    'Content Gaps',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          // Animated indicator
          AnimatedAlign(
            alignment: Alignment(
                -1 + (2 * selectedIndex / (_tabTitles.length - 1)), 0),
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeInOut,
            child: FractionallySizedBox(
              widthFactor: 1 / _tabTitles.length,
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Row(
            children: List.generate(_tabTitles.length, (index) {
              final isSelected = selectedIndex == index;
              return Expanded(
                child: GestureDetector(
                  onTap: () => onTabSelected(index),
                  child: AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInOut,
                    style: TextStyle(
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected ? Colors.black : Colors.grey[600],
                      fontSize: 15,
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 8),
                        child: Text(_tabTitles[index]),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
