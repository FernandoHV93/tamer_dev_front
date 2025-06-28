import 'package:flutter/material.dart';
import 'package:ia_web_front/core/providers/session_provider.dart';
import 'package:ia_web_front/features/websites/domain/entities/website_entity.dart';
import 'package:ia_web_front/features/websites/presentation/controller/websites_provider.dart';
import 'package:ia_web_front/features/websites/presentation/widgets/add_website_form.dart';
import 'package:ia_web_front/features/websites/presentation/widgets/websites_list.dart';
import 'package:provider/provider.dart';

class WebsitesView extends StatefulWidget {
  const WebsitesView({super.key});

  @override
  State<WebsitesView> createState() => _WebsitesViewState();
}

class _WebsitesViewState extends State<WebsitesView> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _urlController = TextEditingController();
  WebsiteStatus _selectedStatus = WebsiteStatus.Active;
  bool _showAddForm = false;

  bool get _isFormValid =>
      _nameController.text.isNotEmpty && _urlController.text.isNotEmpty;

  void _resetForm() {
    _nameController.clear();
    _urlController.clear();
    _selectedStatus = WebsiteStatus.Active;
    setState(() => _showAddForm = false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WebsitesProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          backgroundColor: const Color(0xFF181A20),
          body: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Card(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(context, provider),
                    const SizedBox(height: 20),
                    if (_showAddForm)
                      AddWebsiteForm(
                        nameController: _nameController,
                        urlController: _urlController,
                        selectedStatus: _selectedStatus,
                        onStatusChanged: (status) =>
                            setState(() => _selectedStatus = status),
                        onCancel: _resetForm,
                        onSubmit: () async {
                          if (_isFormValid) {
                            final sessionProvider = SessionProvider.of(context);
                            await provider.addWebsite(
                              _nameController.text,
                              _urlController.text,
                              _selectedStatus,
                              sessionProvider.sessionID,
                              sessionProvider.userID,
                            );
                            _resetForm();
                          }
                        },
                      ),
                    WebsitesList(
                      provider: provider,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context, WebsitesProvider provider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Websites',
          style: TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        ElevatedButton.icon(
          icon: const Icon(Icons.add, size: 22),
          label: const Text(
            'Add Website',
            style: TextStyle(fontSize: 16),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 23, 87, 223),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: () => setState(() => _showAddForm = true),
        ),
      ],
    );
  }
}
