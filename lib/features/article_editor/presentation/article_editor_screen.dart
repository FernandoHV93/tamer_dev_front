import 'package:flutter/material.dart';
import 'package:ia_web_front/features/article_builder/data/dto_to_model.dart';
import 'package:ia_web_front/features/article_editor/domain/entities/article_entity_dto.dart';
import 'package:ia_web_front/features/article_editor/presentation/article_editor_seosettings.dart';
import 'package:ia_web_front/features/article_editor/presentation/article_editor_toolbar.dart';
import 'package:ia_web_front/features/article_editor/presentation/article_editor_top.dart';
import 'package:ia_web_front/features/article_editor/presentation/controllers/widgets_controller.dart';
import 'package:ia_web_front/features/article_editor/presentation/widgets_render.dart';

import 'package:provider/provider.dart';

class ArticleEditorScreen extends StatelessWidget {
  final ArticleDto? initialArticleDto;

  const ArticleEditorScreen({super.key, this.initialArticleDto});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => WidgetsController(),
      child: _ArticleEditorScreenContent(initialArticleDto: initialArticleDto),
    );
  }
}

class _ArticleEditorScreenContent extends StatefulWidget {
  final ArticleDto? initialArticleDto;
  const _ArticleEditorScreenContent({this.initialArticleDto});

  @override
  State<_ArticleEditorScreenContent> createState() =>
      _ArticleEditorScreenContentState();
}

class _ArticleEditorScreenContentState
    extends State<_ArticleEditorScreenContent> {
  late final WidgetsController _controller;

  @override
  void initState() {
    super.initState();
    _controller = context.read<WidgetsController>();
    if (widget.initialArticleDto != null) {
      mapArticleDtoToBlocks(widget.initialArticleDto!, _controller);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, VoidCallback> buttonActions = {
      'Download': () {
        debugPrint('Download button pressed');
      },
      'Export': () {
        debugPrint('Export button pressed');
      },
      'Publish': () {
        debugPrint('Publish button pressed');
      },
      'Save Draft': () {
        debugPrint('Save Draft button pressed');
      },
      'Done': () {
        debugPrint('Done button pressed');
      },
    };

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 30, 30, 30),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ArticleEditorTop(buttonActions: buttonActions),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SeoSettingsWidget(),
                    const ArticleEditorToolbar(),
                    const SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 45, 45, 46),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: const Color.fromARGB(255, 73, 73, 73),
                        ),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Consumer<WidgetsController>(
                        builder: (_, controller, __) {
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: controller.blocks.length,
                            itemBuilder: (context, index) {
                              final block = controller.blocks[index];
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: WidgetRenderer(block: block),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
