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
        borderRadius: BorderRadius.circular(18), // antes 24
      ),
      padding: const EdgeInsets.all(20), // antes 32
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // TOP
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Logo placeholder
              Container(
                width: 36, // antes 48
                height: 36, // antes 48
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(8), // antes 12
                ),
                child: SvgPicture.asset(
                  logoAssetPath,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(width: 12), // antes 18
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
                              .titleMedium // headlineSmall -> titleMedium
                              ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18, // antes 24 aprox
                              ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 5), // antes 18,8
                          decoration: BoxDecoration(
                            color: isConnected ? Colors.green : Colors.white,
                            borderRadius: BorderRadius.circular(16), // antes 24
                          ),
                          child: Text(
                            isConnected ? 'Connected' : 'Disconnected',
                            style: TextStyle(
                              color: isConnected
                                  ? Colors.white
                                  : const Color(0xFF23262F),
                              fontWeight: FontWeight.bold,
                              fontSize: 12, // antes 15
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2), // antes 4
                    // Descripción + link azul
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          description,
                          style: TextStyle(
                            color: Colors.grey[300],
                            fontSize: 13, // antes 15
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
                              fontSize: 12, // antes 14
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
          const SizedBox(height: 20), // antes 32
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
                        fontSize: 14, // antes 16
                      ),
                    ),
                    const SizedBox(height: 6), // antes 10
                    TextField(
                      controller: _controller,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14), // fontSize añadido
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFF181A20),
                        hintText: 'Enter your API key',
                        hintStyle: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 13), // fontSize añadido
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8), // antes 12
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: Icon(Icons.visibility,
                            color: Colors.grey[400], size: 18), // size reducido
                      ),
                      obscureText: true,
                      enabled: !isConnected,
                    ),
                    if (error != null && error!.isNotEmpty) ...[
                      const SizedBox(height: 6), // antes 8
                      Text(
                        error!,
                        style: const TextStyle(
                            color: Colors.red, fontSize: 11), // antes 13
                      ),
                    ],
                    const SizedBox(height: 12), // antes 18
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isConnected
                              ? Colors.red
                              : const Color(0xFF2D8EFF),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              vertical: 12), // antes 18
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8), // antes 12
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
                                width: 16, // antes 20
                                height: 16, // antes 20
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(
                                isConnected ? 'Disconnect' : 'Connect',
                                style:
                                    const TextStyle(fontSize: 14), // antes 16
                              ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 28), // antes 48
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
                        fontSize: 16, // antes 20
                      ),
                    ),
                    const SizedBox(height: 10), // antes 18
                    ...features.map((f) => Padding(
                          padding: const EdgeInsets.only(bottom: 8), // antes 12
                          child: Row(
                            children: [
                              Icon(Icons.check_circle,
                                  color: const Color(0xFF2D8EFF),
                                  size: 16), // antes 22
                              const SizedBox(width: 8), // antes 12
                              Expanded(
                                child: Text(
                                  f,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 13), // antes 16
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
