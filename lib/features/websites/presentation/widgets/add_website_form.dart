import 'package:flutter/material.dart';
import 'package:ia_web_front/features/websites/domain/entities/website_entity.dart';

class AddWebsiteForm extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController urlController;
  final WebsiteStatus selectedStatus;
  final ValueChanged<WebsiteStatus> onStatusChanged;
  final VoidCallback onCancel;
  final VoidCallback onSubmit;

  const AddWebsiteForm({
    super.key,
    required this.nameController,
    required this.urlController,
    required this.selectedStatus,
    required this.onStatusChanged,
    required this.onCancel,
    required this.onSubmit,
  });

  @override
  State<AddWebsiteForm> createState() => _AddWebsiteFormState();
}

class _AddWebsiteFormState extends State<AddWebsiteForm> {
  bool get _isFormValid =>
      widget.nameController.text.isNotEmpty &&
      widget.urlController.text.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(88, 205, 210, 213),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildNameField(),
          const SizedBox(height: 10),
          _buildUrlField(),
          const SizedBox(height: 10),
          _buildStatusDropdown(),
          const SizedBox(height: 10),
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildNameField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            spreadRadius: 1,
            offset: const Offset(0, 2),
          )
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: TextField(
        controller: widget.nameController,
        decoration: const InputDecoration(
          hintText: 'Website Name',
          hintStyle: TextStyle(
              fontSize: 14,
              color: Color.fromARGB(144, 147, 145, 163),
              fontWeight: FontWeight.bold),
          border: InputBorder.none,
        ),
        onChanged: (_) => setState(() {}),
        style: const TextStyle(fontSize: 14),
      ),
    );
  }

  Widget _buildUrlField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 4, spreadRadius: 1),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: TextField(
        controller: widget.urlController,
        decoration: const InputDecoration(
          hintText: 'Website URL',
          hintStyle: TextStyle(
              fontSize: 14,
              color: Color.fromARGB(144, 147, 145, 163),
              fontWeight: FontWeight.bold),
          border: InputBorder.none,
        ),
        style: const TextStyle(fontSize: 12),
        keyboardType: TextInputType.url,
        onChanged: (_) => setState(() {}),
      ),
    );
  }

  Widget _buildStatusDropdown() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      child: DropdownButton<WebsiteStatus>(
        value: widget.selectedStatus,
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
            widget.onStatusChanged(value);
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
    );
  }

  Widget _buildActionButtons() {
    return Align(
      alignment: Alignment.centerRight,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: const Color.fromARGB(255, 190, 13, 0)),
            child: IconButton(
              hoverColor: const Color.fromARGB(255, 190, 13, 0),
              icon: const Icon(Icons.close, color: Colors.white),
              iconSize: 18,
              onPressed: widget.onCancel,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5), color: Colors.green),
            child: IconButton(
              hoverColor: Colors.green,
              icon: Icon(
                Icons.check,
                color:
                    _isFormValid ? Colors.white : Colors.white.withOpacity(0.5),
              ),
              iconSize: 18,
              onPressed: _isFormValid ? widget.onSubmit : null,
            ),
          ),
        ],
      ),
    );
  }
}
