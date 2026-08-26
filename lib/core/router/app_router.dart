import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stockholding/features/HomeScreen/presentation/screens/HomeScreen.dart';

import '../../features/login/presentation/controllers/authenticate_controller.dart';
import '../../features/login/presentation/screens/LoginScreen.dart';
import '../../features/orderbook/domain/entity/orderBookResponse_parmams.dart';
import '../../features/orderbook/presentation/screens/OrderBookDetailScreen.dart';
import 'route_names.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: RouteNames.login,
    // Runs before every navigation attempt.
    redirect: (context, state) {
      final authResult = ref.read(authenticateControllerProvider).value;
      final goingToProtectedArea = state.matchedLocation == RouteNames.homescreen;

      if (goingToProtectedArea && (authResult == null || !authResult.isSuccess)) {
        return RouteNames.login; // not authenticated — bounce back
      }

      return null; // allowed — proceed to where they were going
    },
    routes: [
      GoRoute(
        path: RouteNames.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: RouteNames.homescreen,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/order-book/detail',
        name: 'orderBookDetail',
        builder: (context, state) {
          final item = state.extra as OrderBookItem?;
          if (item == null) {
            // guard against direct URL access / bad deep link
            return const Scaffold(
              body: Center(child: Text('No order data provided')),
            );
          }
          return OrderBookDetailScreen(item: item);
        },
      ),
    ],
  );
});