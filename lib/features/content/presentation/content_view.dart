import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ia_web_front/core/providers/session_provider.dart';
import 'package:ia_web_front/features/websites/domain/entities/website_entity.dart';
import 'package:ia_web_front/features/websites/presentation/controller/websites_provider.dart';
import 'package:ia_web_front/features/content/presentation/controller/content_provider.dart';
import 'package:ia_web_front/features/content/presentation/cards/content_cards_list.dart';
import 'package:ia_web_front/features/content/presentation/cards/inside_card.dart';
import 'package:ia_web_front/features/content/presentation/widgets/tab_bar_section.dart';
import 'package:ia_web_front/features/content/presentation/widgets/website_dropdown.dart';
import 'package:ia_web_front/features/content/presentation/topics/topic_clusters_view.dart';
import 'package:provider/provider.dart';
import 'package:ia_web_front/features/content/presentation/inspected/performance_view.dart';
import 'package:ia_web_front/features/content/presentation/widgets/content_body_gaps.dart';

class ContentView extends StatefulWidget {
  const ContentView({super.key});

  @override
  State<ContentView> createState() => _ContentViewState();
}

class _ContentViewState extends State<ContentView> {
  int selectedTab = 0;
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final sessionProvider = SessionProvider.of(context);

    return Container(
      color: const Color(0xFFF8FAFC),
      width: double.infinity,
      height: double.infinity,
      child: MultiProvider(
        providers: [
          Consumer<WebsitesProvider>(
            builder: (context, websitesProvider, child) {
              return Consumer<ContentProvider>(
                builder: (context, contentProvider, child) {
                  final websites = websitesProvider.websites;
                  return Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1200),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 32, horizontal: 16),
                        child: Card(
                          elevation: 3,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 32, horizontal: 32),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Content',
                                      style: TextStyle(
                                        fontSize: 36,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF1E293B),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        _ModernDialogButton(
                                          text: 'Save Changes',
                                          isPrimary: true,
                                          icon: SvgPicture.asset(
                                            'assets/images/icons/save_changes.svg',
                                            height: 22,
                                            width: 22,
                                            color: Colors.white,
                                          ),
                                          onPressed: () {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                    'Changes saved successfully!'),
                                                duration: Duration(seconds: 2),
                                              ),
                                            );
                                          },
                                        ),
                                        const SizedBox(width: 24),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 8),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFF3F4F6),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Row(
                                            children: [
                                              const Text(
                                                'Selected Website:',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xFF334155),
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              WebsiteDropdown(
                                                websites: websites,
                                                selectedWebsite:
                                                    websitesProvider
                                                        .selectedWebsite,
                                                onWebsiteSelected:
                                                    (WebsiteEntity website) {
                                                  websitesProvider
                                                      .selectWebsite(
                                                          website.id);
                                                },
                                                onAddWebsite: () {},
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 32),
                                TabBarSection(
                                  selectedIndex: selectedTab,
                                  onTabSelected: (index) => setState(() {
                                    selectedTab = index;
                                  }),
                                ),
                                const SizedBox(height: 32),
                                if (websites.isEmpty ||
                                    websitesProvider.selectedWebsite == null)
                                  Center(
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(24),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFF1F5F9),
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                          child: Icon(
                                            Icons.language_outlined,
                                            size: 48,
                                            color: Colors.grey[400],
                                          ),
                                        ),
                                        const SizedBox(height: 24),
                                        Text(
                                          'No websites yet',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.grey[700],
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          'Add your first website to get started',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey[500],
                                          ),
                                        ),
                                        const SizedBox(height: 24),
                                        ElevatedButton.icon(
                                          icon: const Icon(Icons.arrow_forward),
                                          label: const Text('Go to Websites'),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color(0xFF1757DF),
                                            foregroundColor: Colors.white,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 24, vertical: 14),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                          onPressed: () {
                                            Navigator.of(context)
                                                .pushNamed('/websites');
                                          },
                                        ),
                                      ],
                                    ),
                                  )
                                else
                                  Builder(
                                    builder: (context) {
                                      // Lógica de carga de cards y selección de primera card
                                      if (contentProvider.selectedWebsiteId !=
                                          websitesProvider
                                              .selectedWebsite!.id) {
                                        WidgetsBinding.instance
                                            .addPostFrameCallback((_) {
                                          contentProvider
                                              .loadContentCardsByWebsiteId(
                                            websitesProvider
                                                .selectedWebsite!.id,
                                            sessionProvider.sessionID,
                                            sessionProvider.userID,
                                          );
                                        });
                                      }

                                      if (selectedTab == 2 &&
                                          contentProvider.selectedCardId ==
                                              null &&
                                          contentProvider
                                              .contentCards.isNotEmpty) {
                                        WidgetsBinding.instance
                                            .addPostFrameCallback((_) {
                                          contentProvider.selectCard(
                                              contentProvider
                                                  .contentCards.first.id);
                                        });
                                      }

                                      return Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black
                                                  .withOpacity(0.03),
                                              blurRadius: 8,
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        padding: const EdgeInsets.all(24),
                                        child: IndexedStack(
                                          index: selectedTab,
                                          children: [
                                            // Mostrar InsideCard solo si isInsideCard es true
                                            contentProvider.isInsideCard
                                                ? InsideCard(
                                                    contentProvider:
                                                        contentProvider,
                                                    sessionProvider:
                                                        sessionProvider,
                                                    backOnPressed: () {
                                                      contentProvider
                                                          .clearSelection();
                                                    },
                                                  )
                                                : ContentCardsList(
                                                    contentProvider:
                                                        contentProvider,
                                                    sessionProvider:
                                                        sessionProvider,
                                                    onCardPressed: (cardId) {
                                                      contentProvider
                                                          .selectCard(cardId);
                                                    },
                                                  ),
                                            PerformanceView(
                                                sessionProvider:
                                                    sessionProvider),
                                            TopicClustersView(
                                                sessionProvider:
                                                    sessionProvider),
                                            const ContentGaps(),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

// Botón moderno reutilizable con icono opcional
class _ModernDialogButton extends StatefulWidget {
  final String text;
  final bool isPrimary;
  final bool isDestructive;
  final Widget? icon;
  final VoidCallback onPressed;
  const _ModernDialogButton(
      {required this.text,
      required this.isPrimary,
      this.isDestructive = false,
      this.icon,
      required this.onPressed});
  @override
  State<_ModernDialogButton> createState() => _ModernDialogButtonState();
}

class _ModernDialogButtonState extends State<_ModernDialogButton> {
  bool _hovered = false;
  @override
  Widget build(BuildContext context) {
    final color = widget.isDestructive
        ? const Color(0xFFBE0707)
        : (widget.isPrimary ? const Color(0xFF1757DF) : Colors.white);
    final textColor = widget.isDestructive
        ? Colors.white
        : (widget.isPrimary ? Colors.white : const Color(0xFF1757DF));
    final borderColor = widget.isDestructive
        ? const Color(0xFFBE0707)
        : (widget.isPrimary
            ? const Color(0xFF1757DF)
            : const Color(0xFFE5E7EB));
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: _hovered
              ? (widget.isDestructive
                  ? const Color(0xFF8B0505)
                  : (widget.isPrimary
                      ? const Color(0xFF1746B3)
                      : const Color(0xFFF3F4F6)))
              : color,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: borderColor, width: 1.5),
          boxShadow: _hovered && (widget.isPrimary || widget.isDestructive)
              ? [
                  BoxShadow(
                    color: (widget.isDestructive
                        ? const Color(0x33BE0707)
                        : const Color(0x331757DF)),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  )
                ]
              : null,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            splashColor: widget.isDestructive
                ? Colors.white24
                : (widget.isPrimary
                    ? Colors.white24
                    : const Color(0xFF1757DF).withOpacity(0.08)),
            onTap: widget.onPressed,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.icon != null) ...[
                    widget.icon!,
                    const SizedBox(width: 10),
                  ],
                  Text(
                    widget.text,
                    style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
