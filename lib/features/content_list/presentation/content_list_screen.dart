import 'package:flutter/material.dart';
import 'package:ia_web_front/features/content_list/presentation/content_body/content_body.dart';
import 'package:ia_web_front/features/content_list/presentation/content_body/widgets/header_bar.dart';
import 'package:ia_web_front/features/content_list/presentation/websites_body/website_body.dart';

class ContentDashboardPage extends StatefulWidget {
  final int selectedAppBarTab;
  const ContentDashboardPage({super.key, required this.selectedAppBarTab});

  @override
  State<ContentDashboardPage> createState() => _ContentDashboardPageState();
}

class _ContentDashboardPageState extends State<ContentDashboardPage> {
  late int _selectedTab;

  @override
  void initState() {
    super.initState();
    _selectedTab = widget.selectedAppBarTab;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      appBar: CustomAppBar(
          selectedIndex: _selectedTab,
          onTabSelected: (index) => setState(() {
                _selectedTab = index;
              })),
      body: SingleChildScrollView(
          child: IndexedStack(
        index: _selectedTab,
        children: [
          const WebsitesView(),
          const ContentBodyState(),
        ],
      )),
    );
  }
}
