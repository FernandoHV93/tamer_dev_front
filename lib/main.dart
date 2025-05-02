import 'package:flutter/material.dart';
import 'package:ia_web_front/core/routes/route_generator.dart';
import 'package:ia_web_front/core/routes/web_routes.dart';

Future<void> main() async {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return MaterialApp(
          onGenerateRoute: RouteGenerator.onGenerate,
          initialRoute: WebRoutes.home,
          theme: ThemeData(
            useMaterial3: true,
            textTheme: constraints.maxWidth < 600
                ? ThemeData.light().textTheme.apply(
                    fontSizeFactor: 0.8) // Escala para pantallas pequeñas
                : ThemeData.light().textTheme,
          ),
        );
      },
    );
  }
}
