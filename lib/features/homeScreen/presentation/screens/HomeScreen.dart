import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:stockholding/core/widgets/CommanWidgets.dart';
import 'package:stockholding/features/homeScreen/presentation/controllers/home_screen_controllers.dart';
import 'package:stockholding/features/holding/presentation/controllers/holding_controller.dart';
import 'package:stockholding/features/holding/presentation/screens/holding_screen.dart';
import 'package:stockholding/features/homeScreen/domain/entity/GetSetIndex.dart';
import 'package:stockholding/features/orderbook/presentation/controllers/orderBook_controller.dart';
import 'package:stockholding/features/orderbook/presentation/screens/orderBook_screen.dart';
import 'package:stockholding/features/position/presentation/controllers/position_controller.dart';
import 'package:stockholding/features/sipbook/presentation/controllers/sipBook_controller.dart';
import 'package:stockholding/features/sipbook/presentation/screens/sipBook_screen.dart';
import 'package:stockholding/features/watchlist/presentation/controllers/wlDetails_controller.dart';
import 'package:stockholding/features/watchlist/presentation/screens/watchlist_screen.dart';
import '../../../../core/theam/app_fonts.dart';
import '../../../../core/theam/theme_picker.dart';
import '../../../position/presentation/screens/position_screen.dart';
import '../controllers/indices_controllers.dart';
import '../provider/indices_provider.dart';
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

  void _onSelectTab(
    BuildContext context,
    WidgetRef ref,
    int selectedIndex,
    int index,
  ) {
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
  static final List<GetSetIndex> defaultIndexList=[];
   static void fillDefaultIndexList() {
    // build() can run many times; only populate once so we don't duplicate
    // every index on each rebuild.
    if (defaultIndexList.isNotEmpty) return;
    GetSetIndex getSetIndex = GetSetIndex();
    getSetIndex.label = 'NIFTY 50';
    getSetIndex.id = 13;
    getSetIndex.underLyingIdS = 26000;

    getSetIndex.selected = true;
    getSetIndex.exch = 'NSE';
    getSetIndex.segment = 'E';

    defaultIndexList.add(getSetIndex);

    getSetIndex = GetSetIndex();
    getSetIndex.label = 'SENSEX';
    getSetIndex.id = 51;
    getSetIndex.underLyingIdS = 1;

    getSetIndex.exch = 'BSE';
    getSetIndex.segment = 'E';
    getSetIndex.selected = true;
    defaultIndexList.add(getSetIndex);

    getSetIndex = GetSetIndex();
    getSetIndex.label = 'BANKEX';
    getSetIndex.id = 69;
    getSetIndex.underLyingIdS = 12;
    getSetIndex.exch = 'BSE';
    getSetIndex.segment = 'E';
    getSetIndex.selected = false;
    defaultIndexList.add(getSetIndex);

    getSetIndex = GetSetIndex();
    getSetIndex.label = 'BANK NIFTY';
    getSetIndex.id = 25;
    getSetIndex.underLyingIdS = 26009;
    getSetIndex.exch = 'NSE';
    getSetIndex.segment = 'E';
    getSetIndex.selected = true;
    defaultIndexList.add(getSetIndex);

    getSetIndex = GetSetIndex();
    getSetIndex.label = 'FIN NIFTY';
    getSetIndex.id = 27;
    getSetIndex.underLyingIdS = 26037;
    getSetIndex.exch = 'NSE';
    getSetIndex.segment = 'E';
    getSetIndex.selected = false;
    defaultIndexList.add(getSetIndex);

    getSetIndex = GetSetIndex();
    getSetIndex.label = 'MIDCAP NIFTY';
    getSetIndex.id = 442;
    getSetIndex.underLyingIdS = 26074;
    getSetIndex.exch = 'NSE';
    getSetIndex.segment = 'E';
    getSetIndex.selected = false;
    defaultIndexList.add(getSetIndex);

    // getSetIndex = GetSetIndex();
    // getSetIndex.label = 'NIFTY 100';
    // getSetIndex.id = 17;
    // getSetIndex.underLyingIdS = 531275;
    // getSetIndex.exch = 'NSE';
    // getSetIndex.segment = 'E';
    // getSetIndex.selected = false;
    // defaultIndexList.add(getSetIndex);
    //
    // getSetIndex = GetSetIndex();
    // getSetIndex.label = 'NIFTY 200';
    // getSetIndex.id = 18;
    // getSetIndex.underLyingIdS = 523422;
    // getSetIndex.exch = 'NSE';
    // getSetIndex.segment = 'E';
    // getSetIndex.selected = false;
    // defaultIndexList.add(getSetIndex);
    //
    // getSetIndex = GetSetIndex();
    // getSetIndex.label = "NIFTY MIDCAP 50";
    // getSetIndex.id = 20;
    // getSetIndex.underLyingIdS = 20;
    // getSetIndex.exch = 'NSE';
    // getSetIndex.segment = 'E';
    // getSetIndex.selected = false;
    // defaultIndexList.add(getSetIndex);
    //
    // getSetIndex = GetSetIndex();
    // getSetIndex.label = 'NIFTY MIDCAP 100';
    // getSetIndex.id = 37;
    // getSetIndex.underLyingIdS = 531772;
    // getSetIndex.exch = 'NSE';
    // getSetIndex.segment = 'E';
    // getSetIndex.selected = false;
    //
    // defaultIndexList.add(getSetIndex);
    //
    // getSetIndex = GetSetIndex();
    // getSetIndex.label = "NIFTY SMALLCAP 50";
    // getSetIndex.id = 22;
    // getSetIndex.underLyingIdS = 513204;
    // getSetIndex.exch = 'NSE';
    // getSetIndex.segment = 'E';
    // getSetIndex.selected = false;
    // defaultIndexList.add(getSetIndex);
    //
    // getSetIndex = GetSetIndex();
    // getSetIndex.label = 'NIFTY SMALLCAP 100';
    // getSetIndex.id = 5;
    // getSetIndex.underLyingIdS = 5;
    // getSetIndex.exch = 'NSE';
    // getSetIndex.segment = 'E';
    // getSetIndex.selected = false;
    // defaultIndexList.add(getSetIndex);
    //
    // getSetIndex = GetSetIndex();
    // getSetIndex.label = 'NIFTY IT';
    // getSetIndex.id = 29;
    // getSetIndex.underLyingIdS = 26008;
    // getSetIndex.exch = 'NSE';
    // getSetIndex.segment = 'E';
    // getSetIndex.selected = false;
    // defaultIndexList.add(getSetIndex);
    //
    //
    //
    // getSetIndex = GetSetIndex();
    // getSetIndex.label = 'NIFTY AUTO';
    // getSetIndex.id = 14;
    // getSetIndex.underLyingIdS = 512457;
    // getSetIndex.exch = 'NSE';
    // getSetIndex.segment = 'E';
    // getSetIndex.selected = false;
    // defaultIndexList.add(getSetIndex);
    //
    // getSetIndex = GetSetIndex();
    // getSetIndex.label = 'BSE IT';
    // getSetIndex.id = 74;
    // getSetIndex.underLyingIdS = 1006;
    // getSetIndex.exch = 'BSE';
    // getSetIndex.segment = 'E';
    // getSetIndex.selected = false;
    // defaultIndexList.add(getSetIndex);
    //
    //
    //
    //
    //
    //
    //
    // getSetIndex = GetSetIndex();
    // getSetIndex.label = 'MIDCAP';
    // getSetIndex.id = 64;
    // getSetIndex.underLyingIdS = 1127;
    // getSetIndex.exch = 'BSE';
    // getSetIndex.segment = 'E';
    // getSetIndex.selected = false;
    // defaultIndexList.add(getSetIndex);
    //
    // getSetIndex = GetSetIndex();
    // getSetIndex.label = 'SMALLCAP';
    // getSetIndex.id = 82;
    // getSetIndex.underLyingIdS = 82;
    // getSetIndex.exch = 'BSE';
    // getSetIndex.segment = 'E';
    // getSetIndex.selected = false;
    // defaultIndexList.add(getSetIndex);
    //
    // getSetIndex = GetSetIndex();
    // getSetIndex.label = 'OILGAS';
    // getSetIndex.id = 76;
    // getSetIndex.underLyingIdS = 1126;
    // getSetIndex.exch = 'BSE';
    // getSetIndex.segment = 'E';
    // getSetIndex.selected = false;
    // defaultIndexList.add(getSetIndex);
    //
    // getSetIndex = GetSetIndex();
    // getSetIndex.label = 'REALITY INDEX';
    // getSetIndex.id = 79;
    // getSetIndex.underLyingIdS = 79;
    // getSetIndex.exch = 'BSE';
    // getSetIndex.segment = 'E';
    // getSetIndex.selected = false;
    // defaultIndexList.add(getSetIndex);
  }


   @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(bottomNavProvider);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final socketController = ref.read(indicesSocketControllerProvider);
    fillDefaultIndexList();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // TODO: this should come from the same source as entityId used
      // elsewhere in the app (currently hardcoded there too) — replace
      // with a real client ID once that's threaded through properly.
      socketController.startBrodcast(listGetSetIndex: defaultIndexList);
    });
    return ExitConfirmationWrapper(
      child: Scaffold(
        appBar: PreferredSize(
          // strip height + standard toolbar height
          preferredSize: const Size.fromHeight(kToolbarHeight + _stripHeight),
          child: SafeArea(
            bottom: false, // only the top inset matters here
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 👇 Live Nifty / Sensex strip, above the app bar
                Container(
                  height: _stripHeight,
                  width: double.infinity,
                  color: colorScheme.surface,
                  alignment: Alignment.centerLeft,
                  child: const _IndicesStrip(),
                ),
                AppBar(
                  backgroundColor: colorScheme.surface,
                  surfaceTintColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  scrolledUnderElevation: 0,
                  title: CommonText(
                    _navItems[selectedIndex].label,
                    fontFamily: AppFonts.fontName,
                    fontWeight: FontWeight.w200,
                    fontSize: 15,
                    color: Colors.black,
                  ),
                  foregroundColor: colorScheme.onSurface,
                  leading: Builder(
                    builder: (context) => IconButton(
                      icon: const Icon(Icons.menu),
                      onPressed: () => Scaffold.of(context).openDrawer(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(color: Colors.grey),
                child: CommonText(
                  'Stock Holding',
                  fontFamily: AppFonts.fontName,
                  fontWeight: FontWeight.w200,
                  // 👈 bold — maps to RethinkSans-Bold.ttf
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
              ...List.generate(_navItems.length, (index) {
                final item = _navItems[index];
                return ListTile(
                  leading: Icon(item.icon),
                  title: CommonText(
                    item.label,
                    fontFamily: AppFonts.fontName,
                    fontWeight: FontWeight.w200,
                    // 👈 bold — maps to RethinkSans-Bold.ttf
                    fontSize: 15,
                    color: Colors.black,
                  ),
                  selected: selectedIndex == index,
                  selectedTileColor: colorScheme.primary.withOpacity(0.1),
                  // ✅
                  onTap: () {
                    Navigator.pop(context);
                    _onSelectTab(context, ref, selectedIndex, index);
                  },
                );
              }),
              const Divider(),
              Padding(padding: EdgeInsets.all(16), child: ThemePicker()),
            ],
          ),
        ),
        body: IndexedStack(index: selectedIndex, children: _pages),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: colorScheme.surface,
          // ✅ adapts
          selectedItemColor: colorScheme.primary,
          // ✅ adapts
          unselectedItemColor: colorScheme.onSurface.withOpacity(0.6),
          // ✅ adapts
          currentIndex: selectedIndex,
          onTap: (index) => _onSelectTab(context, ref, selectedIndex, index),
          items: _navItems
              .sublist(0, _navItems.length - 1)
              .map(
                (item) => BottomNavigationBarItem(
                  icon: Icon(item.icon),
                  label: item.label,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

/// Height of the live indices strip shown above the app bar.
const double _stripHeight = 28;

/// Listens DIRECTLY to the shared indicesNotifierSingleton (a StateNotifier)
/// via addListener/setState — no Riverpod ref, no provider, no container.
/// This sidesteps the multiple-ProviderContainer problem entirely: it reads
/// and rebuilds from the exact same object the socket parser writes to.
class _IndicesStrip extends StatefulWidget {
  const _IndicesStrip();

  @override
  State<_IndicesStrip> createState() => _IndicesStripState();
}

class _IndicesStripState extends State<_IndicesStrip> {
  // StateNotifier.addListener returns a function that removes the listener.
  RemoveListener? _removeListener;

  @override
  void initState() {
    super.initState();
    // fireImmediately gives us the current snapshot right away.
    _removeListener = indicesNotifierSingleton.addListener(_onQuotesChanged);
  }

  @override
  void dispose() {
    _removeListener?.call();
    super.dispose();
  }

  void _onQuotesChanged(Map<String, IndexQuote> _) {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final indexQuotes = indicesNotifierSingleton.quotes;
    final list = HomeScreen.defaultIndexList;

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      itemCount: list.length,
      itemBuilder: (context, index) {
        final GetSetIndex item = list[index];
        final quote = indexQuotes['0|${item.id}'];
        final ltpText = quote != null ? quote.ltp.toStringAsFixed(2) : '--';
        // Green when up (or flat) vs previous close, red when down.
        final isUp = quote == null || quote.change >= 0;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: _indexTile(item.label.toString(), ltpText, isUp: isUp),
        );
      },
    );
  }
}

Widget _indexTile(String name, String value, {required bool isUp}) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      CommonText(
        '$name  ',
        fontSize: 13,
        color: Colors.black87,
        fontWeight: FontWeight.w200,
        fontFamily: AppFonts.fontName,
      ),
      CommonText(
        value,
        fontSize: 13,
        color: isUp ? Colors.green : Colors.red,
        fontWeight: FontWeight.w200,
        fontFamily: AppFonts.fontName,
      ),
    ],
  );
}

class _NavData {
  final IconData icon;
  final String label;

  const _NavData({required this.icon, required this.label});
}
