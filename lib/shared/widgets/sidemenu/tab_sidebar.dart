import 'package:core_dashboard/services/menu_service.dart';
import 'package:core_dashboard/shared/constants/config.dart';
import 'package:core_dashboard/shared/constants/defaults.dart';
import 'package:core_dashboard/shared/constants/gaps.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import 'icon_tile.dart';

class TabSidebar extends StatefulWidget {
  const TabSidebar({super.key});

  @override
  TabSidebarState createState() => TabSidebarState();
}

class TabSidebarState extends State<TabSidebar> {
  List<dynamic> menuItems = [];
  final MenuService menuService = MenuService();

  @override
  void initState() {
    super.initState();
    loadMenuItems();
  }

  Future<void> loadMenuItems() async {
    final data = await menuService.fetchMenuItems();
    setState(() {
      menuItems = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 96,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppDefaults.padding,
                vertical: AppDefaults.padding * 1.5),
            child: SvgPicture.asset(AppConfig.logo),
          ),
          gapH16,
          Expanded(
            child: SizedBox(
              width: 48,
              child: menuItems.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : ListView(
                      //crossAxisAlignment: CrossAxisAlignment.center,
                      children: menuItems.map((menuItem) {
                        return Column(
                          children: [
                            IconTile(
                              iconSrc: menuItem['icon'],
                              onPressed: () {
                                context.go(menuItem['route']);
                              },
                            ),
                            const SizedBox(height: 8.0)
                          ],
                        );
                      }).toList(),
                    ),
            ),
          ),
          // Column(
          //   children: [
          //     IconTile(
          //       isActive: false,
          //       activeIconSrc: "assets/icons/arrow_forward_light.svg",
          //       onPressed: () {},
          //     ),
          //     const SizedBox(
          //       width: 48,
          //       child: Divider(thickness: 2),
          //     ),
          //     gapH4,
          //     IconTile(
          //       isActive: false,
          //       activeIconSrc: "assets/icons/help_light.svg",
          //       onPressed: () {},
          //     ),
          //     gapH4,
          //     ThemeIconTile(
          //       isDark: false,
          //       onPressed: () {},
          //     ),
          //     gapH16,
          //   ],
          // )
        ],
      ),
    );
  }
}
