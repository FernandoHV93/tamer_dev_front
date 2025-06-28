import 'package:flutter/material.dart';
import 'package:ia_web_front/features/websites/presentation/controller/websites_provider.dart';
import 'package:ia_web_front/features/websites/presentation/widgets/website_list_item.dart';

class WebsitesList extends StatelessWidget {
  final WebsitesProvider provider;

  const WebsitesList({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildTableHeader(),
        ListView.builder(
          shrinkWrap: true,
          itemCount: provider.websites.length,
          itemBuilder: (context, index) {
            final website = provider.websites[index];
            return WebsiteListItem(
              website: website,
              index: index,
              provider: provider,
            );
          },
        ),
      ],
    );
  }

  Widget _buildTableHeader() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8), topRight: Radius.circular(8)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              child: Text('Website',
                  style: TextStyle(fontWeight: FontWeight.bold))),
          Expanded(
              child: Text('Status',
                  style: TextStyle(fontWeight: FontWeight.bold))),
          Expanded(
              child: Text('Last Checked',
                  style: TextStyle(fontWeight: FontWeight.bold))),
          Expanded(
              child: Text('', style: TextStyle(fontWeight: FontWeight.bold))),
        ],
      ),
    );
  }
}
