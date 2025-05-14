import 'package:flutter/material.dart';
import 'package:ia_web_front/core/providers/session_provider.dart';
import 'package:ia_web_front/core/utils/dto_to_model.dart';
import 'package:ia_web_front/data/repository_impl/article_impl.dart';
import 'package:ia_web_front/domain/use_cases/gen_article.dart';
import 'package:ia_web_front/views/article_editor_finish/article_editor_toolbar.dart';
import 'package:ia_web_front/views/article_editor_finish/widgets_render.dart';
import 'package:provider/provider.dart';
import 'package:ia_web_front/views/article_editor_finish/controllers/widgets_controller.dart';
import 'package:ia_web_front/views/article_editor_finish/article_editor_top.dart';

class ArticleEditorScreen extends StatefulWidget {
  const ArticleEditorScreen({
    super.key,
  });

  @override
  State<ArticleEditorScreen> createState() => _ArticleEditorScreenState();
}

class _ArticleEditorScreenState extends State<ArticleEditorScreen> {
  late final WidgetsController _controller;

  @override
  void initState() {
    super.initState();
    final sessionProvider = SessionProvider.of(context);
    var useCase = FetchGeneratedArticle(ArticleFuncImpl());
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final dto = await useCase.execute(
        sessionProvider.sessionID,
        sessionProvider.userID,
      );
      mapArticleDtoToBlocks(dto, _controller);
    });
  }

  @override
  Widget build(BuildContext context) {
    _controller = context.read<WidgetsController>();

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
