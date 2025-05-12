import 'package:flutter/material.dart';
import 'package:ia_web_front/views/article_builder/article_builder.dart';
import 'package:ia_web_front/views/article_editor_finish/article_editor_screen.dart';
import 'package:ia_web_front/views/roadmap/roadmap_screen.dart';

class HomeCenterDesing extends StatelessWidget {
  const HomeCenterDesing({super.key});

  @override
  Widget build(BuildContext context) {
    final userID = 'session123';
    final sessionID = 'user456';
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Center(
        child: Column(
          children: [
            Text(
              'Welcome to the Content Management System',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: screenWidth < 600 ? 24 : 40,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              'Get started by navigating to any section using the header menu above',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: screenWidth < 600 ? 14 : 18,
              ),
            ),
            const SizedBox(height: 100),
            Wrap(
              spacing: 20,
              runSpacing: 20,
              alignment: WrapAlignment.center,
              children: [
                MiddleHomeElement(
                  headerTitle: 'Content List',
                  subTitle: 'Manage your articles',
                  function: () {},
                ),
                MiddleHomeElement(
                  headerTitle: 'Roadmap',
                  subTitle: 'View the development roadmap',
                  function: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RoadmapScreen(),
                      ),
                    );
                  },
                ),
                MiddleHomeElement(
                  headerTitle: 'Article Builder',
                  subTitle: 'Create new content',
                  function: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ArticleBuilderScreen(
                          sessionID: sessionID,
                          userID: userID,
                        ),
                      ),
                    );
                  },
                ),
                MiddleHomeElement(
                  headerTitle: 'Article Editor',
                  subTitle: 'Edit existing articles',
                  function: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ArticleEditorScreen(
                          sessionID: sessionID,
                          userID: userID,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MiddleHomeElement extends StatelessWidget {
  final String headerTitle;
  final String subTitle;
  final VoidCallback function;

  const MiddleHomeElement({
    super.key,
    required this.headerTitle,
    required this.subTitle,
    required this.function,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: const EdgeInsets.only(right: 20),
      child: ElevatedButton(
        onPressed: function,
        style: ElevatedButton.styleFrom(
          fixedSize: Size(
            screenWidth < 600 ? 200 : 300,
            screenWidth < 600 ? 80 : 100,
          ),
          backgroundColor: const Color.fromARGB(255, 211, 222, 229),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Column(
            children: [
              Text(
                headerTitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: screenWidth < 600 ? 20 : 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                subTitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
