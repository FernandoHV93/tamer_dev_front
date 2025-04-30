import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ia_web_front/core/routes/route_generator.dart';
import 'package:ia_web_front/core/routes/web_routes.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: RouteGenerator.onGenerate,
      initialRoute: WebRoutes.articleBuilder,
      theme: ThemeData(
        useMaterial3: true,
      ),
    );
  }
}
