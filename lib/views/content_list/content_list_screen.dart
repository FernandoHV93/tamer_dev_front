import 'package:flutter/material.dart';
import 'package:ia_web_front/views/content_list/content_body/content_body.dart';
import 'package:ia_web_front/views/content_list/content_body/widgets/header_bar.dart';
import 'package:ia_web_front/views/content_list/websites_body/website_body.dart';

class ContentDashboardPage extends StatefulWidget {
  const ContentDashboardPage({super.key});

  @override
  State<ContentDashboardPage> createState() => _ContentDashboardPageState();
}

class _ContentDashboardPageState extends State<ContentDashboardPage> {
  int selectedAppBarTab = 0;

  Map<int, Widget> bodySections = {
    0: WebsitesView(),
    1: ContentBodyState(),
  };

  Map<String, String> webSites = {
    'Example Blog': 'https://example.com',
    'Component website': 'https://componentwebsite.net',
  };

  Widget _currentContentListScreenBody = WebsitesView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      appBar: CustomAppBar(
          selectedIndex: selectedAppBarTab,
          onTabSelected: (index) => setState(() {
                selectedAppBarTab = index;
                _currentContentListScreenBody =
                    bodySections[selectedAppBarTab]!;
              })),
      body: SingleChildScrollView(child: _currentContentListScreenBody),
    );
  }
}
