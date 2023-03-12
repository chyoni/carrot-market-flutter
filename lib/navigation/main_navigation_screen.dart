import 'package:carrotmarket/constants/sizes.dart';
import 'package:carrotmarket/features/items/item_sale_list_screen.dart';
import 'package:carrotmarket/navigation/widgets/nav_tab.dart';
import 'package:flutter/material.dart';

class MainNavigationScreen extends StatefulWidget {
  static const String routeName = "mainNavigation";
  final String tab;
  const MainNavigationScreen({super.key, required this.tab});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  final List<String> _tabs = [
    "home",
    "community",
    "gps",
    "chat",
    "profile",
  ];
  late final int _selectedIndex = _tabs.indexOf(widget.tab);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Offstage(
            offstage: _selectedIndex != 0,
            child: const ItemSaleListScreen(),
          )
        ],
      ),
      bottomNavigationBar: Container(
        height: MediaQuery.of(context).size.height / 10,
        padding: const EdgeInsets.only(
          bottom: Sizes.size1,
        ),
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(Sizes.size10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NavTab(
                  isSelected: _selectedIndex == 0,
                  icon: Icons.home,
                  selectedIcon: Icons.home,
                  tabText: "홈"),
              NavTab(
                  isSelected: _selectedIndex == 1,
                  icon: Icons.library_books,
                  selectedIcon: Icons.library_books,
                  tabText: "동네생활"),
              NavTab(
                  isSelected: _selectedIndex == 2,
                  icon: Icons.pin_drop_outlined,
                  selectedIcon: Icons.pin_drop_rounded,
                  tabText: "내 근처"),
              NavTab(
                  isSelected: _selectedIndex == 3,
                  icon: Icons.chat_bubble_outline,
                  selectedIcon: Icons.chat_bubble,
                  tabText: "채팅"),
              NavTab(
                  isSelected: _selectedIndex == 4,
                  icon: Icons.person_outlined,
                  selectedIcon: Icons.person,
                  tabText: "나의 당근"),
            ],
          ),
        ),
      ),
    );
  }
}
