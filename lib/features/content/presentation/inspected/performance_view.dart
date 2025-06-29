import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:ia_web_front/features/content/presentation/controller/performance_provider.dart';
import 'package:ia_web_front/features/content/presentation/widgets/loading_indicator.dart';
import 'package:ia_web_front/features/websites/domain/entities/website_entity.dart';
import 'package:ia_web_front/features/websites/presentation/controller/websites_provider.dart';
import 'package:ia_web_front/core/providers/session_provider.dart';

import 'content_body_inspected_website.dart';

class PerformanceView extends StatefulWidget {
  final SessionProvider sessionProvider;
  const PerformanceView({super.key, required this.sessionProvider});

  @override
  State<PerformanceView> createState() => _PerformanceViewState();
}

class _PerformanceViewState extends State<PerformanceView> {
  String selectedOption = 'Entire Website';
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<PerformanceProvider>(
      builder: (context, performanceProvider, child) {
        return Consumer<WebsitesProvider>(
          builder: (context, websitesProvider, child) {
            final WebsiteEntity? selectedWebsite =
                websitesProvider.selectedWebsite;

            if (performanceProvider.isLoading) {
              return const LoadingIndicator(text: 'Inspecting website...');
            }
            if (performanceProvider.error != null) {
              return Center(
                child: Text(
                  performanceProvider.error!,
                  style: const TextStyle(color: Colors.red, fontSize: 18),
                ),
              );
            }
            final inspected = performanceProvider.inspectedWebsites.isNotEmpty
                ? performanceProvider.inspectedWebsites.last
                : null;
            if (inspected != null) {
              return ContentBodyInspectedWebsite(inspectedWebsite: inspected);
            }
            return Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 500, minWidth: 400),
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(
                        color: Color.fromARGB(255, 204, 204, 204), width: 0.5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 40),
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/images/icons/worldwide.png',
                                height: 75,
                                width: 75,
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                "Website Inspection",
                                style: TextStyle(
                                    fontSize: 26, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                "Start analyzing your website's content and ",
                                style: TextStyle(fontSize: 18),
                              ),
                              const Text(
                                "performance ",
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text('Selected Website:',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Color.fromARGB(255, 38, 38, 38))),
                        const SizedBox(height: 5),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 244, 249, 252),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: const Color.fromARGB(255, 204, 204, 204),
                              width: 0.8,
                            ),
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                'assets/images/icons/worldwide.svg',
                                height: 20,
                                width: 20,
                                color: const Color.fromARGB(255, 92, 92, 92),
                              ),
                              const SizedBox(width: 6),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    selectedWebsite?.name ?? '',
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    selectedWebsite?.url ?? '',
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        color:
                                            Color.fromARGB(255, 126, 126, 126)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text('Inspection Type',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Color.fromARGB(255, 38, 38, 38))),
                        const SizedBox(height: 10),
                        Row(children: [
                          Checkbox(
                            value: selectedOption == 'Entire Website',
                            onChanged: (value) {
                              if (value == true) {
                                setState(() {
                                  selectedOption = 'Entire Website';
                                });
                              }
                            },
                            activeColor: const Color.fromARGB(255, 7, 77, 255),
                            checkColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          const Text('Entire Website',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black)),
                        ]),
                        Row(children: [
                          Checkbox(
                            value: selectedOption == 'Blog/Articles Only',
                            onChanged: (value) {
                              if (value == true) {
                                setState(() {
                                  selectedOption = 'Blog/Articles Only';
                                });
                              }
                            },
                            activeColor: const Color.fromARGB(255, 7, 77, 255),
                            checkColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          const Text('Blog/Articles Only',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black)),
                        ]),
                        const SizedBox(height: 20),
                        TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: isHovered
                                ? const Color.fromARGB(255, 5, 60, 200)
                                : const Color.fromARGB(198, 3, 56, 189),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                          ),
                          onHover: (hovering) {
                            setState(() {
                              isHovered = hovering;
                            });
                          },
                          onPressed: selectedWebsite == null
                              ? null
                              : () async {
                                  await performanceProvider.inspectWebsite(
                                    selectedWebsite,
                                    widget.sessionProvider.sessionID,
                                    widget.sessionProvider.userID,
                                  );
                                },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/images/icons/search.svg',
                                height: 40,
                                width: 40,
                                color: const Color.fromARGB(255, 255, 255, 255),
                              ),
                              const SizedBox(width: 10),
                              const Text('Start Website Inspection',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
