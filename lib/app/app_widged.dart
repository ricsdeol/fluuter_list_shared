import 'package:flutter/material.dart';
import 'package:routefly/routefly.dart';

import '../routes.dart';

class AppWidged extends StatelessWidget {
  const AppWidged({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'MercadoParts Totem',
      routerConfig: Routefly.routerConfig(
        routes: routes,
        initialPath: routePaths.splash,
      ),
    );
  }
}
