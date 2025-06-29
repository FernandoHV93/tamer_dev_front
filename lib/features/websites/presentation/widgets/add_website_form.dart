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
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF3B82F6).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.add_circle_outline,
                  color: Color(0xFF3B82F6),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Add New Website',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1E293B),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildNameField(),
          const SizedBox(height: 16),
          _buildUrlField(),
          const SizedBox(height: 16),
          _buildStatusDropdown(),
          const SizedBox(height: 24),
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Website Name',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: widget.nameController,
          decoration: InputDecoration(
            hintText: 'Enter website name',
            hintStyle: TextStyle(
              fontSize: 14,
              color: Colors.grey[400],
            ),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF3B82F6)),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          onChanged: (_) => setState(() {}),
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildUrlField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Website URL',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: widget.urlController,
          decoration: InputDecoration(
            hintText: 'https://example.com',
            hintStyle: TextStyle(
              fontSize: 14,
              color: Colors.grey[400],
            ),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF3B82F6)),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          style: const TextStyle(fontSize: 14),
          keyboardType: TextInputType.url,
          onChanged: (_) => setState(() {}),
        ),
      ],
    );
  }

  Widget _buildStatusDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Status',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: DropdownButtonFormField<WebsiteStatus>(
            value: widget.selectedStatus,
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
            items: WebsiteStatus.values.map((status) {
              final isActive = status == WebsiteStatus.Active;
              return DropdownMenuItem<WebsiteStatus>(
                value: status,
                child: Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: isActive
                            ? const Color(0xFF10B981)
                            : const Color(0xFFF59E0B),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      status.name,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: isActive
                            ? const Color(0xFF10B981)
                            : const Color(0xFFF59E0B),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
            onChanged: (value) {
              if (value != null) {
                widget.onStatusChanged(value);
              }
            },
            icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey[400]),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: widget.onCancel,
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          ),
          child: Text(
            'Cancel',
            style: TextStyle(
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(width: 12),
        ElevatedButton(
          onPressed: _isFormValid ? widget.onSubmit : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF3B82F6),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 0,
          ),
          child: const Text(
            'Add Website',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
