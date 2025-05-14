import 'package:flutter/cupertino.dart';

class SessionProvider extends InheritedWidget {
  final sessionID;
  final userID;

  const SessionProvider(
      {super.key,
      required this.sessionID,
      required this.userID,
      required super.child});

  static SessionProvider of(BuildContext context) {
    return context.findAncestorWidgetOfExactType<SessionProvider>()!;
  }

  @override
  bool updateShouldNotify(SessionProvider oldWidget) {
    return oldWidget.sessionID != sessionID || oldWidget.userID != userID;
  }
}
