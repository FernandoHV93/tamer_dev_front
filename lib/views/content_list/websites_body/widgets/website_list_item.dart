import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ia_web_front/data/models/website_model.dart';
import 'package:ia_web_front/views/content_list/controller/websites_controller.dart';
import 'package:ia_web_front/views/content_list/websites_body/widgets/svg_icon_button.dart';
import 'package:intl/intl.dart';

class WebsiteListItem extends StatelessWidget {
  final Website website;
  final int index;
  final WebsiteController controller;

  const WebsiteListItem({
    super.key,
    required this.website,
    required this.index,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!),
      ),
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildWebsiteInfo(),
          _buildStatusIndicator(),
          _buildLastChecked(),
          _buildActionButtons(context),
        ],
      ),
    );
  }

  Widget _buildWebsiteInfo() {
    return Row(children: [
      SvgPicture.asset(
        'assets/images/icons/worldwide.svg',
        height: 20,
        width: 20,
        color: const Color.fromARGB(255, 108, 108, 108),
      ),
      const SizedBox(width: 10),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(website.name,
              style:
                  const TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
          Text(
            website.url,
            style: TextStyle(color: Colors.black26, fontSize: 16),
          )
        ],
      ),
    ]);
  }

  Widget _buildStatusIndicator() {
    return Row(children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        decoration: BoxDecoration(
            color: website.status == WebsiteStatus.Active
                ? const Color.fromARGB(168, 202, 255, 204)
                : const Color.fromARGB(182, 255, 251, 174),
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Text(
          website.status.name.toLowerCase(),
          style: TextStyle(
              color: website.status == WebsiteStatus.Active
                  ? const Color.fromARGB(255, 1, 99, 4)
                  : const Color.fromARGB(255, 149, 134, 1),
              fontWeight: FontWeight.w500),
        ),
      ),
    ]);
  }

  Widget _buildLastChecked() {
    return Text(
      DateFormat('yyyy-MM-dd – HH:mm').format(website.lastChecked),
      style: TextStyle(
          color: Colors.grey[600], fontSize: 16, fontWeight: FontWeight.w800),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SvgIconButton(
          assetPath: 'assets/images/icons/edit.svg',
          color: const Color.fromARGB(255, 38, 64, 254),
          size: 24,
          onPressed: () => _showEditDialog(context),
        ),
        SvgIconButton(
          assetPath: 'assets/images/icons/delete.svg',
          color: Colors.red[400],
          size: 24,
          onPressed: () => controller.removeWebsite(index),
        ),
      ],
    );
  }

  void _showEditDialog(BuildContext context) {
    // Implementación del diálogo de edición
  }
}
