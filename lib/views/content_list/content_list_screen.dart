import 'package:flutter/material.dart';
import 'package:ia_web_front/core/providers/session_provider.dart';
import 'package:ia_web_front/views/content_list/content_body/content_body.dart';
import 'package:ia_web_front/views/content_list/content_body/widgets/header_bar.dart';
import 'package:ia_web_front/views/content_list/controller/websites_controller.dart';
import 'package:ia_web_front/views/content_list/websites_body/website_body.dart';
import 'package:provider/provider.dart';

class ContentDashboardPage extends StatefulWidget {
  const ContentDashboardPage({super.key});

  @override
  State<ContentDashboardPage> createState() => _ContentDashboardPageState();
}

class _ContentDashboardPageState extends State<ContentDashboardPage> {
  int selectedAppBarTab = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final sessionProvider = SessionProvider.of(context);
      final websiteController =
          Provider.of<WebsiteController>(context, listen: false);
      websiteController.loadWebsites(
        sessionProvider.sessionID,
        sessionProvider.userID,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      appBar: CustomAppBar(
          selectedIndex: selectedAppBarTab,
          onTabSelected: (index) => setState(() {
                selectedAppBarTab = index;
              })),
      body: SingleChildScrollView(
          child: IndexedStack(
        index: selectedAppBarTab,
        children: [
          const WebsitesView(),
          const ContentBodyState(),
        ],
      )),
    );
  }
}
