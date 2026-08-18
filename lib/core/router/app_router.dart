import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stockholding/features/HomeScreen/presentation/screens/HomeScreen.dart';
import 'package:stockholding/features/orderbook/presentation/screens/orderBook_screen.dart';


import '../../features/login/presentation/controllers/authenticate_controller.dart';
import '../../features/login/presentation/screens/LoginScreen.dart';
import '../../features/position/presentation/screens/position_screen.dart';
import '../../features/watchlist/presentation/screens/watchlist_screen.dart';
import 'route_names.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: RouteNames.login,
    // Runs before every navigation attempt.
    redirect: (context, state) {
      final authResult = ref.read(authenticateControllerProvider).value;
      final goingToWatchlist = state.matchedLocation == RouteNames.watchlist;

      if (goingToWatchlist && (authResult == null || !authResult.isSuccess)) {
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
        path: RouteNames.watchlist,
        builder: (context, state) => const WatchlistScreen(),
      ),
      GoRoute(
        path: RouteNames.orderbook,
        builder: (context, state) => const OrderBookScreen(),
      ),
      GoRoute(
        path: RouteNames.homescreen,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: RouteNames.homescreen,
        builder: (context, state) => const PositionScreen(),
      ),
    ],
  );
});