import 'package:flutter/material.dart';
import 'dart:ui';

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
    final items = <_GlassNavItemData>[
      const _GlassNavItemData(
        icon: Icons.home_outlined,
        selectedIcon: Icons.home,
        label: 'Home',
      ),
      const _GlassNavItemData(
        icon: Icons.search,
        selectedIcon: Icons.search,
        label: 'Search',
      ),
      const _GlassNavItemData(
        icon: Icons.favorite_border,
        selectedIcon: Icons.favorite,
        label: 'Likes',
      ),
      const _GlassNavItemData(
        icon: Icons.person_outline,
        selectedIcon: Icons.person,
        label: 'Account',
      ),
    ];

    return Container(
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 30),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.62),
                borderRadius: BorderRadius.circular(28),
              ),
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Row(
                children: List.generate(items.length, (index) {
                  final item = items[index];
                  final isSelected = currentIndex == index;
    
                  return Expanded(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(22),
                      onTap: () => onTap(index),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 260),
                        curve: Curves.easeOutCubic,
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 6,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: isSelected
                              ? Colors.white.withValues(alpha: 0.12)
                              : Colors.transparent,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 220),
                              child: Icon(
                                isSelected ? item.selectedIcon : item.icon,
                                key: ValueKey('${item.label}_$isSelected'),
                                color: isSelected
                                    ? Colors.white
                                    : Colors.white.withValues(alpha: 0.72),
                                size: 24,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              item.label,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.w500,
                                color: isSelected
                                    ? Colors.white
                                    : Colors.white.withValues(alpha: 0.72),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _GlassNavItemData {
  final IconData icon;
  final IconData selectedIcon;
  final String label;

  const _GlassNavItemData({
    required this.icon,
    required this.selectedIcon,
    required this.label,
  });
}
