import 'package:flutter/material.dart';
import 'package:ia_web_front/core/desing/app_constant.dart';
import 'package:ia_web_front/features/article_editor/presentation/widgets/top_options_button.dart';

class ArticleEditorTop extends StatelessWidget {
  const ArticleEditorTop({
    super.key,
    required this.buttonActions,
  });

  final Map<String, VoidCallback> buttonActions;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 41, 41, 41),
      child: Padding(
        padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
        child: Column(children: [
          Row(
            children: [
              ...AppConstants.articleEditorleftButtons.map((text) {
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: TopOptionsButton(
                    onPressed: buttonActions[text]!,
                    text: text,
                  ),
                );
              }),
              const Spacer(),
              ...AppConstants.articleEditorightButtons.map((text) {
                return Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: TopOptionsButton(
                    onPressed: buttonActions[text]!,
                    text: text,
                  ),
                );
              }),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Article Editor',
            style: TextStyle(
                fontSize: 40,
                color: Colors.blueAccent,
                fontWeight: FontWeight.w900),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 60),
            child: Column(children: [
              Text(
                'Create stunning articles with our powerful editor. Optimize your content with ',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey),
              ),
              Text(
                'integrated SEO tools and real-time formatting options.',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey),
              )
            ]),
          )
        ]),
      ),
    );
  }
}
