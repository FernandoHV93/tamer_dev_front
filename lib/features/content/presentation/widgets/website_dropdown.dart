import 'package:flutter/material.dart';
import 'package:ia_web_front/features/websites/domain/entities/website_entity.dart';

class WebsiteDropdown extends StatelessWidget {
  final List<WebsiteEntity> websites;
  final WebsiteEntity? selectedWebsite;
  final Function(WebsiteEntity) onWebsiteSelected;
  final VoidCallback onAddWebsite;

  const WebsiteDropdown({
    super.key,
    required this.websites,
    required this.selectedWebsite,
    required this.onWebsiteSelected,
    required this.onAddWebsite,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 247, 247, 246),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: PopupMenuButton<WebsiteEntity>(
        initialValue: selectedWebsite,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              selectedWebsite?.name ?? 'Select Website',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.arrow_drop_down, color: Colors.grey),
          ],
        ),
        itemBuilder: (context) => [
          ...websites.map((website) => PopupMenuItem<WebsiteEntity>(
                value: website,
                child: Text(website.name),
              )),
          const PopupMenuDivider(),
          PopupMenuItem<WebsiteEntity>(
            value: null,
            onTap: onAddWebsite,
            child: Row(
              children: [
                const Icon(Icons.add, size: 16),
                const SizedBox(width: 8),
                const Text('Add New Website'),
              ],
            ),
          ),
        ],
        onSelected: (website) {
          onWebsiteSelected(website);
        },
      ),
    );
  }
}
