import 'package:flutter/material.dart';
import 'package:ia_web_front/views/content_list/Content_Body/content_body_topicclusters.dart';
import 'package:ia_web_front/views/content_list/content_body/content_body_gaps.dart';
import 'package:ia_web_front/views/content_list/content_body/content_body_list.dart';
import 'package:ia_web_front/views/content_list/content_body/content_body_performance.dart';
import 'package:ia_web_front/views/content_list/content_body/widgets/tab_bar_section.dart';
import 'package:ia_web_front/views/content_list/content_body/widgets/website_dropdown.dart';

class ContentBodyState extends StatefulWidget {
  const ContentBodyState({super.key});

  @override
  State<ContentBodyState> createState() => __ContentBodyStateState();
}

class __ContentBodyStateState extends State<ContentBodyState> {
  Map<String, String> webSites = {
    'Example Blog': 'https://example.com',
    'Component website': 'https://componentwebsite.net',
  };

  int selectedTab = 0;

  Map<int, Widget> contentWidgets = {
    0: ContentCardsList(),
    1: Performance(),
    2: TopicClusters(),
    3: ContentGaps(),
  };

  Widget _currentContentWidget = ContentCardsList();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(24.0),
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text('Content',
                    style:
                        TextStyle(fontSize: 34, fontWeight: FontWeight.bold)),
                Row(
                  children: [
                    Text('Selected Website:',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 92, 92, 92))),
                    SizedBox(width: 8),
                    WebsiteDropdown(
                        websites: webSites,
                        onAddWebsite:
                            () {}) // opciones para selecccionar website
                  ],
                ),
              ]),
              SizedBox(height: 16),
              TabBarSection(
                  selectedIndex: selectedTab,
                  onTabSelected: (index) => setState(() {
                        selectedTab = index;
                        _currentContentWidget = contentWidgets[selectedTab]!;
                      })),
              SizedBox(height: 16),
              Center(child: _currentContentWidget)
            ],
          ),
        ),
      ),
    );
  }
}
