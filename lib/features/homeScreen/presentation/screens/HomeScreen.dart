import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stockholding/features/HomeScreen/presentation/controllers/home_screen_controllers.dart';
import 'package:stockholding/features/holding/presentation/screens/holding_screen.dart';
import 'package:stockholding/features/orderbook/presentation/screens/orderBook_screen.dart';
import 'package:stockholding/features/watchlist/presentation/screens/watchlist_screen.dart';

import '../../../position/presentation/screens/position_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  static const List<Widget> _pages = [WatchlistScreen(), OrderBookScreen(),PositionScreen(),HoldingScreen()];

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
          ref.read(bottomNavProvider.notifier).changeTab(index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.visibility),
            label: 'Watchlist',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: 'Orderbook',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.trending_up),
            label: 'Position',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet),
            label: 'Holding',
          ),
        ],
      ),
    );
  }
}
