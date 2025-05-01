// app_constants.dart
import 'dart:ui';

import 'package:flutter/material.dart';

class AppConstants {
  static const double kHorizontalPadding = 200;
  static const double kDefaultPadding = 15;
  static const double kSectionSpacing = 25;

  static Map<String, String> languages = {
    'English(US)': 'assets/images/flags/usa.png',
    'Spanish': 'assets/images/flags/spain.png',
    'French': 'assets/images/flags/france.png',
    'German': 'assets/images/flags/germany.png',
    'Italian': 'assets/images/flags/italy.png',
  };

  static Map<String, IconData> articleTypes = {
    'None': Icons.do_not_disturb_alt,
    'How-to Guide': Icons.menu_book,
    'Listicle': Icons.format_list_bulleted,
    'Product Review': Icons.work,
    'News': Icons.newspaper,
  };

  static Map<String, String> sizeDetails = {
    'X-Small': '600-1200 words, H2 headings',
    'Small': '1200-2400 words, H2 headings',
    'Medium': '2400-3600 words, H2 headings',
    'Large': '3600-5200 words, H2 headings',
  };

  static List<String> aiModels = [
    'GPT-4',
    'GPT 3.5',
    'Claude 3 Haiku',
    'Claude 3 Sonnet',
    'GPT 4 Turbo',
    'Claude 3 Opus',
  ];

  static List<String> humanLevels = [
    'None',
    '5th Grade',
    '6th Grade',
    '7th Grade',
    '8th-9th Grade',
    '10th-12th Grade',
    'College',
    'College Graduate',
    'Professional'
  ];

  static Map<String, String> humanDescriptions = {
    'None': 'No AI words removal',
    '5th Grade': 'Very easy to read',
    '6th Grade': 'Easy to read',
    '7th Grade': 'Somewhat simple',
    '8th-9th Grade': 'Standard readability',
    '10th-12th Grade': 'Some complexity',
    'College': 'College level',
    'College Graduate': 'Advanced vocabulary',
    'Professional': 'Extremely difficult to read',
  };

  static List<Map<String, dynamic>> povOptions = [
    {
      'label': 'First Person Singular',
      'icon': Icons.person,
      'desc': 'I, me, my, mine'
    },
    {
      'label': 'First Person Plural',
      'icon': Icons.people,
      'desc': 'We, us, our, ours'
    },
    {
      'label': 'Second Person',
      'icon': Icons.person,
      'desc': 'You, your, yours'
    },
    {
      'label': 'Third Person',
      'icon': Icons.groups,
      'desc': 'He, she, it, they, their'
    },
  ];

  static List<Map<String, dynamic>> tones = [
    {'label': 'Normal', 'icon': Icons.record_voice_over},
    {'label': 'Friendly', 'icon': Icons.emoji_emotions},
    {'label': 'Casual', 'icon': Icons.chat},
    {'label': 'Professional', 'icon': Icons.business_center},
    {'label': 'Diplomatic', 'icon': Icons.handshake},
  ];

  static const List<String> aiImagesOptions = ['Yes', 'No'];

  static const List<int> numberOfImagesOptions = [0, 1, 2, 3, 4, 5, 6, 7, 8];

  static const List<String> imageStyles = [
    'None',
    'Photo',
    'Cartoon',
    'Cubism',
    'Expressionism',
    'Cyberpunk',
    'Fantasy',
    'Cinematic',
    'Abstract',
    'Impressionism',
    'Surrealism',
    'Anime',
    'Comic Book',
  ];

  static const List<String> imageSizes = [
    '1080x1920(9:16)',
    '1080x1350(4:5)',
    '1080x1080(1:1)',
    '1920x1080(16:9)',
    '1344x768(16:9)',
  ];

  static const List<String> youtubeVideosOptions = ['Yes', 'No'];

  static const List<int> numberOfVideosOptions = [0, 1, 2, 3];

  static const List<String> layoutOptions = [
    'One column',
    '2 columns',
    'Alternate image and video',
    'First image and then videos',
  ];

  static const List<String> contentOptions = [
    'Conclusion',
    'Tables',
    'H3',
    'Lists',
    'Italics',
    'Quotes',
    'Key Takeaways',
    'FAQ',
    'Bold',
    'Stats',
    'Real People Opinion'
  ];

  static const List<String> yesNoOptions = ['Yes', 'No'];

  static const List<String> hookOptions = [
    'Intriguing Question',
    'Statistical Impact',
    'Anecdotal',
    'Memorable Quote',
    'Contrast/Paradox',
    'Scene-Setting',
    'Universal Problem',
    'Surprising Revelation',
    'Prediction/Future',
    'Unique Definition',
  ];

  static const Map<String, String> hookPrompts = {
    'Intriguing Question':
        'Pose a question that sparks curiosity and invites the reader to reflect.',
    'Statistical Impact':
        'Use a surprising numerical fact to grab attention and create impact.',
    'Anecdotal':
        'Start with a brief personal story or experience that introduces the topic in a relatable way.',
    'Memorable Quote':
        'Begin with a relevant quote that reinforces the main idea of your content.',
    'Contrast/Paradox':
        'Present a contradiction or paradox that makes the reader question their prior knowledge.',
    'Scene-Setting':
        'Describe an immersive scene that pulls the reader into the context of the discussion.',
    'Universal Problem':
        'Highlight a common issue that many readers can relate to.',
    'Surprising Revelation':
        'Reveal an unexpected or little-known fact that shifts the reader’s perspective.',
    'Prediction/Future':
        'Make a prediction about how something will evolve in the future to captivate interest.',
    'Unique Definition':
        'Define a concept in an original or unconventional way to introduce a fresh perspective.',
  };

  static const Map<String, String> syndicationOptions = {
    'Twitter': 'assets/images/socialmedia/gorjeo.png',
    'LinkedIn': 'assets/images/socialmedia/linkedin.png',
    'Facebook': 'assets/images/socialmedia/facebook.png',
    'Email': 'assets/images/socialmedia/gmail.png',
    'WhatsApp': 'assets/images/socialmedia/whatsapp.png',
    'Pinterest': 'assets/images/socialmedia/pinterest.png',
  };

  static const Map<String, bool> selectedSyndication = {
    'Twitter': false,
    'LinkedIn': false,
    'Facebook': false,
    'Email': false,
    'WhatsApp': false,
    'Pinterest': false,
  };
}

// app_styles.dart
class AppTextStyles {
  static TextStyle headerTitle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w800,
  );

  static TextStyle subtitle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
  );

  static TextStyle sectionTitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w800,
  );
}
