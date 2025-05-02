import 'package:flutter/material.dart';

class HomeAppBarTitle extends StatelessWidget {
  const HomeAppBarTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Wrap(
      spacing: screenWidth < 600 ? 10 : 20,
      alignment: WrapAlignment.center,
      children: [
        TopBarElement(
          text: 'Websites',
          onPressed: () {},
        ),
        TopBarElement(
          text: 'Content',
          onPressed: () {},
        ),
        TopBarElement(
          text: 'Article Builder',
          onPressed: () {},
        ),
        TopBarElement(
          text: 'Article Editor',
          onPressed: () {},
        ),
        TopBarElement(
          text: 'Brand Voice',
          onPressed: () {},
        ),
        TopBarElement(
          text: 'API Settings',
          onPressed: () {},
        ),
      ],
    );
  }
}

class TopBarElement extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const TopBarElement({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 20),
      child: TextButton(
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(
                fontSize: 25.0,
                color: Colors.black,
                fontWeight: FontWeight.bold),
          )),
    );
  }
}
