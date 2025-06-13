import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final int selectedIndex;
  final Function(int) onTabSelected;

  const CustomAppBar(
      {super.key, required this.selectedIndex, required this.onTabSelected});

  final tabs = const [
    'Websites',
    'Content',
    'Article Builder',
    'Article Editor'
  ];

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 2, // Elimina la sombra // Compensa la eliminación de la sombra
      surfaceTintColor: Colors.white,
      shadowColor: const Color.fromARGB(255, 195, 195, 195),
      title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(tabs.length, (index) {
            final isSelected = index == selectedIndex;
            return GestureDetector(
              onTap: () => onTabSelected(index),
              child: Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: isSelected
                        ? const Color.fromARGB(157, 221, 221, 221)
                        : Colors.white),
                child: Text(
                  tabs[index],
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.w500,
                      color: isSelected ? Colors.black : Colors.black45),
                ),
              ),
            );
          })),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
