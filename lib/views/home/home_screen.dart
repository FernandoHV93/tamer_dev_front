import 'package:flutter/material.dart';
import 'package:ia_web_front/views/home/components/home_app_bar.dart';
import 'package:ia_web_front/views/home/components/home_center_desing.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.indigo[50],
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        )),
        title: Padding(
            padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
            child: HomeAppBarTitle()),
      ),
      body: HomeCenterDesing(),
    );
  }
}
