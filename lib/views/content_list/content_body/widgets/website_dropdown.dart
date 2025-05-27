import 'package:flutter/material.dart';

import 'package:ia_web_front/views/content_list/controller/websites_controller.dart';
import 'package:provider/provider.dart';

class WebsiteDropdown extends StatefulWidget {
  final List<Map<String, String>> websites;
  final VoidCallback onAddWebsite;

  const WebsiteDropdown({
    super.key,
    required this.websites,
    required this.onAddWebsite,
  });

  @override
  State<WebsiteDropdown> createState() => _WebsiteDropdownState();
}

class _WebsiteDropdownState extends State<WebsiteDropdown> {
  String? _selectedWebsite;
  final _dropdownKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final websiteController = Provider.of<WebsiteController>(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 247, 247, 246),
        borderRadius: BorderRadius.circular(6),
      ),
      child: PopupMenuButton<String>(
        // initialValue: websiteController.websites
        //     .firstWhere((website) => website.status == WebsiteStatus.Active)
        //     .name,
        key: _dropdownKey,
        onSelected: (value) {
          if (value == 'add_website') {
            widget.onAddWebsite();
          } else {
            setState(() => _selectedWebsite = value);
            websiteController.selectWebsite(value);
          }
        },
        itemBuilder: (context) => [
          ...widget.websites.map((entry) => PopupMenuItem<String>(
                value: entry['name'], // Usa la URL como valor único
                child: _WebsiteOption(
                  name: entry['name'] ?? 'Unknown', // Accede al nombre
                  url: entry['url'] ?? 'Unknown', // Accede a la URL
                ),
              )),
          const PopupMenuItem<String>(
            value: 'add_website',
            child: ListTile(
              leading: Icon(Icons.add, size: 20),
              title: Text('Add Website'),
            ),
          ),
        ],
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _selectedWebsite ?? 'Select Website',
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(width: 4),
            const Icon(Icons.arrow_drop_down, size: 18),
          ],
        ),
      ),
    );
  }
}

class _WebsiteOption extends StatelessWidget {
  final String name;
  final String url;

  const _WebsiteOption({
    required this.name,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            url,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
