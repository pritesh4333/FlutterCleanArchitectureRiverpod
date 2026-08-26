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

  static const List<_NavData> _navItems = [
    _NavData(icon: Icons.visibility, label: 'Watchlist'),
    _NavData(icon: Icons.receipt_long, label: 'Orderbook'),
    _NavData(icon: Icons.calendar_month, label: 'Sipbook'),
    _NavData(icon: Icons.trending_up, label: 'Position'),
    _NavData(icon: Icons.account_balance_wallet, label: 'Holding'),
  ];

  // shared by both BottomNavigationBar and Drawer taps
  void _onSelectTab(WidgetRef ref, int selectedIndex, int index) {
    if (selectedIndex == index) return;

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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(bottomNavProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface, // pin explicitly
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        scrolledUnderElevation: 0,
        title: Text(_navItems[selectedIndex].label),
        foregroundColor: Colors.black,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'Stock Holding',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            ...List.generate(_navItems.length, (index) {
              final item = _navItems[index];
              return ListTile(
                leading: Icon(item.icon),
                title: Text(item.label),
                selected: selectedIndex == index,
                selectedTileColor: Colors.blue.withOpacity(0.1),
                onTap: () {
                  _onSelectTab(ref, selectedIndex, index);
                  Navigator.pop(context); // close drawer after selecting
                },
              );
            }),
          ],
        ),
      ),
      body: IndexedStack(index: selectedIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        currentIndex: selectedIndex,
        onTap: (index) => _onSelectTab(ref, selectedIndex, index),
        items: _navItems
            .map((item) => BottomNavigationBarItem(
          icon: Icon(item.icon),
          label: item.label,
        ))
            .toList(),
      ),
    );
  }
}

class _NavData {
  final IconData icon;
  final String label;
  const _NavData({required this.icon, required this.label});
}