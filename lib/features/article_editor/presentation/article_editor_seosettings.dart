import 'package:flutter/material.dart';

class SeoSettingsWidget extends StatefulWidget {
  const SeoSettingsWidget({super.key});

  @override
  State<SeoSettingsWidget> createState() => _SeoSettingsWidgetState();
}

class _SeoSettingsWidgetState extends State<SeoSettingsWidget> {
  bool _expanded = false;

  late final TextEditingController _titleController;
  late final TextEditingController _slugController;
  late final TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _slugController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _slugController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 45, 45, 46),
      margin: EdgeInsets.only(bottom: 10),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: Column(
        children: [
          // Header
          ListTile(
            title: const Text(
              'SEO Settings',
              style: TextStyle(color: Colors.white),
            ),
            trailing: IconButton(
              icon: Icon(
                _expanded ? Icons.expand_less : Icons.expand_more,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() => _expanded = !_expanded);
              },
            ),
          ),

          if (_expanded) const Divider(color: Colors.white12),

          // Preview section
          if (_expanded)
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16, horizontal: 100),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Search Result Preview',
                      style: TextStyle(
                        color: Color.fromARGB(255, 139, 139, 139),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 7),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(51, 64, 150, 255),
                      ),
                      child: const Text(
                        'Google Desktop',
                        style: TextStyle(
                          color: Color.fromARGB(255, 106, 167, 241),
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(16),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 37, 37, 37),
                    borderRadius: BorderRadius.zero,
                    border: Border.fromBorderSide(
                        BorderSide(color: Colors.white10)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'https://${_slugController.text.isNotEmpty ? _slugController.text : "example.com"}/',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color.fromARGB(255, 112, 160, 255),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _titleController.text.isNotEmpty
                            ? _titleController.text
                            : "Your Title Will Appear Here",
                        style: const TextStyle(
                          fontSize: 18,
                          color: Color.fromARGB(255, 112, 160, 255),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _descriptionController.text.isNotEmpty
                            ? _descriptionController.text
                            : "Your meta description will be displayed here. Make it compelling and informative to improve clock-through rates.",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color.fromARGB(255, 195, 195, 195),
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ),

          // Input fields
          if (_expanded)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _buildFieldWithButtonRow(
                          label: 'Title',
                          maxLines: 1,
                          controller: _titleController,
                          buttonLabel: 'Generate',
                          hintText:
                              'Enter a compelling title (Google displays ~60 characters)',
                          icon: Icons.circle_outlined,
                          maxLength: 60,
                          onChanged: (_) => setState(() {}),
                          onButtonPressed: () {
                            _titleController.text = 'Auto Generated Title';
                            setState(() {});
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildFieldWithButtonRow(
                          label: 'URL Slug',
                          maxLines: 1,
                          controller: _slugController,
                          buttonLabel: 'Set Keyword',
                          hintText:
                              'https://example.com/ enter-url-slug (Google displays ~75 characters)',
                          icon: Icons.circle_outlined,
                          maxLength: 75,
                          onChanged: (_) => setState(() {}),
                          onButtonPressed: () {
                            _slugController.text = 'auto-keyword';
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildFieldWithButtonRow(
                      label: 'Meta Description',
                      maxLines: 3,
                      buttonLabel: 'Generate',
                      hintText:
                          'Write a compelling meta description that encourages clicks (Google diplays ~160 characteres)',
                      icon: Icons.circle_outlined,
                      maxLength: 160,
                      controller: _descriptionController,
                      onChanged: (_) => setState(() {}),
                      onButtonPressed: () {}),
                  const SizedBox(height: 15),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFieldWithButtonRow({
    required String label,
    required TextEditingController controller,
    required String buttonLabel,
    required Function(String) onChanged,
    required VoidCallback onButtonPressed,
    required int maxLines,
    required int maxLength,
    required hintText,
    required IconData icon,
  }) {
    final charCount = ValueNotifier<int>(controller.text.length);

    controller.addListener(() {
      charCount.value = controller.text.length;
    });

    return Column(children: [
      Row(
        children: [
          Text(
            label,
            style: TextStyle(color: Colors.white70),
          ),
          Spacer(),
          Container(
            decoration: BoxDecoration(
                color: const Color.fromARGB(74, 33, 89, 243),
                borderRadius: BorderRadius.zero),
            child: TextButton.icon(
              onPressed: onButtonPressed,
              icon: Icon(icon, size: 16),
              label: Text(buttonLabel),
              style: TextButton.styleFrom(
                foregroundColor: Colors.lightBlueAccent,
              ),
            ),
          ),
          const SizedBox(width: 8),
          ValueListenableBuilder<int>(
            valueListenable: charCount,
            builder: (_, value, __) {
              final color = value > maxLength
                  ? const Color.fromARGB(255, 255, 17, 0)
                  : value > (maxLength * 0.9)
                      ? const Color.fromARGB(255, 255, 230, 0)
                      : value == 0
                          ? Colors.grey
                          : const Color.fromARGB(255, 54, 254, 60);
              return Container(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  '$value/$maxLength',
                  style: TextStyle(color: color, fontSize: 12),
                ),
              );
            },
          ),
        ],
      ),
      const SizedBox(
        height: 6,
      ),
      _buildTextField(
          controller: controller,
          onChanged: onChanged,
          maxLines: maxLines,
          hintText: hintText),
    ]);
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required maxLines,
    required String hintText,
    required Function(String) onChanged,
  }) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      maxLines: maxLines,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: const Color.fromARGB(255, 37, 37, 37),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.zero,
        ),
      ),
    );
  }
}
