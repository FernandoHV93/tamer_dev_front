import 'package:flutter/material.dart';
import 'package:ia_web_front/views/article_builder/article_builder.dart';
import 'package:ia_web_front/views/roadmap/roadmap_screen.dart';

class HomeCenterDesing extends StatelessWidget {
  const HomeCenterDesing({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Center(
        child: Column(children: [
          Text(
            'Welcome to the Content Management System',
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 15),
          Text(
            'Get started by navigating to any section using the header mennu above',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 100),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
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
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RoadmapScreen()));
                },
              ),
              MiddleHomeElement(
                headerTitle: 'Article Builder',
                subTitle: 'Create new content',
                function: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ArticleBuilderScreen()));
                },
              ),
              MiddleHomeElement(
                headerTitle: 'Article Editor',
                subTitle: 'Edit existing articles',
                function: () {},
              ),
            ],
          )
        ]),
      ),
    );
  }
}

class MiddleHomeElement extends StatelessWidget {
  final String headerTitle;
  final String subTitle;
  final VoidCallback function;

  const MiddleHomeElement(
      {super.key,
      required this.headerTitle,
      required this.subTitle,
      required this.function});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 20),
      child: ElevatedButton(
        onPressed: function,
        style: ElevatedButton.styleFrom(
            fixedSize: const Size(300, 100),
            backgroundColor: const Color.fromARGB(255, 211, 222, 229),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)))),
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Column(
            children: [
              Text(
                headerTitle,
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              Text(subTitle,
                  style: TextStyle(
                    color: Colors.black,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
