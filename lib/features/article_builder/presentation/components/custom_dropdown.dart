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
                  size: 20, color: const Color.fromARGB(255, 29, 133, 218)),
            if (leadingIcon != null) const SizedBox(width: 6),
            Text(
              label,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 29, 133, 218)),
            ),
          ],
        ),
        const SizedBox(height: 6),
        DropdownButtonFormField<String>(
          hint: const Text('Select an option'),
          value: selectedValue,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.fromLTRB(12, 8, 12, 8),
          ),
          dropdownColor: const Color.fromARGB(255, 41, 41, 41),
          isExpanded:
              true, // Esto permite que el dropdown use todo el ancho disponible
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
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Container(
                    width: constraints.maxWidth,
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Icono o imagen con ancho fijo
                        if (icon != null || image != null)
                          SizedBox(
                            width: 28, // Ancho fijo para el icono/imagen
                            child: icon != null
                                ? Icon(
                                    icon,
                                    size: 20,
                                    color: Colors.white,
                                  )
                                : image,
                          ),
                        if (icon != null || image != null)
                          const SizedBox(width: 8),
                        // Contenido del texto expandible
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              if (description != null) ...[
                                const SizedBox(height: 2),
                                Text(
                                  description,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey,
                                    fontStyle: FontStyle.italic,
                                    height: 1.2,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines:
                                      2, // Permitir máximo 2 líneas para la descripción
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          }),
          onChanged: onChanged,
          // Personalizar cómo se muestra el valor seleccionado
          selectedItemBuilder: (BuildContext context) {
            return items.map<Widget>((String item) {
              final index = items.indexOf(item);
              final icon =
                  icons != null && icons!.length > index ? icons![index] : null;
              final image = images != null && images!.length > index
                  ? images![index]
                  : null;

              return Container(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    if (icon != null)
                      Icon(
                        icon,
                        size: 18,
                        color: Colors.white,
                      ),
                    if (icon == null && image != null)
                      SizedBox(
                        width: 18,
                        height: 18,
                        child: image,
                      ),
                    if (icon != null || image != null) const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        item,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              );
            }).toList();
          },
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
