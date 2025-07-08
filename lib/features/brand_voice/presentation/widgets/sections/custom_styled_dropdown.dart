import 'package:flutter/material.dart';

class CustomStyledDropdown extends StatelessWidget {
  final String? value;
  final String hint;
  final List<String> items;
  final ValueChanged<String?>? onChanged;

  const CustomStyledDropdown({
    super.key,
    required this.value,
    required this.hint,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      items: [
        DropdownMenuItem(
          value: null,
          child: Text(hint, style: const TextStyle(color: Colors.white54)),
        ),
        ...items.map((item) => DropdownMenuItem(
              value: item,
              child: Text(
                item,
                style: TextStyle(
                  color: value == item ? Colors.blueAccent : Colors.white,
                  fontSize: 16,
                ),
              ),
            )),
      ],
      onChanged: onChanged,
      dropdownColor: const Color(0xFF23262F),
      icon: const Icon(Icons.keyboard_arrow_down_rounded,
          color: Colors.blueAccent, size: 28),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFF181A20),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: value != null ? Colors.blueAccent : Colors.white12,
            width: value != null ? 2 : 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
        ),
        hintStyle: const TextStyle(color: Colors.white54),
      ),
      style: const TextStyle(
          color: Colors.blueAccent, fontWeight: FontWeight.bold, fontSize: 16),
    );
  }
}
