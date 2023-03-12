import 'package:carrotmarket/constants/gaps.dart';
import 'package:carrotmarket/constants/sizes.dart';
import 'package:flutter/material.dart';

class NavTab extends StatelessWidget {
  final bool isSelected;
  final IconData icon, selectedIcon;
  final String tabText;

  const NavTab({
    super.key,
    required this.isSelected,
    required this.icon,
    required this.selectedIcon,
    required this.tabText,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 500),
        opacity: isSelected ? 1 : 0.6,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Icon(
                isSelected ? selectedIcon : icon,
                size: Sizes.size32,
                color: Colors.white,
              ),
            ),
            Gaps.v3,
            Expanded(
              flex: 1,
              child: Text(
                tabText,
                style: const TextStyle(
                  color: Colors.white,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
