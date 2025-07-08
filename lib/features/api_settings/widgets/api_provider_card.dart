import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ApiProviderCard extends StatelessWidget {
  final String providerName;
  final String logoAssetPath;
  final String description;
  final String learnUrl;
  final List<String> features;
  final bool isConnected;
  final bool isLoading;
  final Future<void> Function(String apiKey) onConnect;
  final Future<void> Function()? onDisconnect;
  final String? error;

  const ApiProviderCard({
    super.key,
    required this.providerName,
    required this.logoAssetPath,
    required this.description,
    required this.learnUrl,
    required this.features,
    required this.isConnected,
    required this.onConnect,
    required this.isLoading,
    this.onDisconnect,
    this.error,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF23262F),
        borderRadius: BorderRadius.circular(24),
      ),
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // TOP
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Logo placeholder
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: SvgPicture.asset(
                  logoAssetPath,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(width: 18),
              // Expanded for title, disconnected, description
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          providerName,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 8),
                          decoration: BoxDecoration(
                            color: isConnected ? Colors.green : Colors.white,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Text(
                            isConnected ? 'Connected' : 'Disconnected',
                            style: TextStyle(
                              color: isConnected
                                  ? Colors.white
                                  : const Color(0xFF23262F),
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    // Descripción + link azul
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          description,
                          style: TextStyle(
                            color: Colors.grey[300],
                            fontSize: 15,
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            if (await canLaunchUrl(Uri.parse(learnUrl))) {
                              await launchUrl(Uri.parse(learnUrl),
                                  mode: LaunchMode.externalApplication);
                            }
                          },
                          child: const Text(
                            'Learn how to get your API key →',
                            style: TextStyle(
                              color: Color(0xFF4FC3F7),
                              fontSize: 14,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          // BODY
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // API Key column
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'API Key',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _controller,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFF181A20),
                        hintText: 'Enter your API key',
                        hintStyle: TextStyle(color: Colors.grey[500]),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon:
                            Icon(Icons.visibility, color: Colors.grey[400]),
                      ),
                      obscureText: true,
                      enabled: !isConnected,
                    ),
                    if (error != null && error!.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Text(
                        error!,
                        style: const TextStyle(color: Colors.red, fontSize: 13),
                      ),
                    ],
                    const SizedBox(height: 18),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isConnected
                              ? Colors.red
                              : const Color(0xFF2D8EFF),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: isLoading
                            ? null
                            : isConnected
                                ? onDisconnect
                                : () async {
                                    await onConnect(_controller.text);
                                  },
                        child: isLoading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(
                                isConnected ? 'Disconnect' : 'Connect',
                                style: const TextStyle(fontSize: 16),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 48),
              // Features column
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Features',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 18),
                    ...features.map((f) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Row(
                            children: [
                              Icon(Icons.check_circle,
                                  color: const Color(0xFF2D8EFF), size: 22),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  f,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
