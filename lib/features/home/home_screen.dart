import 'package:flutter/material.dart';
import 'package:ia_web_front/features/home/components/home_app_bar.dart';
import 'package:ia_web_front/features/home/components/home_center_desing.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: screenWidth < 600 ? 70 : 100,
        backgroundColor: Colors.indigo[50],
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
        ),
        title: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: screenWidth < 600 ? 20 : 50),
          child: const HomeAppBarTitle(),
        ),
      ),
      body: const HomeCenterDesing(),
    );
  }
}
