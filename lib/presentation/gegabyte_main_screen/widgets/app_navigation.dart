import 'package:flutter/material.dart';
import 'package:gegabyteauto/presentation/gegabyte_main_screen/gegabyte_main_screen.dart';
import 'package:gegabyteauto/presentation/gegabyte_main_screen/widgets/gegabyte_bottom_nav_bar.dart';

/// Shell containing a nested navigator and persistent bottom bar.
class AppShell extends StatefulWidget {
  const AppShell({Key? key}) : super(key: key);

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    Nav.registerRootKey(_navigatorKey);
  }

  void _onTabChanged(int newIndex) {
    setState(() => _currentIndex = newIndex);
    _navigatorKey.currentState?.pushReplacement(MaterialPageRoute(
      builder: (_) => _tabPage(newIndex),
    ));
  }

  Widget _tabPage(int index) {
    switch (index) {
      case 0:
        return const GegabyteMainScreen();
      case 1:
        return const GegabyteMainScreen();
      case 2:
        return const GegabyteMainScreen();
      case 3:
        return const GegabyteMainScreen();
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Navigator(
        key: _navigatorKey,
        onGenerateRoute: (settings) =>
            MaterialPageRoute(builder: (_) => _tabPage(_currentIndex)),
      ),
      bottomNavigationBar: GegabyteBottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onTabChanged,
      ),
    );
  }
}

class Nav {
  static GlobalKey<NavigatorState>? _rootKey;

  static void registerRootKey(GlobalKey<NavigatorState> key) {
    _rootKey = key;
  }

  static Future<T?> push<T>(Widget page) {
    if (_rootKey?.currentState != null) {
      return _rootKey!.currentState!.push<T>(
        MaterialPageRoute(builder: (_) => page),
      );
    }
    throw Exception('AppShell navigator not registered');
  }
}
