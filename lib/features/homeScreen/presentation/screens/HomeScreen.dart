import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stockholding/features/HomeScreen/presentation/controllers/home_screen_controllers.dart';
import 'package:stockholding/features/holding/presentation/controllers/holding_controller.dart';
import 'package:stockholding/features/holding/presentation/screens/holding_screen.dart';
import 'package:stockholding/features/orderbook/presentation/controllers/orderBook_controller.dart';
import 'package:stockholding/features/orderbook/presentation/screens/orderBook_screen.dart';
import 'package:stockholding/features/position/presentation/controllers/position_controller.dart';
import 'package:stockholding/features/sipbook/presentation/controllers/sipBook_controller.dart';
import 'package:stockholding/features/sipbook/presentation/screens/sipBook_screen.dart';
import 'package:stockholding/features/watchlist/presentation/controllers/wlDetails_controller.dart';
import 'package:stockholding/features/watchlist/presentation/screens/watchlist_screen.dart';

import '../../../position/presentation/screens/position_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  static const List<Widget> _pages = [
    WatchlistScreen(),
    OrderBookScreen(),
    SipBookScreen(),
    PositionScreen(),
    HoldingScreen(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(bottomNavProvider);

    return Scaffold(
      body: IndexedStack(index: selectedIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        currentIndex: selectedIndex,
        onTap: (index) {
          if (selectedIndex != index) {
            ref.read(bottomNavProvider.notifier).changeTab(index);
            switch (index) {
              case 0:
                ref.invalidate(wlDetailsControllerProvider);
                break;
              case 1:
                ref.invalidate(orderBokDetailsControllerProvider);
                break;
              case 2:
                ref.invalidate(sipBookDetailsControllerProvider);
                break;
              case 3:
                ref.invalidate(positionControllerProvider);
                break;
              case 4:
                ref.invalidate(holdingDetailsControllerProvider);
                break;
            }
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.visibility), label: 'Watchlist'),
          BottomNavigationBarItem(icon: Icon(Icons.receipt_long), label: 'Orderbook'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: 'Sipbook'),
          BottomNavigationBarItem(icon: Icon(Icons.trending_up), label: 'Position'),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: 'Holding'),
        ],
      ),
    );
  }
}