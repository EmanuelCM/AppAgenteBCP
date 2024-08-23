import 'package:agentebcp/pages/pages.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> appRoutes = {
  'usuarios': (_) => UsuariosPage(),
  'chat': (_) => ChatsPage(),
  'login': (_) => LoginPage(),
  'register': (_) => RegisterPage(),
  'loading': (_) => LoadingPage(),
};
