import 'package:agentebcp/routes/routes.dart';
import 'package:agentebcp/theme/appTheme.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Apptheme().getTheme(),
      debugShowCheckedModeBanner: false,
      title: 'Chat App',
      initialRoute: 'chat',
      routes: appRoutes,
    );
  }
}
