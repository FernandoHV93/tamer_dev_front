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

  @override
  void initState() {
    super.initState();
    // Cargar websites al inicializar la vista
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadWebsites();
    });
  }

  bool get _isFormValid =>
      _nameController.text.isNotEmpty && _urlController.text.isNotEmpty;

  void _resetForm() {
    _nameController.clear();
    _urlController.clear();
    _selectedStatus = WebsiteStatus.Active;
    setState(() => _showAddForm = false);
  }

  Future<void> _loadWebsites() async {
    final sessionProvider = SessionProvider.of(context);
    final provider = Provider.of<WebsitesProvider>(context, listen: false);
    await provider.loadWebsites(
      sessionProvider.sessionID,
      sessionProvider.userID,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WebsitesProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          backgroundColor: const Color(0xFFF8FAFC),
          body: SafeArea(
            child: Column(
              children: [
                _buildHeader(context, provider),
                const SizedBox(height: 32),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildStatsSection(provider),
                        const SizedBox(height: 24),
                        _buildContentSection(provider),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context, WebsitesProvider provider) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Websites',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Manage and organize your websites',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          ElevatedButton.icon(
            icon: const Icon(Icons.add, size: 20),
            label: const Text(
              'Add Website',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3B82F6),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 0,
            ),
            onPressed: () => setState(() => _showAddForm = true),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSection(WebsitesProvider provider) {
    final totalWebsites = provider.websites.length;
    final activeWebsites =
        provider.websites.where((w) => w.status == WebsiteStatus.Active).length;
    final inactiveWebsites = totalWebsites - activeWebsites;

    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildStatCard(
            'Total',
            totalWebsites.toString(),
            Icons.language,
            const Color(0xFF3B82F6),
          ),
          const SizedBox(width: 16),
          _buildStatCard(
            'Active',
            activeWebsites.toString(),
            Icons.check_circle,
            const Color(0xFF10B981),
          ),
          const SizedBox(width: 16),
          _buildStatCard(
            'Inactive',
            inactiveWebsites.toString(),
            Icons.pause_circle,
            const Color(0xFFF59E0B),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
      String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(icon, color: color, size: 16),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContentSection(WebsitesProvider provider) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                children: [
                  const Text(
                    'Your Websites',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  const Spacer(),
                  if (provider.isLoading)
                    const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                ],
              ),
            ),
            if (_showAddForm)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: AddWebsiteForm(
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
              ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: _loadWebsites,
                child: WebsitesList(
                  provider: provider,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
