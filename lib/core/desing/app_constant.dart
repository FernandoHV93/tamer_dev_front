import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppConstants {
  static const double kHorizontalPadding = 200;
  static const double kDefaultPadding = 15;
  static const double kSectionSpacing = 25;
  static const double kArticleBuilderMaxWidth = 1000;

  static Map<String, String> languages = {
    'English(US)': 'assets/images/flags/usa.png',
    'Spanish': 'assets/images/flags/spain.png',
    'French': 'assets/images/flags/france.png',
    'German': 'assets/images/flags/germany.png',
    'Italian': 'assets/images/flags/italy.png',
  };

  static const articleEditorleftButtons = ['Download', 'Export'];

  // Botones del lado derecho
  static const articleEditorightButtons = ['Publish', 'Save Draft', 'Done'];

  static const List<Map<String, dynamic>> articleEditorformatButtons = [
    {
      'icon': FontAwesomeIcons.bold,
      'key': 'isBold', // Clave para identificar el estado
    },
    {
      'icon': FontAwesomeIcons.italic,
      'key': 'isItalic',
    },
    {
      'icon': FontAwesomeIcons.underline,
      'key': 'isUnderline',
    },
  ];

  // Tamaños de texto
  static const List<String> articleEditortextSizes = [
    'P',
    'H1',
    'H2',
    'H3',
    'H4'
  ];

  // Botones de alineación y listas
  static const List<Map<String, dynamic>> articleEditoralignmentButtons = [
    {
      'icon': FontAwesomeIcons.alignLeft,
      'key': TextAlign.left,
    },
    {
      'icon': FontAwesomeIcons.alignCenter,
      'key': TextAlign.center,
    },
    {
      'icon': FontAwesomeIcons.alignRight,
      'key': TextAlign.right,
    },
    {
      'icon': FontAwesomeIcons.listUl,
      'key': 'bulletedList', // Clave para listas con puntos
    },
    {
      'icon': FontAwesomeIcons.listOl,
      'key': 'numberedList', // Clave para listas numeradas
    },
  ];

  static Map<String, String> textIconButton = {
    'Download': 'assets/images/icons/download.svg',
    'Export': 'assets/images/icons/export.svg',
    'Publish': 'assets/images/icons/publish.svg',
    'Save Draft': 'assets/images/icons/save_draft.svg',
    'Done': 'assets/images/icons/check.svg'
  };

  static Map<String, Color> textButtonIconColors = {
    'Download': Colors.white,
    'Export': Colors.white,
    'Publish': Colors.lightBlue,
    'Save Draft': Colors.orangeAccent,
    'Done': Colors.green
  };

  static Map<String, Color> textButtonColors = {
    'Download': const Color.fromARGB(193, 26, 25, 25),
    'Export': Color.fromARGB(193, 26, 25, 25),
    'Publish': const Color.fromARGB(41, 82, 147, 233),
    'Save Draft': const Color.fromARGB(41, 241, 222, 95),
    'Done': const Color.fromARGB(42, 130, 213, 131)
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
        """Purpose: Directly engages readers by making them reflect on their own experiences or opinions.
Focus: Creates immediate mental involvement and personal connection
Best for: Self-help, educational content, opinion pieces
Example:
Have you ever noticed how the most successful people aren't necessarily the most talented? In fact, research shows that 85% of financial success is due to soft skills, not technical expertise...""",
    'Statistical Impact':
        """Purpose: Establishes credibility while shocking or surprising the audience
Focus: Uses data to create an immediate impact and build authority
Best for: Business articles, research pieces, trend analysis
Example:
Only 0.1% of startups become unicorns, yet last year, 500 companies achieved this status. What's their secret formula? The answer lies in three unexpected factors...""",
    'Anecdotal': """"Purpose: Creates emotional connection through storytelling
Focus: Makes complex topics relatable through personal experiences
Best for: Personal development, case studies, biographical pieces
Example:
At 3 AM in his garage, Jeff was about to give up on his 10th failed prototype. His savings were gone, his wife was skeptical, and his dream seemed impossible. Today, that 'failed' prototype is a billion-dollar product used in every household...""",
    'Memorable Quote':
        """Purpose: Leverages authority and wisdom of recognized figures
Focus: Adds credibility and provides philosophical foundation
Best for: Leadership articles, motivational pieces, historical analysis
Example:
'Innovation distinguishes between a leader and a follower,' Steve Jobs once said. But in today's digital age, this distinction has taken on an entirely new meaning. Let me show you why...""",
    'Contrast/Paradox': """Purpose: Creates intellectual tension and curiosity
Focus: Highlights unexpected connections or contradictions
Best for: Analysis pieces, trend reports, social commentary
Example:
In an era where we have more dating apps than ever before, loneliness rates have skyrocketed by 300%. This seemingly paradoxical trend reveals a crucial truth about modern relationships...""",
    'Scene-Setting':
        """Purpose: Immerses readers in a specific moment or environment
Focus: Creates vivid mental imagery and emotional atmosphere
Best for: Feature articles, travel writing, narrative journalism
Example:
The fluorescent lights flickered in Silicon Valley's most secretive lab, where a team of twenty-somethings hadn't slept in 72 hours. They were about to change the internet forever, but they didn't know it yet...""",
    'Universal Problem':
        """Purpose: Creates immediate relatability through shared experiences
Focus: Addresses common pain points or challenges
Best for: Problem-solution articles, self-help content, product reviews
Example:
The average professional spends 28% of their workday dealing with email overload, resulting in 2.5 hours of lost productivity daily. But what if there was a way to reclaim those lost hours?""",
    'Surprising Revelation':
        """Purpose: Challenges conventional wisdom with unexpected information
Focus: Creates immediate interest through counterintuitive facts
Best for: Myth-busting articles, investigative pieces, research findings
Example:
Everything you know about productivity is wrong. The world's most effective executives don't use to-do lists, don't aim for inbox zero, and definitely don't wake up at 5 AM...""",
    'Prediction/Future':
        """Purpose: Captures interest through forward-thinking scenarios
Focus: Addresses future implications of current trends
Best for: Tech articles, trend analysis, industry forecasts
Example:
By 2030, 60% of today's jobs won't exist. But instead of spelling disaster, this transformation is creating the biggest wealth opportunity in human history...""",
    'Unique Definition':
        """Purpose: Reframes familiar concepts in new, thought-provoking ways
Focus: Challenges readers' existing perspectives
Best for: Thought leadership, conceptual pieces, philosophical articles
Example:
Procrastination isn't a time management problem - it's an emotion management challenge. This simple shift in definition has helped thousands of people finally overcome their productivity struggles...""",
  };

  static const Map<String, String> syndicationOptions = {
    'twitterPost': 'assets/images/socialmedia/gorjeo.png',
    'linkedinPost': 'assets/images/socialmedia/linkedin.png',
    'facebookPost': 'assets/images/socialmedia/facebook.png',
    'emailNewsletter': 'assets/images/socialmedia/gmail.png',
    'whatsappMessage': 'assets/images/socialmedia/whatsapp.png',
    'pinterestPin': 'assets/images/socialmedia/pinterest.png',
  };

  static const Map<String, bool> selectedSyndication = {
    'twitterPost': false,
    'linkedinPost': false,
    'facebookPost': false,
    'emailNewsletter': false,
    'whatsappMessage': false,
    'pinterestPin': false,
  };
}
