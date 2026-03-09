import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class GegabyteBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const GegabyteBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SalomonBottomBar(
      selectedColorOpacity: 0.1,
      unselectedItemColor: Colors.white,
      selectedItemColor: Colors.white,
      currentIndex: currentIndex,
      onTap: onTap,
      backgroundColor: Colors.black,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      itemPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 100),
      items:  [
        SalomonBottomBarItem(
          icon: Icon(Icons.home_outlined, size: 32),
          title: Text("Home"),
        ),
        SalomonBottomBarItem(
          icon: Icon(Icons.search, size: 32),
          title: Text("Search"),
        ),
        SalomonBottomBarItem(
          icon: Icon(Icons.favorite, size: 32),
          title: Text("Likes"),
        ),
        SalomonBottomBarItem(
          icon: Icon(Icons.person_outline, size: 32),
          title: Text("Account"),
        ),
      ],
    );
  }
}
