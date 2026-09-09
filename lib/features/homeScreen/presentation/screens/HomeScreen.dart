import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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
import '../../../theam/presentation/providers/theme_providers.dart';
import 'ExitConfirmationWrapper.dart';

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
    _NavData(icon: Icons.exit_to_app, label: 'Exit'),
  ];

  // shared by both BottomNavigationBar and Drawer taps
  void _onSelectTab(BuildContext context,WidgetRef ref, int selectedIndex, int index) {
    if (selectedIndex == index) return;
// Handle Exit separately — don't touch tab state or invalidate controllers
    if (index == 5) {
      if (Platform.isIOS) {
        // iOS convention: don't offer an in-app exit action at all
        context.go('/');
      }
      showExitConfirmationDialog(context, ref);
      return;
    }
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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return ExitConfirmationWrapper(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: colorScheme.surface,
          surfaceTintColor: Colors.transparent,
          shadowColor: Colors.transparent,
          scrolledUnderElevation: 0,
          title: Text(_navItems[selectedIndex].label),
          foregroundColor: colorScheme.onSurface, // ✅ adapts to light/dark
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(color: colorScheme.primary),
                child: Text(
                  'Stock Holding',
                  style: TextStyle(color: colorScheme.onPrimary, fontSize: 20),
                ),
              ),
              ...List.generate(_navItems.length, (index) {
                final item = _navItems[index];
                return ListTile(
                  leading: Icon(item.icon),
                  title: Text(item.label),
                  selected: selectedIndex == index,
                  selectedTileColor: colorScheme.primary.withOpacity(0.1), // ✅
                  onTap: () {
                    Navigator.pop(context);
                    _onSelectTab(context, ref, selectedIndex, index);
                  },
                );
              }),
              const Divider(),
              Consumer(
                builder: (context, ref, _) {
                  final themeMode = ref.watch(themeControllerProvider);
                  final isDark = themeMode == ThemeMode.dark;
                  return SwitchListTile(
                    secondary: Icon(isDark ? Icons.dark_mode : Icons.light_mode),
                    title: const Text('Dark Mode'),
                    value: isDark,
                    onChanged: (value) {
                      ref.read(themeControllerProvider.notifier).toggleTheme(value);
                    },
                  );
                },
              ),
            ],
          ),
        ),
        body: IndexedStack(index: selectedIndex, children: _pages),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: colorScheme.surface,      // ✅ adapts
          selectedItemColor: colorScheme.primary,     // ✅ adapts
          unselectedItemColor: colorScheme.onSurface.withOpacity(0.6), // ✅ adapts
          currentIndex: selectedIndex,
          onTap: (index) => _onSelectTab(context, ref, selectedIndex, index),
          items: _navItems
              .map((item) => BottomNavigationBarItem(icon: Icon(item.icon), label: item.label))
              .toList(),
        ),
      ),
    );
  }
}

class _NavData {
  final IconData icon;
  final String label;
  const _NavData({required this.icon, required this.label});
}