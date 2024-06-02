import 'package:base_riverpod/core/routing/app_routes.dart';
import 'package:base_riverpod/features/home/presentation/home_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: '/home',
  routes: <RouteBase>[
    GoRoute(
      path: '/${AppRoutes.home.name}',
      name: AppRoutes.home.name,
      builder: (BuildContext context, GoRouterState state) {
        return const HomePage();
      },
    ),
  ],
);
