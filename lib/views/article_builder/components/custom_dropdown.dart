import 'package:flutter/material.dart';

class CustomDropdownTile extends StatelessWidget {
  final String label;
  final List<String> items;
  final String? selectedValue;
  final void Function(String?) onChanged;
  final IconData? leadingIcon;
  final List<IconData>? icons;
  final List<Image>? images;
  final Map<String, String>? itemDescriptions;
  final String? note;

  const CustomDropdownTile({
    super.key,
    required this.label,
    required this.items,
    required this.selectedValue,
    required this.onChanged,
    this.leadingIcon,
    this.icons,
    this.images,
    this.itemDescriptions,
    this.note,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (leadingIcon != null)
              Icon(leadingIcon,
                  size: 20, color: const Color.fromARGB(255, 5, 46, 80)),
            if (leadingIcon != null) const SizedBox(width: 6),
            Text(
              label,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 14, 76, 126)),
            ),
          ],
        ),
        const SizedBox(height: 6),
        DropdownButtonFormField<String>(
          value: selectedValue,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            isDense: false,
            contentPadding: EdgeInsets.fromLTRB(12, 0, 0, 2),
          ),
          items: List.generate(items.length, (index) {
            final item = items[index];
            final icon =
                icons != null && icons!.length > index ? icons![index] : null;
            final image = images != null && images!.length > index
                ? images![index]
                : null;
            final description = itemDescriptions?[item];

            return DropdownMenuItem<String>(
              value: item,
              child: SizedBox(
                width: 250,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (icon != null) Icon(icon, size: 20),
                    if (icon == null && image != null) image,
                    if ((icon != null || image != null))
                      const SizedBox(width: 8),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item, style: const TextStyle(fontSize: 15)),
                          if (description != null)
                            Text(
                              description,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                                fontStyle: FontStyle.italic,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
          onChanged: onChanged,
        ),
        if (note != null) ...[
          const SizedBox(height: 6),
          Text(
            note!,
            style: const TextStyle(fontSize: 13, color: Colors.grey),
          ),
        ]
      ],
    );
  }
}
