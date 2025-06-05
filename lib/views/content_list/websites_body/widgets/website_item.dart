import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ia_web_front/data/models/website_model.dart';
import 'package:ia_web_front/views/content_list/controller/websites_controller.dart';
import 'package:ia_web_front/views/content_list/websites_body/widgets/svg_icon_button.dart';
import 'package:intl/intl.dart';

class WebsiteListItem extends StatefulWidget {
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
  State<WebsiteListItem> createState() => _WebsiteListItemState();
}

class _WebsiteListItemState extends State<WebsiteListItem> {
  late TextEditingController _nameController;
  late TextEditingController _urlController;
  late WebsiteStatus _selectedStatus;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.website.name);
    _urlController = TextEditingController(text: widget.website.url);
    _selectedStatus = widget.website.status;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _urlController.dispose();
    super.dispose();
  }

  void _toggleEditing() {
    setState(() {
      _isEditing = !_isEditing;
      if (!_isEditing) {
        _nameController.text = widget.website.name;
        _urlController.text = widget.website.url;
        _selectedStatus = widget.website.status;
      }
    });
  }

  void _saveChanges() {
    widget.controller.editWebsite(
      widget.index,
      _nameController.text,
      _urlController.text,
      _selectedStatus,
    );
    _toggleEditing();
  }

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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildWebsiteInfo(),
          _buildStatusSection(),
          _buildLastChecked(),
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildWebsiteInfo() {
    return Expanded(
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/images/icons/worldwide.svg',
            height: 20,
            width: 20,
            color: const Color.fromARGB(255, 108, 108, 108),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _isEditing
                ? Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                        border: Border.all(color: Colors.black12)),
                    child: TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        hintText: 'Website Name',
                        hintStyle: TextStyle(
                            fontSize: 14,
                            color: Color.fromARGB(144, 147, 145, 163),
                            fontWeight: FontWeight.bold),
                        border: InputBorder.none,
                      ),
                      style: const TextStyle(fontSize: 14),
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.website.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        widget.website.url,
                        style: TextStyle(
                          color: Colors.black26,
                          fontSize: 16,
                        ),
                      )
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusSection() {
    return Expanded(
      child: _isEditing
          ? Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
              ),
              child: DropdownButton<WebsiteStatus>(
                value: _selectedStatus,
                padding: const EdgeInsets.symmetric(horizontal: 5),
                dropdownColor: Colors.white,
                underline: const SizedBox(),
                borderRadius: BorderRadius.circular(5),
                menuWidth: 75,
                items: WebsiteStatus.values.map((status) {
                  return DropdownMenuItem<WebsiteStatus>(
                    value: status,
                    child: Text(
                      status.name.toString(),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _selectedStatus = value);
                  }
                },
                selectedItemBuilder: (BuildContext context) {
                  return WebsiteStatus.values.map((status) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: Colors.white,
                      ),
                      child: Text(
                        status.name.toString(),
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }).toList();
                },
              ),
            )
          : Expanded(
              child: Row(children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  decoration: BoxDecoration(
                    color: widget.website.status == WebsiteStatus.Active
                        ? const Color.fromARGB(168, 202, 255, 204)
                        : const Color.fromARGB(182, 255, 251, 174),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    widget.website.status.name.toLowerCase(),
                    style: TextStyle(
                      color: widget.website.status == WebsiteStatus.Active
                          ? const Color.fromARGB(255, 1, 99, 4)
                          : const Color.fromARGB(255, 149, 134, 1),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ]),
            ),
    );
  }

  Widget _buildLastChecked() {
    return Expanded(
      child: Text(
        DateFormat('yyyy-MM-dd – HH:mm').format(
          _isEditing ? DateTime.now() : widget.website.lastChecked!,
        ),
        style: TextStyle(
          color: Colors.grey[600],
          fontSize: 16,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: _isEditing
            ? [
                _buildCancelButton(),
                const SizedBox(width: 8),
                _buildSaveButton(),
              ]
            : [
                _buildEditButton(),
                _buildDeleteButton(),
              ],
      ),
    );
  }

  Widget _buildEditButton() {
    return SvgIconButton(
      assetPath: 'assets/images/icons/edit.svg',
      color: const Color.fromARGB(255, 38, 64, 254),
      size: 24,
      onPressed: _toggleEditing,
    );
  }

  Widget _buildDeleteButton() {
    return SvgIconButton(
      assetPath: 'assets/images/icons/delete.svg',
      color: Colors.red[400],
      size: 24,
      onPressed: () => widget.controller.removeWebsite(widget.index),
    );
  }

  Widget _buildSaveButton() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.green,
      ),
      child: IconButton(
        icon: const Icon(Icons.check, color: Colors.white),
        iconSize: 24,
        onPressed: _saveChanges,
      ),
    );
  }

  Widget _buildCancelButton() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.red,
      ),
      child: IconButton(
        icon: const Icon(Icons.close, color: Colors.white),
        iconSize: 24,
        onPressed: _toggleEditing,
      ),
    );
  }
}
